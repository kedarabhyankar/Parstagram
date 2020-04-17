//
//  CommentTableViewCell.swift
//  Parstagram
//
//  Created by Kedar Abhyankar on 4/17/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet var commentUsername: UILabel!
    @IBOutlet var commentData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
