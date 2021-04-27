//
//  messagesVC.swift
//  chat app welcome
//
//  Created by Amira on 11/5/20.
//  Copyright © 2020 Amira. All rights reserved.
//

import UIKit
import ImagePicker
class messagesVC: UIViewController {
// MARK:-OutLets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sendbtn: UIButton!
    
    @IBOutlet weak var messagetext: UITextField!
    
    
    
    
    //MARK:-Constants:
    
    var chatroomid:String!
    var userId:[String]!
    var messages = [Messages]()
    var users = [FUser]()
    var selectedimage : UIImage?
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        messages = []

        chatroomid = getchatroomid(FUserID: userId.first!, SUserID: userId.last!)
        
        
        getmessages()
    }
   //MARK:-IBACtion
    
    
    @IBAction func sendmessagebtn(_ sender: UIButton) {
        
        
        if messagetext.text != " "{
            sendbtn.isEnabled = false
            sendmessages(text: messagetext.text!, photo: nil)
        }
    }
    
    
    
    
    
    @IBAction func imagepickerpressed(_ sender: UIButton) {
        let picker = ImagePickerController()
        picker.imageLimit = 1
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    
    }
    
    
    
    
//MARK:-HelperFunctions

    func sendmessages(text:String?,photo:String?){
   
        if let text = text{
            let encyretpedtext = Encryption.encryptText(chatRoomId: chatroomid, message: text)
            
            let messageID = UUID().uuidString
            let goingmessage = OutgoingMessages(message: encyretpedtext , senderId: FUser.currentId(), senderName: FUser.currentUser()?.fullname ?? " ", date:Date(), messageType: kPRIVATE, type: messageType(.text), messageId: messageID)
            goingmessage.sendMessage(chatRoomId: chatroomid, messageDictionary: goingmessage.messagesDictionary, membersIds: userId)
            messagetext.text = " "
            sendbtn.isEnabled = true
            
        }
        if let photo = photo {
            let encyretpedtext = Encryption.encryptText(chatRoomId: chatroomid, message:"[image]")
            let messageID = UUID().uuidString
            let goingmessage = OutgoingMessages(message: encyretpedtext, senderId: FUser.currentId(), senderName: FUser.currentUser()?.fullname ?? " ", date: Date(), messageType: kPRIVATE, imageLink: photo, type: messageType(.image), messageId: messageID)
            goingmessage.sendMessage(chatRoomId: chatroomid, messageDictionary: goingmessage.messagesDictionary, membersIds: userId)
            
        }
        
        
    }
   
    
    func getmessages()  {
        DBref.child(reference(.Message)).child(FUser.currentId()).child(chatroomid).queryOrdered(byChild: kDATE).observe(.childAdded) { (snapshot) in
            let snap = snapshot.value as! NSDictionary
            let newmessages = Messages(_dictionary: snap,chatRoomId: self.chatroomid)
            self.messages.append(newmessages)
            self.tableView.reloadData()
            
        }
    }
      func scrollToBottom(){

          DispatchQueue.main.async {
              let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
              
              if (indexPath.row > 0){
                  
                  self.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                  
              }
          }
      }
    
    
    
    
}
//MARK:-TableViewDelegates
extension messagesVC:UITableViewDelegate,UITableViewDataSource{
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return messages.count
}
    
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if messages[indexPath.row].type == kTEXT{
        
        if messages[indexPath.row].senderId == FUser.currentId(){
               
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")as!  sendercell
               cell.messagesenderlbl.text = messages[indexPath.row].message
               cell.datasender.text = "\(messages[indexPath.row].date)"
               return cell
           }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")as! recieverCell
                     // cell.recievermessagelbl.text = messages[indexPath.row].message
                      cell.datereciever.text = "\(messages[indexPath.row].date)"
                      return cell
           }
    
    }
    
    else{
      
        if messages[indexPath.row].senderId == FUser.currentId(){
                      
                      let cell = tableView.dequeueReusableCell(withIdentifier: "cell3")as! mymessage
            downloadImage(imageUrl: messages[indexPath.row].picture) { (myimage) in
                if  let image = myimage{
                    cell.imagecell3.image = myimage
                }
            }
            
            
            
                      cell.datelblcell3.text = "\(messages[indexPath.row].date)"
                      return cell
                  }else{
                       let cell = tableView.dequeueReusableCell(withIdentifier: "cell4")as! myfriend
                            // cell.recievermessagelbl.text = messages[indexPath.row].message
                             cell.lblcell4.text = "\(messages[indexPath.row].date)"
                             return cell
                  }
  }
    
}
}
    
extension messagesVC:ImagePickerDelegate{
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        if images.count > 0{
            selectedimage = images.last
            uploadImage(image: selectedimage!, chatRoomId: chatroomid, view: self.navigationController!.view) { (imageURL) in
                guard  let imageURL = imageURL else {return}
                self.sendmessages(text: nil, photo: imageURL)
            }
            
            
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
