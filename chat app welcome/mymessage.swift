//
//  mymessage.swift
//  chat app welcome
//
//  Created by Amira on 11/7/20.
//  Copyright © 2020 Amira. All rights reserved.
//

import UIKit

class mymessage: UITableViewCell {

    
    @IBOutlet weak var imagecell3: UIImageView!
   // {
       // didSet{
           // imagecell3.layer.cornerRadius = 10
       // }
   // }
    
    @IBOutlet weak var avatarcell3: UIImageView!
    {
         didSet{
            avatarcell3.layer.cornerRadius = avatarcell3.frame.height/2               }
        
    }
    
    @IBOutlet weak var datelblcell3: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
