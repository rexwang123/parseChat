//
//  ChatCell.swift
//  parseChat
//
//  Created by Jiayi Wang on 2/25/18.
//  Copyright © 2018 Jiayi Wang. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var username: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
