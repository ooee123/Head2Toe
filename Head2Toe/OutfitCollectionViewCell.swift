//
//  OutfitCollectionViewCell.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 3/7/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class OutfitCollectionViewCell: UICollectionViewCell {
    
    var object : PFObject = PFObject() {
        didSet {
            imageView?.image = UIImage(data: (object["photo"].getData()))
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
        {
        didSet {
            imageView.image = UIImage(data: (object["photo"].getData()))
        }
    }
}
