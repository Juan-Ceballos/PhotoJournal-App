//
//  PhotosViewController.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    let photosView = PhotosView()
    
    override func loadView() {
        view = photosView
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        photosView.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        photosView.collectionView.dataSource = self
        photosView.collectionView.delegate = self
        photosView.plusButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    @objc private func didTap(sender: UIButton!)    {
        
        let addPhotoController = AddPhotoViewController()
        present(addPhotoController, animated: true)
//        print("tap")
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
//            self.imagePickerController.sourceType = .photoLibrary
//            self.present(self.imagePickerController, animated: true)
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//
//        let cameraAction = UIAlertAction(title: "Camera", style: .default) { alertAction in
//            self.imagePickerController.sourceType = .camera
//            self.present(self.imagePickerController, animated: true)
//        }
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            alertController.addAction(cameraAction)
//        }
//
//        alertController.addAction(cancelAction)
//        alertController.addAction(photoLibraryAction)
//        present(alertController, animated: true)
    }
    

}

extension PhotosViewController: UICollectionViewDataSource    {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        
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
}

extension PhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        dismiss(animated: true)
    }
}
