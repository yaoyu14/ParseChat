//
//  ChatCell.swift
//  ParseChat
//
//  Created by Yao Yu on 3/13/20.
//  Copyright © 2020 Yao Yu. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageListLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
