import UIKit

// MARK: - MainViewController
final class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private lazy var dataProvider: DataProviderProtocol? = {
        let notepadDataStore = (UIApplication.shared.delegate as! AppDelegate).notepadDataStore
        do {
            try dataProvider = DataProvider(notepadDataStore, delegate: self)
            return dataProvider
        } catch {
            showError("Данные недоступны.")
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.topItem?.title = "Блокнот"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAddButton))
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc
    private func didTapAddButton(_ sender: UIBarButtonItem) {
        showNewRecordViewController()
    }
    
    private func showNewRecordViewController() {
        let viewControllerToPresent = NewRecordViewController()
        viewControllerToPresent.delegate = self
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
}

// MARK: - NewRecordViewControllerDelegate
extension MainViewController: NewRecordViewControllerDelegate {
    func add(_ record: NotepadRecord) {
        try? dataProvider?.addRecord(record)
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let record = dataProvider?.object(at: indexPath) else { return UITableViewCell() }
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "NotepadCell")
        cell.textLabel?.text = record.title
        cell.detailTextLabel?.text = record.body
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataProvider?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataProvider?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        try? dataProvider?.deleteRecord(at: indexPath)
    }
}

// MARK: - DataProviderDelegate
extension MainViewController: DataProviderDelegate {
    func didUpdate(_ update: NotepadStoreUpdate) {
        tableView.performBatchUpdates {
            let insertedIndexPaths = update.insertedIndexes.map { IndexPath(item: $0, section: 0) }
            let deletedIndexPaths = update.deletedIndexes.map { IndexPath(item: $0, section: 0) }
            tableView.insertRows(at: insertedIndexPaths, with: .automatic)
            tableView.deleteRows(at: deletedIndexPaths, with: .fade)
        }
    }
}
