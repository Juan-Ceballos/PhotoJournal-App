//
//  AddPhotoViewController.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

class AddPhotoViewController: UIViewController {

    let addPhotoView = AddPhotoView()
    
    var photoObject: PhotoObject?
    
    var selectedImage: UIImage? {
        didSet  {
            addPhotoView.selectedPhotoImageView.image = selectedImage
        }
    }
    
    private let imagePickerController = UIImagePickerController()
    private let dataPersistence = DataPersistence<PhotoObject>(filename: "photos.plist")
    
    override func loadView() {
        view = addPhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        imagePickerController.delegate = self
        addPhotoView.photoLibraryButton.addTarget(self, action: #selector(photoLibraryButtonPressed), for: .touchUpInside)
    }
    
    @objc func photoLibraryButtonPressed(_ sender: UIButton!) {
        showImageController(isCameraSelected: false)
    }
    
    @objc func saveButtonPressed(_ sender: UIButton)    {
        
        photoObject?.photoComment = "Hola"
        
        guard let photoToSave = photoObject else    {
            return
        }
                
        do {
            try dataPersistence.createItem(photoToSave)
        } catch {
            print("error")
        }
    }
    
    private func showImageController(isCameraSelected: Bool)  {
        imagePickerController.sourceType = .photoLibrary
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }

}

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 1.0)
            else    {
                return
        }
        
        selectedImage = image
        photoObject?.imageData = imageData
        
        dismiss(animated: true)
    }
}
