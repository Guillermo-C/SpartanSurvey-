//
//  SubwayViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/23/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class SubwayViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var subOfDayPicker: UIPickerView!
    @IBOutlet weak var breakFastPicker: UIPickerView!
    @IBOutlet weak var saladPicker: UIPickerView!
    @IBOutlet weak var extrasPicker: UIPickerView!
    @IBOutlet weak var textAnswer: UITextField!
    
    var subOfDayTypes = ["↓ Scroll down ↓","Sweet Onion Chicken Teriyaki","Oven Roasted Chicken","Turkey Breast","Classic Tuna","Black Forest Ham"]
    
    var breakFastTypes = ["↓ Scroll down ↓","Beacon, Egg & Cheese","Egg & Cheese","Steak, Egg & Cheese"]
    
    var saladTypes = ["↓ Scroll down ↓","Corned Beef Reuben Salad","Turkey Reuben Salad","Spicy Italian Salad","Veggie Delite Salad","Tuna Salad","Subway Club Salad"]
    
    var extrasTypes = ["↓ Scroll down ↓","Pepperoni","Cheese","Bacon"]
    
    //  name of the survey for identification when querying through the database
    var companyName:String = "Subway"
    
    //  Array holding the key names to properly store the answers of the user.
    var answerKeys = ["SurveyCompany","Email","Answer1","Answer2","Answer3","Answer4","Answer5"]
    
    //  vars for storing the answers from the pickers.
    var ans1:String = ""
    var ans2:String = ""
    var ans3:String = ""
    var ans4:String = ""
    
    //  Number of points this survey will give the user.
    let worthPoints:Int = 5
    
    //  Array holding the answers of the user.
    var answerArray = [String]()
    
    //  Invoke the class CloudKitEngine for saving data in the cloud
    let cloudKitEng = CloudKitEngine()
    
        //  Invoke the class Survey for implementing survey completion elements.
    var survey =  Survey()
    
    //  func to apply custom font to the pickers.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 12)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        
        if(pickerView == subOfDayPicker){
            pickerLabel.text = subOfDayTypes[row]
        }
        if(pickerView == breakFastPicker){
            pickerLabel.text = breakFastTypes[row]
        }
        if(pickerView == saladPicker){
            pickerLabel.text = saladTypes[row]
        }
        if(pickerView == extrasPicker){
            pickerLabel.text = extrasTypes[row]
        }
        
        return pickerLabel
    }
    
    
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == breakFastPicker){
            return breakFastTypes[row]
        }
        
        if (pickerView == saladPicker){
            return saladTypes[row]
        }
        
        if (pickerView == extrasPicker){
            return extrasTypes[row]
        }
        
        
        return subOfDayTypes[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if (pickerView == breakFastPicker){
            return breakFastTypes.count
        }
        
        if (pickerView == saladPicker){
            return saladTypes.count
        }
        
        if (pickerView == extrasPicker){
            return extrasTypes.count
        }
        
        return subOfDayTypes.count
    }
    
    //  func for getting current picker choice
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == subOfDayPicker){
            ans1 = subOfDayTypes[row]
        }
        if (pickerView == breakFastPicker){
            ans2 = breakFastTypes[row]
        }
        if (pickerView == saladPicker){
            ans3 = saladTypes[row]
        }
        if (pickerView == extrasPicker){
            ans4 = extrasTypes[row]
        }
        

        
        
    }
    
    
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    @IBAction func done(_ sender: UIButton) {
        let allPickerQsAnswered = survey.pickerQuesAnswered(in0: ans1, in1: ans2, in2: ans3, in3: ans4)
        
        let missingQ = survey.missingQuestionAlert(aTitle: "default", aMessage: "default")
        let completionAlert = survey.completionAlert(aTitle: "default", aMessage: "default", targetVC: self, email: true)
        
        if ( allPickerQsAnswered == false){
            
            print("Now with the latest code.")
            self.present(missingQ, animated: true, completion: nil)
        }
        else{
            answerArray = survey.getAnswerAsArray(company: companyName,email: emailOfUser,in0: ans1, in1: ans2, in2: ans3, in3: ans4, in4: textAnswer.text!)
            
            cloudKitEng.saveUserAnswerData(recordTypeName: "SurveyData", answerKey: answerKeys, answers: answerArray, actInd: actIndicator, targetVC: self, alert: completionAlert)
            cloudKitEng.updatePoints(email: emailOfUser, worthPts: worthPoints)
            /*completionAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
             let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userProfileView") as UIViewController
             self.present(viewC, animated: true, completion: nil)
             }))*/
            
            present(completionAlert, animated: true, completion: nil)
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
