//
//  PostTableViewCell.swift
//  Parstagram
//
//  Created by Kedar Abhyankar on 4/16/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var photoView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
