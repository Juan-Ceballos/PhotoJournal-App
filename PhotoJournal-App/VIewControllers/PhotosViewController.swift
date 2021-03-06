//
//  PhotosViewController.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import DataPersistence

protocol EditButtonPressedDelegate: AnyObject {
    func buttonPressed(tag: Int, currentCell: PhotoCell)
}

class PhotosViewController: UIViewController {

    let photosView = PhotosView()
    
    var photos = [PhotoObject]()    {
        didSet  {
            photosView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = photosView
    }
    
    weak var delegate: PhotoObjectDelegate?
    
    private let dataPersistence = DataPersistence<PhotoObject>(filename: "photos.plist")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        photosView.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        photosView.collectionView.dataSource = self
        photosView.collectionView.delegate = self
        photosView.plusButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        print("PhotosVC")
        setupUI()
    }
    
    private func setupUI()  {
        do {
            photos = try dataPersistence.loadItems().sorted(by: {$0.date > $1.date})
        } catch  {
            print(error)
        }
        
        print(photos.count)
    }
    
    @objc private func didTap(_ sender: UIButton)    {
        let addPhotoController = AddPhotoViewController()
        addPhotoController.delegate = self
        addPhotoController.dataPersistence = dataPersistence
        present(addPhotoController, animated: true)
    }
    
}

extension PhotosViewController: UICollectionViewDataSource    {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError()
        }
        
        let photoObject = photos[indexPath.row]
        cell.editPhotoButton.tag = indexPath.row
        cell.configureCell(photoObject: photoObject)
        cell.delegate = self
        
        return cell
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout    {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.40
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension PhotosViewController: PhotoObjectDelegate {
    func photoAdded(_ photoObject: PhotoObject, save: Save, at: Int?) {
        switch save {
        case .new:
            print()
            photos.append(photoObject)
            photos = photos.sorted(by: {$0.date > $1.date})
        case .edit:
            print()
            photos[at ?? 0] = photoObject
            photos = photos.sorted(by: {$0.date > $1.date})
        }
    }

}

extension PhotosViewController: EditButtonPressedDelegate   {
    func buttonPressed(tag: Int, currentCell: PhotoCell) {
        print(tag)
        
        guard let indexPath = photosView.collectionView.indexPath(for: currentCell)
            else    {
                return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] alertAction in
        
            let addPhotoController = AddPhotoViewController()
            addPhotoController.delegate = self
            addPhotoController.photoObject = self?.photos[tag]
            addPhotoController.save = .edit
            addPhotoController.number = indexPath.row
            addPhotoController.dataPersistence = self?.dataPersistence
            self?.present(addPhotoController, animated: true)
            
        }
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)  {
            [weak self] alertAction in
            
            do  {
                try self?.dataPersistence.deleteItem(at: indexPath.row)
                self?.photos.remove(at: indexPath.row)
            }
            catch   {
                print("error")
            }
        }
        
        alertController.addAction(editAction)
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }

}
