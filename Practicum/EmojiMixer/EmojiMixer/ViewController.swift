//
//  ViewController.swift
//  EmojiMixer
//
//  Created by Andrei Chenchik on 22/1/23.
//

import UIKit

class ViewController: UIViewController {
    private var emojis: [String] = []
    private let possibleEmojis = [
        "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓",
        "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒",
        "🥬", "🥦", "🧄", "🧅", "🍄"
    ]

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    private let undoButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Undo", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    private let addButton: UIButton = {
        let button = UIButton()

        button.setTitle("+", for: .normal)
        button.setTitleColor(.blue, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureCollection()
        configureViews()
        configureActions()
    }
}

class EmojiCell: UICollectionViewCell {
    let titleLabel = UILabel()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

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

        hStack.addArrangedSubview(undoButton)
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func configureActions() {
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        undoButton.addTarget(self, action: #selector(undo), for: .touchUpInside)
    }
}

extension ViewController {
    @objc func add() {
        guard let emoji = possibleEmojis.randomElement() else { return }

        let count = emojis.count
        emojis.append(emoji)

        collectionView.performBatchUpdates {
            collectionView.insertItems(at: [.init(row: count, section: 0)])
        }
    }

    @objc func undo() {
        guard emojis.count > 0 else { return }

        emojis.removeLast()
        let count = emojis.count

        collectionView.performBatchUpdates {
            collectionView.deleteItems(at: [.init(row: count, section: 0)])
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
        return CGSize(width: collectionView.bounds.width / 2, height: 50)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        emojis.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as? EmojiCell else { return .init() }

        cell.titleLabel.text = emojis[indexPath.row]

        return cell
    }
}
