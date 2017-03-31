//
//  ViewController.swift
//  Swift Photo Viewer
//
//  Created by Yong Su on 3/31/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit

private let photoCellIdentifier = "PhotoCell"

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var photosManager: PhotosManager { return .shared }

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 120)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoListCell.self, forCellWithReuseIdentifier: photoCellIdentifier)
        collectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosManager.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath as IndexPath) as! PhotoListCell
        
        cell.configure(with: photosManager.photos[indexPath.row])
        
        return cell
    }
    
}

