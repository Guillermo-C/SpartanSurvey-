//
//  ForgotPasswordViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/23/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit


class ForgotPasswordViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    //  for testing only
    //  Alert for wrong credentials
    let secQuesAlert = UIAlertController(title: "Security Question", message: "The actual answer would come here...", preferredStyle: UIAlertControllerStyle.alert)
    //  end for testing
    
    
    var passwordTextField: UITextField?
    
    @IBOutlet weak var emailEntry: UITextField!
    
    @IBOutlet weak var answerDisplay: UITextField!
    

    //  Invoke the class CloudKitEngine for saving data in the cloud
    let cloudKitEng = CloudKitEngine()
    
   // var realAnswer:String = ""
    var userAnswer:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        secQuesAlert.addTextField{(passwordTextField) in
            //passwordTextField.text = "Testing"
            passwordTextField.placeholder = "Type your answer here"
        }
        
        
        secQuesAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            let textField = self.secQuesAlert.textFields![0] // Force unwrapping because we know it exists.
            let passW = self.cloudKitEng.getPass()  //  Password of user to be displayed if answered security question correctly.
            let realAnswer:String = self.cloudKitEng.getAns()
            let userAnswer:String = textField.text!
            if(userAnswer == realAnswer){
                self.answerDisplay.text = passW
                print("\nThe user provided the right password\n")
            }
            
        }))
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "forgotPassInfoSegue"{
            
            let viewC = segue.destination
            let controller = viewC.popoverPresentationController
            
            if (controller != nil) {
                controller?.delegate = self
            }
            
        }
    }
    
    @IBAction func go(_ sender: UIButton) {
        
        _ = cloudKitEng.getSecurityQuetionAns(email: emailEntry.text!)
        
        //var doit:String = cloudKitEng.getAns()
        //print("\nThe realAnswer is: \(doit)")
        //present(secQuesAlert, animated: true, completion: nil)
        //realAnswer = cloudKitEng.getAns()
        present(secQuesAlert, animated: true, completion: nil)
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    


}
