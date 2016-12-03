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

//  Activity indicator. 
var actIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

class SignInViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate{

    var delegate: SignInViewControllerDelegate?
    
    @IBOutlet weak var emailEntry: UITextField!
    
    @IBOutlet weak var passwordEntry: UITextField!
    
    
    
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

        
        //  For activity indicator 
        actIndicator.center = self.view.center
        actIndicator.hidesWhenStopped = true
        actIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(actIndicator)
        
        passwordEntry.isSecureTextEntry = true
        
        emailEntry.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignInBackButtunPressed(_ sender: UIBarButtonItem) {
        
        delegate?.signInBackButtonPressed!()
        
    }
    
    //  Call getLogINCredentials() from the CloudKitEng. If the user provides the right credentials, grant access. Aler the user otherwise.
    @IBAction func signIn(_ sender: UIButton) {
        let email = emailEntry.text!
        let password = passwordEntry.text!
        
        
        //_ = cloudKitEng.getLogInCredentials(email: email, password: password, actInd: actIndicator, targetVC: self, alert: wrongCredentialsAlert)
        
        // testing
        let userProvidedCred:Bool = userProvidedCreds(emailField: emailEntry, passWField: passwordEntry)
        
        if (userProvidedCred == true){
            _ = cloudKitEng.getLogInCredentials(email: email, password: password, actInd: actIndicator, targetVC: self, alert: wrongCredentialsAlert)
        }
        else if (userProvidedCred == false){
            present(wrongCredentialsAlert, animated: true, completion: nil)
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
    
    //  func to prevent spaces in the email text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " && textField == emailEntry{
            return false
        } else {
            return true
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //  func to check if user provided login credentials
    func userProvidedCreds(emailField: UITextField, passWField: UITextField) -> Bool{
        if ((!(emailField.text?.isEmpty)!) && (!(passWField.text?.isEmpty)!)){
            return true
        }
        return false
    }
    
    
    //  Show or hide the password when the "eye" button is pressed
    @IBAction func showOrHide(_ sender: UIButton) {
        showOrHidePassword(textF: passwordEntry)
    }
    
    //  func to show or hide the password 
    func showOrHidePassword(textF: UITextField){
        let isVisible:Bool = textF.isSecureTextEntry
        
        switch isVisible {
        case true:
            textF.isSecureTextEntry = false
        default:
            textF.isSecureTextEntry = true
        }
    }
    

    

}
