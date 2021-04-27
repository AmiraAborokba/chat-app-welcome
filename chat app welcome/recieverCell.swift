//
//  recieverCell.swift
//  chat app welcome
//
//  Created by Amira on 11/5/20.
//  Copyright © 2020 Amira. All rights reserved.
//

import UIKit

class recieverCell: UITableViewCell {

    @IBOutlet weak var recievermessagelbl: UILabel!
    
    @IBOutlet weak var datereciever: UILabel!
    
    
    @IBOutlet weak var imagereciever: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
