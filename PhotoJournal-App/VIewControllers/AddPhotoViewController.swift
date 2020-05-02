//
//  AddPhotoViewController.swift
//  PhotoJournal-App
//
//  Created by Juan Ceballos on 5/1/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {

    let addPhotoView = AddPhotoView()
    
    override func loadView() {
        view = addPhotoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }

}
