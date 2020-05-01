//
//  PhotosView.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class PhotosView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    public lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    public lazy var plusBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(customView: plusButton)
        return barButtonItem
    }()
    
    public lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.items = [plusBarButtonItem]
        return toolBar
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
        setupCollectionViewConstraints()
        setupToolBarConstraints()
    }
    
    private func setupCollectionViewConstraints()   {
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupToolBarConstraints()  {
        addSubview(toolBar)
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            toolBar.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            toolBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            toolBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
}
