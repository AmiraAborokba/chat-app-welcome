//
//  UsersVC.swift
//  chat app welcome
//
//  Created by Amira on 10/30/20.
//  Copyright © 2020 Amira. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {
//MARK:-IBOutlets
    
    @IBOutlet weak var tableview: UITableView!
    
    //MARK:-Constants
    var users = [FUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
getuserdata()
        
    }
    
    
    //MARK:-IBAction
    
    
    
    
    //MARK:-Helper Functions
    
    func getuserdata(){
    
        DBref.child(reference(.User)).observe(.value) { (snapshot) in
           let snap = snapshot.value as! [String:Any]
            for (_,value) in snap{
                
                let Fuser = FUser(_dictionary: value as! NSDictionary)
               if Fuser.objectId != FUser.currentId(){
                    
                    self.users.append(Fuser)                }
                
            }
            
            self.tableview.reloadData()
                    }
        
       }
}



extension UsersVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        as!UsersCell
        cell.usernamelbl.text = users[indexPath.row].fullname;            cell.emaillbl.text = users[indexPath.row].email
       
        imageFromString(pictureData:users[indexPath.row].avatar) { (Img) in
             guard let Img = Img else {return}
                       
                       cell.userimageview.image = Img.circleMasked
        }
        
        return  cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let vc = UIStoryboard(name: "messagesVC", bundle: nil).instantiateViewController(identifier: "messagesVC")as! messagesVC
          vc.users = [FUser.currentUser()!,users[indexPath.row]]
        vc.userId = [FUser.currentId(),users[indexPath.row].objectId]
          self.navigationController?.pushViewController(vc, animated: true)
         
          
      }
    
}
