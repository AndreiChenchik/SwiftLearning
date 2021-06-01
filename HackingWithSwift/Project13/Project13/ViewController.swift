//
//  ViewController.swift
//  Project13
//
//  Created by Andrei Chenchik on 31/5/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var intensity: UISlider!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var radius: UISlider!
    
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "YACIFP"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        context = CIContext()
        
        let defaultFilter = "CISepiaTone"
        
        currentFilter = CIFilter(name: defaultFilter)
        filterButton.setTitle(defaultFilter, for: .normal)

    }

    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
    
        dismiss(animated: true)
        
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radius.value * 300, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let filterAC = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        filterAC.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        filterAC.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        filterAC.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        filterAC.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        filterAC.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        filterAC.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        filterAC.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        filterAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController = filterAC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        present(filterAC, animated: true)
    }
    
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        guard let actionTitle = action.title else { return }
        
        currentFilter = CIFilter(name: actionTitle)
        
        filterButton.setTitle(actionTitle, for: .normal)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        guard let image = imageView.image else {
            noImageError()
            return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func noImageError() {
        let errorAC = UIAlertController(title: "No image", message: "Sorry, there is no image to be saved", preferredStyle: .alert)
        errorAC.addAction(UIAlertAction(title: "Ok", style: .default))
        present(errorAC, animated: true)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let errorAC = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
            errorAC.addAction(UIAlertAction(title: "OK", style: .default))
            present(errorAC, animated: true)
        } else {
            let successAC = UIAlertController(title: "Saved!", message: "Your altered images has been saved to your photos.", preferredStyle: .alert)
            successAC.addAction(UIAlertAction(title: "OK", style: .default))
            present(successAC, animated: true)
        }
    }
    
    @IBAction func intencityChanged(_ sender: UISlider) {
        applyProcessing()
    }
    
    
    
}

