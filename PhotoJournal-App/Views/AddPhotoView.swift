//
//  AddPhotoView.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class AddPhotoView: UIView {
    
    public lazy var photoLibraryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Photo Library", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    public lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        return button
    }()
    
    public lazy var toolbarPhotoLibraryButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(customView: photoLibraryButton)
        return barButtonItem
    }()
    
    public lazy var toolbarCameraButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(customView: cameraButton)
        return barButtonItem
    }()
    
    public lazy var addPhotoToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.items = [toolbarPhotoLibraryButton, toolbarCameraButton]
        return toolbar
    }()
    
    public lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    public lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .red
        return button
    }()
       
    public lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        return textView
    }()
    
    public lazy var selectedPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .purple
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit()   {
        setupSaveButtonConstraints()
        setupCancelButtonConstraints()
        setupCommentTextViewConstraints()
        setupSelectedPhotoImageViewConstraints()
        setupAddPhotoToolbar()
    }
    
    private func setupSaveButtonConstraints()   {
        addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
        ])
    }
    
    private func setupCancelButtonConstraints() {
        addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22)
        ])
    }
    
    private func setupCommentTextViewConstraints()  {
        addSubview(commentTextView)
        
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 22),
            commentTextView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 22),
            commentTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            commentTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commentTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func setupSelectedPhotoImageViewConstraints()   {
        addSubview(selectedPhotoImageView)
        
        selectedPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectedPhotoImageView.topAnchor.constraint(equalTo: commentTextView.bottomAnchor),
            selectedPhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedPhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectedPhotoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func setupAddPhotoToolbar() {
        addSubview(addPhotoToolbar)
        
        addPhotoToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addPhotoToolbar.topAnchor.constraint(equalTo: selectedPhotoImageView.bottomAnchor),
            addPhotoToolbar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            addPhotoToolbar.leadingAnchor.constraint(equalTo: leadingAnchor),
            addPhotoToolbar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
