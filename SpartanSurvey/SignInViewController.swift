//
//  SignInViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 10/25/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit


@objc protocol SignInViewControllerDelegate{
    @objc optional func signInBackButtonPressed()
}

//  Name of user that logged in.
var nameOfUser:String = ""

//  Points of the logged in user.
var userPoints:String = ""

//  Email of the logged in user.
var emailOfUser:String = ""

class SignInViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var delegate: SignInViewControllerDelegate?
    
    @IBOutlet weak var emailEntry: UITextField!
    
    @IBOutlet weak var passwordEntry: UITextField!
    
    //  Save the sign in credentials 
    var emailCred:String = ""
    var passwordCred:String = ""
    
    
    
    //  Alert for wrong credentials
    let wrongCredentialsAlert = UIAlertController(title: "Invalid Credentials", message: "Double-check your email and password. Or,sign up!", preferredStyle: UIAlertControllerStyle.alert)
    
    //  Invoke the class CloudKitEngine for saving data in the cloud
    let cloudKitEng = CloudKitEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Add action "Ok" for the wrongCredentialsAlert
        wrongCredentialsAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignInBackButtunPressed(_ sender: UIBarButtonItem) {
        
        delegate?.signInBackButtonPressed!()
        
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        let email = emailEntry.text!
        let password = passwordEntry.text!
        let checkLogin = cloudKitEng.getLogInCredentials(email: email, password: password)
        let letUserIn = cloudKitEng.logUserIn()
        if(letUserIn == true){
            print("\nFound credentials")
            let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userProfileView") as UIViewController
            self.present(viewC, animated: true, completion: nil)
            
            var password = cloudKitEng.getPassFromCred(record: cloudKitEng.loginCredentials)
            

            //  Data of the user about to log in.
            nameOfUser = cloudKitEng.getNameOfUser(record: cloudKitEng.loginCredentials)
            userPoints = cloudKitEng.pointsOfUser(record: cloudKitEng.loginCredentials)
            emailOfUser = cloudKitEng.getEmailFromCred(record: cloudKitEng.loginCredentials)
        }
        if (letUserIn == false){
            present(wrongCredentialsAlert, animated: true,completion: nil)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signInInfoSegue"{
            
            let viewC = segue.destination
            let controller = viewC.popoverPresentationController
            
            if (controller != nil) {
                controller?.delegate = self
            }
            
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    

}
