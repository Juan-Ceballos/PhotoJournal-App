//
//  PhotoCell.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import NetworkHelper

class PhotoCell: UICollectionViewCell {
    
    weak var delegate: EditButtonPressedDelegate?
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    private lazy var photoCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey"
        label.textColor = .white
        return label
    }()
    
    private lazy var postDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    public lazy var editPhotoButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(editPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc public func editPressed(_ sender: UIButton!)  {
        print("edit button pressed")
        self.delegate?.buttonPressed(tag: sender.tag, currentCell: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commnonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commnonInit()
    }
    
    public func configureCell(photoObject: PhotoObject)    {
        photoImageView.image = UIImage(data: photoObject.imageData)
        photoCommentLabel.text = photoObject.photoComment
        postDateLabel.text = photoObject.convertedDate
    }
    
    private func commnonInit()  {
        setupPhotoImageViewConstraints()
        setupPhotoCommentLabelConstraint()
        setupEditPhotoButton()
        setupPostDateLabelConstraint()
    }
    
    private func setupPhotoImageViewConstraints()   {
        addSubview(photoImageView)
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }
    
    private func setupPhotoCommentLabelConstraint()   {
        addSubview(photoCommentLabel)
        
        photoCommentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoCommentLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 22),
            photoCommentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    
    private func setupPostDateLabelConstraint() {
        addSubview(postDateLabel)
        
        postDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            postDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    
    private func setupEditPhotoButton() {
        addSubview(editPhotoButton)
        
        editPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editPhotoButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 22),
            editPhotoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
}
