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
    
    //  Array containing all input provided by the user to be saved 
    var inputTextArray = [String]()
    
    //  Array of keys
    var keyArray = [String]()
    
    //  Current picker choice
    var currentPickerChoice:String = ""
    
    //  Alert for when password is not successfully validated 
    let passwordValidationAlert = UIAlertController(title: "Passwords Don't Match", message: "Make sure to successfully confirm the chosen password.", preferredStyle: UIAlertControllerStyle.alert)
    
    //  Alert for when sign up form is not completed
    let formCompletionAlert = UIAlertController(title: "Complete All Fields", message: "Make sure to fill out this form completely.", preferredStyle: UIAlertControllerStyle.alert)
    
    //  Invoke the class CloudKitEngine for saving data in the cloud
    let cloudKitEng = CloudKitEngine()
    
    //  Activity indicator for when saving data to the cloud
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
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
        
        //  Add an activity indicator to the UI and center it in the view
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        //  Append key names to the keyArray for proper cloud storing
        keyArray.append("FirstName")
        keyArray.append("Email")
        keyArray.append("Password")
        keyArray.append("SecurityQuestion")
        keyArray.append("SecurityQuestionAnswer")
        
        // Do any additional setup after loading the view.
        
        //  Check if user has registered?
        //  Revise query, it's querying through the DB but it's not logical 
        cloudKitEng.checkIfUserRegistered()
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
        else{
            
            //let newRecordName = emailEntry.text!
            //currentPickerChoice = pickerValue
            //let inputArray = inputAsArray(in0: firstNameEntry.text!, in1: emailEntry.text!, in2: passwordEntry.text!, in3: currentPickerChoice, in4: securityQuestionAnswer.text!)
            //let userUsedPicker = didUserPick(choice: currentPickerChoice)
            //  Continue process
            //activityIndicator.startAnimating()
            //  Stop UI interaction while data process is running
            //UIApplication.shared.beginIgnoringInteractionEvents()
            //cloudKitEng.saveNewDataWRecord(record_Name: newRecordName, recordTypeName: "UserInfo", recordsToSave: inputArray, keyList: keyArray)
            
            //  code below for checking if a user has registered works, programmatically not logically--delete after testing
            //let checkEmail = cloudKitEng.emailAlreadyExists(email: emailEntry.text!)
            //print("Email being tested is: \(emailEntry.text!)")
            //print("\nContent of namesArray\n\(cloudKitEng.namesArray)\nEnd of content\n")
            cloudKitEng.checkIfUserRegistered()
            let something = cloudKitEng.checkIfDataAvailable()
            
            let whatever = cloudKitEng.valueOfCounter()
            
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
    
    //  func for putting all user's text input into an array for cloud storing
    func inputAsArray(in0:String, in1: String, in2: String, in3: String, in4: String) -> [String]{
        var tempArray = [String]()
        tempArray.append(in0)
        tempArray.append(in1)
        tempArray.append(in2)
        tempArray.append(in3)
        tempArray.append(in4)

        return tempArray
    }
    
    //  func for getting current picker choice 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentPickerChoice = securityQArray[row]
        
    }
    
    //  func to check if user chose from the picker an option other than one on the 0 position
    func didUserPick(choice: String)->Bool{
        if (choice != ""){
            return true
        }
        return false
    }
    
    //  var for getting the right picker choice even when the picker was not moved
    var pickerValue:String{
        get{
            if (currentPickerChoice == ""){
                return securityQArray[0]
            }
            return currentPickerChoice
        }
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
    

    
    

    

}
