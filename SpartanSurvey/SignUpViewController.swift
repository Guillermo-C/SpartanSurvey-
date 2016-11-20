//
//  SignUpViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/16/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIPopoverPresentationControllerDelegate {

    //  User's first name input
    @IBOutlet weak var firstNameEntry: UITextField!
    
    //  User's email input
    @IBOutlet weak var emailEntry: UITextField!
    
    //  User's password input
    @IBOutlet weak var passwordEntry: UITextField!
    
    //  User's password confirmation input
    @IBOutlet weak var confirmPassEntry: UITextField!
    
    //  User's answer to the security question
    @IBOutlet weak var securityQuestionAnswer: UITextField!
    
    //  Security picker for user to choose from
    @IBOutlet weak var securityQPicker: UIPickerView!
    
    //  Array containing the security questions for securityQPicker
    var securityQArray = [String]()
    
    
    //  Alert for when password is not successfully validated 
    let passwordValidationAlert = UIAlertController(title: "Passwords Don't Match", message: "Make sure to successfully confirm the chosen password.", preferredStyle: UIAlertControllerStyle.alert)
    
    //  Alert for when sign up form is not completed
    let formCompletionAlert = UIAlertController(title: "Complete All Fields", message: "Make sure to fill out this form completely.", preferredStyle: UIAlertControllerStyle.alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  Fulfill delegate & dataSource requirements for securityQPicker
        securityQPicker.delegate = self
        securityQPicker.dataSource = self
        
        //  Popullate securityQArray
        securityQArray = ["What's your pet's name?",
                          "Name your favorite drink", "Name your favorite number"]
        
        //  Add action "Ok" for the passwordValidationAlert
        passwordValidationAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        //  Add action "Ok" for the formCompletionAlert
        formCompletionAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")}))
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  func for populating securityQPicker
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return securityQArray[row]
    }
    
    // func for returning the number of elements in securityQPicker
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return securityQArray.count
    }
    
    // func for returning number of components in securityQPicker
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    //  Action for when save button is pressed
    @IBAction func saveButton(_ sender: UIButton) {
        
        //  Form completion check
        let passwordConfirmed = validatePassword(passW: passwordEntry.text!, compareTo: confirmPassEntry.text!)
        //  Form completion check
        let formCompleted = completedAllFields(field1: firstNameEntry, field2: emailEntry, field3: passwordEntry, field4: confirmPassEntry, field5: securityQuestionAnswer)
        
        
        if (formCompleted == false){
            present(formCompletionAlert, animated: true, completion: nil)
        }else if(passwordConfirmed == false){
            present(passwordValidationAlert, animated: true,completion: nil)
        }
        else{   //  Continue process
            print("NOT ALL WAS FILLED OUT")
        }

    }
    
    
    //  func for validating password inputs
    func validatePassword(passW:String, compareTo: String) -> Bool {
        var validation:Bool = false
        if (passW == compareTo){
            validation = true
        }
        return validation
    }
    
    //  func for validating completion of fields 
    func completedAllFields(field1: UITextField, field2: UITextField, field3: UITextField, field4: UITextField,field5: UITextField) -> Bool{
        var validation:Bool = false
        
        if !(field1.text?.isEmpty)! && !(field2.text?.isEmpty)! && !(field3.text?.isEmpty)! && !(field4.text?.isEmpty)! && !(field5.text?.isEmpty)!{
            validation = true
        }
        return validation
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
    
    /*func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }*/
    
    
    
    var updateStatusLabel:String?{
        get{
            return "something"
        }
    }
    

}
