import UIKit

// MARK: - NewRecordViewControllerDelegate
protocol NewRecordViewControllerDelegate: AnyObject {
    func add(_ record: NotepadRecord)
}

// MARK: - NewRecordViewController
final class NewRecordViewController: UIViewController {
    
    weak var delegate: NewRecordViewControllerDelegate?
    
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let textField = UITextField()
    private let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboard()
        setupUI()
        setupLayout()
    }
    
    private func configureKeyboard() {
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(didTapDone))
        ]
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
    }

    @objc private func didTapDone() {
        delegate?.add(
            Record(title: textField.text ?? "", body: textView.text ?? "")
        )
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "Заголовок"
        bodyLabel.text = "Текст"
        
        [titleLabel, bodyLabel].forEach {
            view.addSubview($0)
            $0.font = .preferredFont(forTextStyle: .headline)
        }
        
        [textField, textView].forEach {
            view.addSubview($0)
            $0.backgroundColor = .black.withAlphaComponent(0.02)
            $0.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor;
            $0.layer.borderWidth = 1;
            $0.layer.cornerRadius = 4;            
        }
        
        textField.font = .preferredFont(forTextStyle: .body)
        textView.font = .preferredFont(forTextStyle: .body)
    }
        
    private func setupLayout() {
        
        [titleLabel, bodyLabel, textField, textView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let margin4 = CGFloat(4)
        let margin24 = CGFloat(24)
        let margin32 = CGFloat(32)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2 * margin24),
            titleLabel.heightAnchor.constraint(equalToConstant: margin32),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin24),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: margin24)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin4),
            textField.heightAnchor.constraint(equalToConstant: margin32),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin24),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: margin24)
        ])
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: margin24),
            bodyLabel.heightAnchor.constraint(equalToConstant: margin32),
            bodyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin24),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: bodyLabel.trailingAnchor, constant: margin24)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: margin4),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin24),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: margin24),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: margin24)
        ])
    }
}
