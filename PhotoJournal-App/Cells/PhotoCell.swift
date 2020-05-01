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
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.backgroundColor = .cyan
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commnonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commnonInit()
    }
    
    public func configureCell()    {
        
    }
    
    private func commnonInit()  {
        setupPhotoImageViewConstraints()
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
}
