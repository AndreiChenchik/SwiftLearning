//
//  ViewController.swift
//  Project10
//
//  Created by Andrei Chenchik on 30/5/21.
//

import LocalAuthentication
import UIKit

class ViewController: UICollectionViewController {
    var people = [Person]()

    fileprivate func loadPeople() {
        let defaults = UserDefaults.standard

        if let savedPeople = defaults.object(forKey: "people") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                people = try jsonDecoder.decode([Person].self, from: savedPeople)
            } catch {
                fatalError(error.localizedDescription)
            }
        }

        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let letBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        navigationItem.leftBarButtonItem = letBarButton

        title = "Names to Faces"

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(lockData), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(authenticateUser), name: UIApplication.didBecomeActiveNotification, object: nil)
        authenticateUser()

    }

    @objc func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, _ in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockScreen()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            if KeychainWrapper.standard.string(forKey: "Password") != nil {
                checkPassword()
            } else {
                let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication; Do you want to use a password instead?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                ac.addAction(UIAlertAction(title: "Create password", style: .default, handler: createPassword))
                present(ac, animated: true)
            }
        }
    }

    func checkPassword() {
        guard let password = KeychainWrapper.standard.string(forKey: "Password") else { return }
        let ac = UIAlertController(title: "Enter password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Reveal", style: .default, handler: { [weak ac, weak self] _ in
            guard let userPassword = ac?.textFields?[0].text else { return }

            if userPassword == password {
                self?.unlockScreen()
            } else {
                self?.wrongPassword()
            }

        }))
        present(ac, animated: true)
    }

    func wrongPassword() {
        let ac = UIAlertController(title: "Wrong password", message: "You could not be verified; please try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Try again...", style: .default, handler: { [weak self] _ in
            self?.checkPassword()
        }))
        present(ac, animated: true)
    }

    func createPassword(_ action: UIAlertAction) {
        let ac = UIAlertController(title: "Create password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak ac, weak self] _ in
            guard let password = ac?.textFields?[0].text else { return }
            guard !password.isEmpty else { return }
            KeychainWrapper.standard.set(password, forKey: "Password")
            self?.authenticateUser()
        }))
        present(ac, animated: true)
    }

    func unlockScreen() {
        loadPeople()
    }

    @objc func lockData() {
        people = [Person]()
        collectionView.reloadData()
    }

    @objc func addNewPerson() {
        let picker = UIImagePickerController()

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            picker.sourceType = .photoLibrary
        }

        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath)
                as? PersonCell else { fatalError("Can't deque cell") }

        let person = people[indexPath.item]

        cell.name.text = person.name

        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)

        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]

        let renameAC = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        renameAC.addTextField()
        renameAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        renameAC.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak renameAC] _ in
            guard let newName = renameAC?.textFields?[0].text else { return }
            person.name = newName
            self?.save()

            self?.collectionView.reloadItems(at: [indexPath])
        }))

        let renameOrDeleteAC = UIAlertController(title: "Select action",
                                                 message: "What do you want to do with that person?",
                                                 preferredStyle: .alert)
        renameOrDeleteAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        renameOrDeleteAC.addAction(UIAlertAction(title: "Rename", style: .default) { [weak self] _ in
            self?.present(renameAC, animated: true)
        })
        renameOrDeleteAC.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.people.remove(at: indexPath.item)
            self?.save()
            self?.collectionView.deleteItems(at: [indexPath])
        })

        present(renameOrDeleteAC, animated: true)

    }

    func save() {
        let jsonEncoder = JSONEncoder()

        guard let savedData = try? jsonEncoder.encode(people) else { fatalError("Can't save people") }

        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }

        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        save()

        let indexPath = IndexPath(row: people.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])

        picker.dismiss(animated: true, completion: nil)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }

}
