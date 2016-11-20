//
//  SignUpViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/16/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var firstNameEntry: UITextField!
    
    @IBOutlet weak var emailEntry: UITextField!
    
    @IBOutlet weak var passwordEntry: UITextField!
    
    @IBOutlet weak var confirmPassEntry: UITextField!
    
    @IBOutlet weak var securityQPicker: UIPickerView!
    
    var securityQArray = [String]()
    
    
    //  Alert for when password is not successfully validated 
    let passwordValidationAlert = UIAlertController(title: "Passwords Don't Match", message: "Make sure to successfully confirm the chosen password.", preferredStyle: UIAlertControllerStyle.alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        securityQPicker.delegate = self
        securityQPicker.dataSource = self
        
        securityQArray = ["What's your pet's name?",
                          "Name your favorite drink", "Name your favorite number"]
        
        
        passwordValidationAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        /*refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))*/
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return securityQArray[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return securityQArray.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        
        
        let passwordConfirmed = validatePassword(passW: passwordEntry.text!, compareTo: confirmPassEntry.text!)
        
        if (passwordConfirmed){print("\nPassword is confirmed")}
        /*else if (){
            
        }*/
        else{
            present(passwordValidationAlert, animated: true,completion: nil)
            print("\nPassword is NOT confirmed")
        }
        
        


    }
    
    
    
    func validatePassword(passW:String, compareTo: String) -> Bool {
        var validation:Bool = false
        if (passW == compareTo){
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
