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
        
    weak var delegate: PhotoObjectDelegate?
    
    var photoObject: PhotoObject?
    
    var selectedImage: UIImage? {
        didSet  {
            addPhotoView.selectedPhotoImageView.image = selectedImage
        }
    }
    
    var commentToAdd: String?   {
        didSet  {
            addPhotoView.commentTextView.text = commentToAdd
        }
    }
    
    private let imagePickerController = UIImagePickerController()
    private let dataPersistence = DataPersistence<PhotoObject>(filename: "photos.plist")
    
    override func loadView() {
        view = addPhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imagePickerController.delegate = self
        addPhotoView.photoLibraryButton.addTarget(self, action: #selector(photoLibraryButtonPressed), for: .touchUpInside)
        addPhotoView.saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        
        addPhotoView.cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
        
        addPhotoView.commentTextView.delegate = self
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
        
        guard let currentCommentToAdd = commentToAdd
        else    {
            print("wrong")
            return
        }
        
        let newPhoto = PhotoObject(imageData: selectedImageData, photoComment: currentCommentToAdd)
                
        do {
            try dataPersistence.createItem(newPhoto)
        } catch {
            print("error")
        }
        
        delegate?.photoAdded(newPhoto)
        
    }
    
    @objc func cancelButtonPressed(_ sender: UIButton)  {
        print("cancel button pressed")
        dismiss(animated: true)
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

extension AddPhotoViewController: UITextViewDelegate    {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray  {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty    {
            textView.text = "Say Something"
            textView.textColor = .lightGray
        }
        
        else    {
            commentToAdd = textView.text
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
