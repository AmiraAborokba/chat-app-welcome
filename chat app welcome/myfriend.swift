//
//  myfriend.swift
//  chat app welcome
//
//  Created by Amira on 11/7/20.
//  Copyright © 2020 Amira. All rights reserved.
//

import UIKit

class myfriend: UITableViewCell {

    
    @IBOutlet weak var imagecell4: UIImageView!//{
        
        //didSet{
            //imagecell4.layer.cornerRadius = 10
      //  }
        
   // }
    
    
    @IBOutlet weak var lblcell4: UILabel!
    
    
    @IBOutlet weak var avatarcell4: UIImageView!{
         didSet{
                   avatarcell4.layer.cornerRadius = avatarcell4.frame.height/2               }    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
