//
//  OutfitCollectionViewCell.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 3/7/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class OutfitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
        {
        didSet {
            imageView.image = image
        }
    }
    
    var image : UIImage? = nil
        {
        didSet {
            imageView?.image = image
        }
    }
    
    override func prepareForReuse() {
        image = nil
    }
}
