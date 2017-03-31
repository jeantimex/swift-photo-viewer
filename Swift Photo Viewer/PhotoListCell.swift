//
//  PhotoListCell.swift
//  Swift Photo Viewer
//
//  Created by Yong Su on 3/31/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit
import Alamofire
import Cartography

class PhotoListCell: UICollectionViewCell {
    
    var photosManager: PhotosManager { return .shared }
    
    var captionLabel: UILabel!
    var imageView: UIImageView!
    var loadingIndicator: UIActivityIndicatorView!
    
    var request: Request?
    var photo: Photo!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(imageView)
        
        captionLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.size.height, width: frame.size.width, height: frame.size.height/3))
        captionLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        captionLabel.textAlignment = .center
        contentView.addSubview(captionLabel)
        
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        contentView.addSubview(loadingIndicator)
        
        constrain(loadingIndicator, contentView) { indicator, view in
            indicator.width == 25
            indicator.height == 25
            indicator.centerX == view.centerX
            indicator.centerY == view.centerY
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with photo: Photo) {
        self.photo = photo
        reset()
        loadImage()
    }
    
    func reset() {
        imageView.image = nil
        request?.cancel()
        captionLabel.isHidden = true
    }
    
    func loadImage() {
        if let image = photosManager.cachedImage(for: photo.url) {
            populate(with: image)
            return
        }
        downloadImage()
    }
    
    func downloadImage() {
        loadingIndicator.startAnimating()
        request = photosManager.retrieveImage(for: photo.url) { image in
            self.populate(with: image)
        }
    }
    
    func populate(with image: UIImage) {
        loadingIndicator.stopAnimating()
        imageView.image = image
        captionLabel.text = photo.name
        captionLabel.isHidden = false
    }
    
}
