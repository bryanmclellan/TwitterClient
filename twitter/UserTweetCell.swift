//
//  UserTweetCell.swift
//  twitter
//
//  Created by Bryan McLellan on 5/4/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class UserTweetCell: UITableViewCell {

    @IBOutlet weak var TweetContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
