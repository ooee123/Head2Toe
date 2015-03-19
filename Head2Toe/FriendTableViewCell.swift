//
//  FriendTableViewCell.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 3/18/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            if let friend = friend? {
                let first = friend["firstName"] as String
                let last = friend["lastName"] as String
                titleLabel?.text = "\(first) \(last)"
            }
        }
    }
    var friend : PFObject? = nil {
        didSet {
            if let friend = friend? {
                let first = friend["firstName"] as String
                let last = friend["lastName"] as String
                titleLabel?.text = "\(first) \(last)"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
