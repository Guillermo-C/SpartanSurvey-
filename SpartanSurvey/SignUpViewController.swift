//
//  SignUpViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/16/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameEntry: UITextField!
    
    @IBOutlet weak var emailEntry: UITextField!
    
    @IBOutlet weak var passwordEntry: UITextField!
    
    @IBOutlet weak var confirmPassEntry: UITextField!
    
    //  check if password matches when confirmed
    func verifiedPassword(passW: UITextField, compareTopassW: UITextField) -> Bool{
        var verify:Bool = false
        
        if (passW.text == compareTopassW.text){
            verify = true
        }
        return verify
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if (verifiedPassword(passW: passwordEntry, compareTopassW: confirmPassEntry)){
            print("Password do match")
        }
        else{
            print("Passwords do not match")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var updateStatusLabel:String?{
        get{
            return "something"
        }
    }

}
