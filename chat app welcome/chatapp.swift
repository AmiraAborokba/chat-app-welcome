//
//  chatapp.swift
//  chat app welcome
//
//  Created by Amira on 10/27/20.
//  Copyright © 2020 Amira. All rights reserved.
//

import UIKit
import ImagePicker
import Firebase
import ProgressHUD
class chatapp: UIViewController {

    @IBOutlet weak var profilepicture: UIImageView!
    
    @IBOutlet weak var nameTf: UITextField!{
        didSet{
            
            nameTf.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5) ])
            
        }
        
        
        
    }
    
    @IBOutlet weak var mailtf: UITextField!{
         didSet{
                   
                   mailtf.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5) ])
                   
               }    }
  
    
    
    
    
    
    @IBOutlet weak var passwordtf: UITextField!
    {
        didSet{
                   
                   passwordtf.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5) ])
                   
               }
    }
    
    
    
    
    @IBOutlet weak var signupbtn: UIButton!{
        didSet{ signupbtn.layer.cornerRadius = 5
        
    }
    }
    
    
    @IBOutlet weak var notificationlbl: UILabel!
    
    //MARK:-Constant
    let leftSwipGes = UISwipeGestureRecognizer()
    
     let rightSwipGes = UISwipeGestureRecognizer()
       
    var profileImage:UIImage?
    let imagetapped = UITapGestureRecognizer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setswips()
      profileimagetapped()    }
    
    
    
    
    
    //MARK:-IBAction
    @objc func Swipped(){
        
        if signupbtn.titleLabel?.text == "Sign up"{
            signupbtn.setTitle("sign in", for: .normal)
            nameTf.isHidden = true
            profilepicture.isHidden = true
            notificationlbl.text = " swip to sign up"
        }else{
            signupbtn.setTitle("Sign up", for: .normal)
            nameTf.isHidden = false
            profilepicture.isHidden = false
            notificationlbl.text = "swip to sign in"
        }
        
        
        
    }
    
    @IBAction func signupbtnpressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Sign up"{
        
              registerbtnpressed()
        }else{
             loginbtnpressed()
              }
              
        
        
    }
    @objc func imagepressed(){
        
        let imagePickerView = ImagePickerController()
              imagePickerView.imageLimit = 1
        imagePickerView.delegate = self
              
              self.present(imagePickerView, animated: true, completion: nil)    }
    
    //MARK:-HelperFunctions
    
    
    func setswips(){
        
         
               leftSwipGes.direction = .left
               rightSwipGes.direction = .right
               self.view.addGestureRecognizer(leftSwipGes)
               self.view.addGestureRecognizer(rightSwipGes)
               leftSwipGes.addTarget(self, action: #selector(self.Swipped))
               
               rightSwipGes.addTarget(self, action: #selector(self.Swipped))
        
    }
   
    func profileimagetapped(){
        profilepicture.isUserInteractionEnabled = true
        profilepicture.addGestureRecognizer(imagetapped)
        
        imagetapped.addTarget(self, action: #selector(self.imagepressed))
    }
    func loginbtnpressed(){
        guard  !mailtf.text!.isEmpty,
        !passwordtf.text!.isEmpty  else{return}
        
        Auth.auth().signIn(withEmail: mailtf.text!, password: passwordtf.text!) { (result, error) in
                        if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                print(error!.localizedDescription)
                return
                
            }
            print(result!.user.uid)
           SaveCurrentUser(uId: result!.user.uid) { (issaved) in
              if issaved{
                //TODO:- go to home screen
                self.gotohome()
               }else{
                    ProgressHUD.showError("usernotsaved")
               }
            }
            
        }
        
    }
    func registerbtnpressed(){
      
         guard  !mailtf.text!.isEmpty,
               !passwordtf.text!.isEmpty  else{return}
               
        
     guard !mailtf.text!.isEmpty,
           !passwordtf.text!.isEmpty,
        !nameTf.text!.isEmpty,
        profileImage != nil
        else {ProgressHUD.showError("fill empty fields");return}
        Auth.auth().createUser(withEmail: mailtf.text!, password: passwordtf.text!) { (result, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                print(error!.localizedDescription)
                return
                
            }
            print(result!.user.uid)
            
            self.saveusertodatabase(UID: result!.user.uid)
            
            
                  }
      
        
        
        
            }
    func saveusertodatabase(UID:String){
        
        let userFuser = FUser(_objectId: UID, _createdAt: Date(), _updatedAt: Date(), _email:mailtf.text!, _fullname: nameTf.text!, _avatar: stringfromImage(image: profileImage!))
        let userDic = userDictionaryFrom(user: userFuser)
        DBref.child(reference(.User)).child(UID).setValue(userDic) { (error, ref) in
            if error != nil{
                
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            print("user saved sueccess")
            saveUserLocally(fUser: userFuser)
             //TODO:- go to home screen
            self.gotohome()
        }
          
          
     }
    
    func gotohome(){
        
        let vc = UIStoryboard(name: "users", bundle: nil).instantiateViewController(identifier: "mynav")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil) 
       
    }
   }
    
extension chatapp:ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        dismiss(animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
        if images.count > 0 {
            
            profileImage = images.first
            profilepicture.image = profileImage!.circleMasked     }
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
