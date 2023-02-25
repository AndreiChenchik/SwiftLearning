//
//  ViewController.swift
//  EmojiMixer
//
//  Created by Andrei Chenchik on 22/1/23.
//

import UIKit

class ViewController: UIViewController {
    private var visibleEmojiMixes: [EmojiMix] = []
    private lazy var emojiStore = EmojiMixStore(delegate: self)

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    private lazy var addButton: UIButton = {
        let button = UIButton()

        button.setTitle("+", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        button.addTarget(self, action: #selector(add), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        guard let emojis = try? emojiStore.fetchEmojiMixes() else {
            assertionFailure("CoreData is not Ready")
            return
        }

        visibleEmojiMixes = emojis

        configureCollection()
        configureViews()
    }
}

class EmojiCell: UICollectionViewCell {
    let titleLabel = UILabel()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 12
        clipsToBounds = true

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

private extension ViewController {
    func configureCollection() {
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func configureViews() {
        let hStack = UIStackView()
        let hStackMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        hStack.layoutMargins = hStackMargins
        hStack.isLayoutMarginsRelativeArrangement = true
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false

        hStack.addArrangedSubview(UIView())
        hStack.addArrangedSubview(addButton)

        view.addSubview(hStack)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: hStack.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController {
    @objc func add() {
        do {
            try emojiStore.addNewEmojiMix(.newMix)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UICollectionViewDelegate {}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        return CGSize(width: width, height: width)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        visibleEmojiMixes.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as? EmojiCell else { return .init() }

        cell.titleLabel.text = visibleEmojiMixes[indexPath.row].emojies
        cell.backgroundColor = visibleEmojiMixes[indexPath.row].backgroundColor

        return cell
    }
}

// MARK: - DataProviderDelegate
extension ViewController: EmojiMixStoreDelegate {
    func didUpdate(_ update: StoreUpdate) {
        guard let emojies = try? emojiStore.fetchEmojiMixes() else { return }

        visibleEmojiMixes = emojies

        collectionView.performBatchUpdates {
            let insertedIndexPaths = update.insertedIndexes.map { IndexPath(item: $0, section: 0) }
            let deletedIndexPaths = update.deletedIndexes.map { IndexPath(item: $0, section: 0) }
            collectionView.insertItems(at: insertedIndexPaths)
            collectionView.deleteItems(at: deletedIndexPaths)
        }
    }
}
