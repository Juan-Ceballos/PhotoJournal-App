//
//  AddPhotoViewController.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence
import AVFoundation

enum Save  {
    case new
    case edit
}

protocol PhotoObjectDelegate: AnyObject {
    func photoAdded(_ photoObject: PhotoObject)
}

class AddPhotoViewController: UIViewController {
    
    let addPhotoView = AddPhotoView()
    
    var save: Save = .new
    
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
        addPhotoView.saveButton.isEnabled = false
        //setupUIForEdit()
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            if save == .edit    {setupUIForEdit()}
        }
    
        func setupUIForEdit()    {
            if let currentPhotoBeingEdited = photoObject    {
                selectedImage = UIImage(data: currentPhotoBeingEdited.imageData)
                commentToAdd = currentPhotoBeingEdited.photoComment
                addPhotoView.commentTextView.textColor = .black
                addPhotoView.saveButton.isEnabled = true
            }
    //
            
    //            addPhotoView.commentTextView.text = currentPhotoBeingEdited.photoComment
    //            addPhotoView.selectedPhotoImageView.image = UIImage(data: currentPhotoBeingEdited.imageData)
    //            addPhotoView.commentTextView.textColor = .black
    //            addPhotoView.saveButton.isEnabled = true
    //            commentToAdd = addPhotoView.commentTextView.text
    //            selectedImage = addPhotoView.selectedPhotoImageView.image
    //        }
    //
        }
    
    @objc func photoLibraryButtonPressed(_ sender: UIButton!) {
        showImageController(isCameraSelected: false)
    }
    
    @objc func saveButtonPressed(_ sender: UIButton)    {
        print("save button pressed")
        
        // switch on save
        // by the time i hit save ui will be there
        // send state over
        // send ui over
        
        guard let selectedImageData = selectedImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)).jpegData(compressionQuality: 1.0)
            else    {
                print("wrong")
                return
        }
        
        guard let currentCommentToAdd = commentToAdd
            else    {
                print("wrong")
                return
        }
        
        let newPhoto = PhotoObject(imageData: selectedImageData, date: Date(), photoComment: currentCommentToAdd)
        
        switch save {
        case .new:
            print()
            do {
                try dataPersistence.createItem(newPhoto)
            } catch {
                print("error")
            }
        case .edit:
            print("trying to edit")
            //dataPersistence.update(newPhoto, at: 0)
        }
        
        delegate?.photoAdded(newPhoto)
        dismiss(animated: true)
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
        
        if !addPhotoView.commentTextView.text.isEmpty && addPhotoView.commentTextView.textColor != .lightGray    {
            addPhotoView.saveButton.isEnabled = true
        }
        
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
            if selectedImage != nil {
                addPhotoView.saveButton.isEnabled = true
            }
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

