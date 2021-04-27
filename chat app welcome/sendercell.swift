//
//  sendercell.swift
//  chat app welcome
//
//  Created by Amira on 11/5/20.
//  Copyright © 2020 Amira. All rights reserved.
//

import UIKit

class sendercell: UITableViewCell {

    
    @IBOutlet weak var messagesenderlbl: UILabel!
    
    @IBOutlet weak var datasender: UILabel!
    
    
    @IBOutlet weak var imageviewsender: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
