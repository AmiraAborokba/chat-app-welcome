//
//  UsersCell.swift
//  chat app welcome
//
//  Created by Amira on 10/30/20.
//  Copyright © 2020 Amira. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {

    
    @IBOutlet weak var userimageview: UIImageView!
    
    
    @IBOutlet weak var usernamelbl: UILabel!
    
    
    @IBOutlet weak var emaillbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .black
        
    }

}
