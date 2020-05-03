//
//  AddPhotoViewController.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

protocol PhotoObjectDelegate: AnyObject {
    func photoAdded(_ photoObject: PhotoObject)
}

class AddPhotoViewController: UIViewController {

    let addPhotoView = AddPhotoView()
    
    var photos = [PhotoObject]()
    
    weak var delegate: PhotoObjectDelegate?
    
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
        view.backgroundColor = .systemGreen
        imagePickerController.delegate = self
        addPhotoView.photoLibraryButton.addTarget(self, action: #selector(photoLibraryButtonPressed), for: .touchUpInside)
        addPhotoView.saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        
        addPhotoView.cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func photoLibraryButtonPressed(_ sender: UIButton!) {
        showImageController(isCameraSelected: false)
    }
    
    @objc func saveButtonPressed(_ sender: UIButton)    {
        print("save button pressed")
        
        guard let selectedImageData = selectedImage?.jpegData(compressionQuality: 1.0)
            else    {
                print("wrong")
                return
        }
        
        let newPhoto = PhotoObject(imageData: selectedImageData, photoComment: "Hello")
                
        do {
            try dataPersistence.createItem(newPhoto)
        } catch {
            print("error")
        }
        
        delegate?.photoAdded(newPhoto)
        
    }
    
    @objc func cancelButtonPressed(_ sender: UIButton)  {
        print("cancel button pressed")
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
        
        selectedImage = image
        
        dismiss(animated: true)
    }
}
