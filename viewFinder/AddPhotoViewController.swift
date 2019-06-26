//
//  AddPhotoViewController.swift
//  viewFinder
//
//  Created by Apple on 6/25/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
 var imagePicker = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func cameraButton(_ sender: UIButton){
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
        
    }
    @IBAction func albumButton(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func savePhotoTapped(_ sender: UIButton) {
        //if ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext) != nil {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let photoToSave = Photos(entity: Photos.entity(), insertInto: context)
            photoToSave.caption = textField.text
            
            if let userImage = imageView.image {
                if let userImageData = userImage.pngData() {
                    photoToSave.imageData = userImageData
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            navigationController?.popViewController(animated: true)
            
        }
        
    }
     
//    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//        let photoToSave = Photos(entity: Photos.entity(), insertInto: context)
//        photoToSave.caption = textField.text
//
//
//            if let userImage = imageView.image {
//                if let userImageData = userImage.pngData() {
//                    photoToSave.imageData = userImageData
//                }
//            }
//            (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
//                if let coreDataPhotos = try? context.fetch(Photos.fetchRequest()) as? [Photos] {
//                    photos = coreDataPhotos
//                    tableView.reloadData()
//            }
//        }
//        }
//
        
    
    
            
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
            
}




