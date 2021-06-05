//
//  ViewController.swift
//  Milestone Project 25-27
//
//  Created by Andrei Chenchik on 5/6/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    
    var topLineText: String?
    var bottomLineText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Meme Generator"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle.angled"), style: .plain, target: self, action: #selector(addImage))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareImage))
        
        
        
        // Do any additional setup after loading the view.
    }

    @objc func addImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        imageView.image = image
        
        dismiss(animated: true) { [weak self] in
            self?.getTextFromUser()
        }
    }
    
    
    @objc func shareImage() {
        guard let image = imageView.image else {
            noImageAlert()
            return
        }
        
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(shareController, animated: true)
        
    }
    
    func getTextFromUser() {
        getTopLineText()
    }
    
    func getTopLineText() {
        let textAC = UIAlertController(title: "Enter top line text", message: nil, preferredStyle: .alert)
        textAC.addTextField()
        textAC.addAction(UIAlertAction(title: "Skip", style: .cancel, handler: { [weak self] _ in
            self?.getButtomLineText()
        }))
        textAC.addAction(UIAlertAction(title: "Save text", style: .default, handler: { [weak self, weak textAC] _ in
            defer {
                self?.getButtomLineText()
            }
            
            guard let text = textAC?.textFields?[0].text else { return }
            self?.topLineText = text
        }))
        present(textAC, animated: true)
    }
    
    func getButtomLineText() {
        let textAC = UIAlertController(title: "Enter buttom line text", message: nil, preferredStyle: .alert)
        textAC.addTextField()
        textAC.addAction(UIAlertAction(title: "Skip", style: .cancel, handler: { [weak self] _ in
            self?.drawText()
        }))
        textAC.addAction(UIAlertAction(title: "Save text", style: .default, handler: { [weak self, weak textAC] _ in
            defer {
                self?.drawText()
            }
            
            guard let text = textAC?.textFields?[0].text else { return }
            self?.bottomLineText = text
        }))
        present(textAC, animated: true)
    }
    
    func drawText() {
        guard let userImage = imageView.image else { return }
        guard topLineText != nil || bottomLineText != nil else { return }
        
        let height = userImage.size.height
        let width = userImage.size.width
        
        let textHeight = height * 0.2
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let image = renderer.image { ctx in
            userImage.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrsStroke: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: textHeight * 0.6),
                .strokeWidth: textHeight * 0.08,
                .strokeColor: UIColor.black,
                .paragraphStyle: paragraphStyle,
            ]
            
            let attrsFill: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: textHeight * 0.6),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle,
            ]
            
        
            if let topLineText = topLineText {
                let attributedStringStroke = NSAttributedString(string: topLineText, attributes: attrsStroke)
                attributedStringStroke.draw(with: CGRect(x: 0, y: textHeight * 0.4, width: width, height: textHeight), options: .usesLineFragmentOrigin, context: nil)
                let attributedStringFill = NSAttributedString(string: topLineText, attributes: attrsFill)
                attributedStringFill.draw(with: CGRect(x: 0, y: textHeight * 0.4, width: width, height: textHeight), options: .usesLineFragmentOrigin, context: nil)
            }
            
            if let bottomLineText = bottomLineText {
                let attributedStringStroke = NSAttributedString(string: bottomLineText, attributes: attrsStroke)
                attributedStringStroke.draw(with: CGRect(x: 0, y: height - textHeight, width: width, height: textHeight), options: .usesLineFragmentOrigin, context: nil)
                let attributedStringFill = NSAttributedString(string: bottomLineText, attributes: attrsFill)
                attributedStringFill.draw(with: CGRect(x: 0, y: height - textHeight, width: width, height: textHeight), options: .usesLineFragmentOrigin, context: nil)
            }
        }
        
        imageView.image = image
    }
    
    func noImageAlert() {
        let ac = UIAlertController(title: "No image", message: "Sorry, we can't share empty space :(", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

