//
//  MessageCell.swift
//  Qhat
//
//  Created by Alisher Aidarkhan on 12/25/19.
//  Copyright © 2019 Alisher Aidarkhan. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bubble: UIView!
    @IBOutlet weak var rightAvatar: UIImageView!
    @IBOutlet weak var leftAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubble.layer.cornerRadius = 5;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
