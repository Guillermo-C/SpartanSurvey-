//
//  YogurtLandViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 12/4/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

//  Class for the Yogurtland survey; which is accessed through the QR Code.
class YogurtLandViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //  UIPickerView for the flavor question.
    @IBOutlet weak var flavorPicker: UIPickerView!
    
    //  UIPickerView for the weather question.
    @IBOutlet weak var weatherPicker: UIPickerView!
    
    //  UIPickerView for the day question.
    @IBOutlet weak var dayPicker: UIPickerView!
    
    //  UIPickerView for the friends question.
    @IBOutlet weak var friendsPicker: UIPickerView!
    
    // UITextField to hold the answer of text.
    @IBOutlet weak var textAnswer: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  Arrays with the values for the flavor question.
    var flavorTypes = ["↓ Scroll down ↓","Birthday Cupcake Batter","Almond Midnight Mocha","DJ Suki's Cranberry Raspberry Tart","Creek's Butterscotch Pudding Gelato","Guy Diamond's White Chocolate Peppermint","Pineapple Sorbet"]
    
    //  Arrays with the values for the weather question.
    var weatherTypes = ["↓ Scroll down ↓","Sunny","Cloudy","Rainy","Windy","Snowy"]

    //  Arrays with the values for the day question.
    var dayTypes = ["↓ Scroll down ↓","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday", "Saturday"]
    
    //  Arrays with the values for the friends question.
    var friendTypes = ["↓ Scroll down ↓","0","1","2","3", "more than 3"]
    
    //  Array holding the key names to properly store the answers of the user.
    var answerKeys = ["SurveyCompany","Email","Answer1","Answer2","Answer3","Answer4","Answer5"]
    
    //  vars for storing the answers from the pickers.
    var ans1:String = ""
    var ans2:String = ""
    var ans3:String = ""
    var ans4:String = ""
    
    //  change the value of the user email since survey won't affect the user's account. 
    var emailQR:String = "No Email"
    
    //  Invoke the class CloudKitEngine for saving data in the cloud.
    let cloudKitEng = CloudKitEngine()
    
    //  Invoke the class Survey for implementing survey completion elements.
    var survey =  Survey()
    
    //  Array holding the answers of the user.
    var answerArray = [String]()
    
    //  name of the survey for identification when querying through the database
    let companyName:String = "Yogurtland"
    
    //  Specify the custom title on the completion alert.
    let customTitle:String = "Congratulations!"
    
    //  Specify the custom message on the completion alert. The message in the completion alert should be different since it's done using the QR Code.
    let customMessage:String = "Thank you for taking the survey. Consider registering 😀"
    
    //  Number of points this survey will give the user.
    let worthPoints:Int = 0
    
    //  func to apply custom font to the pickers.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 12)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        
        if(pickerView == flavorPicker){
            pickerLabel.text = flavorTypes[row]
        }
        if(pickerView == weatherPicker){
            pickerLabel.text = weatherTypes[row]
        }
        if(pickerView == dayPicker){
            pickerLabel.text = dayTypes[row]
        }
        if(pickerView == friendsPicker){
            pickerLabel.text = friendTypes[row]
        }
        
        return pickerLabel
    }
    
    //  func to return proper picker content.
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var choice:String = ""
        
        if (pickerView == flavorPicker){
            //choice = flavorTypes[row]
            //return choice
            return flavorTypes[row]
        }
        if (pickerView == weatherPicker){
            return weatherTypes[row]
        }
        if (pickerView == dayPicker){
            return dayTypes[row]
        }
        
        return friendTypes[row]
    }
    
    //  func to return proper number of selections in a particular picker.
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if (pickerView == flavorPicker){
            return flavorTypes.count
        }
        if (pickerView == weatherPicker){
            return weatherTypes.count
        }
        if (pickerView == dayPicker){
            return dayTypes.count
        }
        
        return friendTypes.count
    }
    
    //  func to return number of components of picker, all need a value of 1.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    //  func for getting current picker choice
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == friendsPicker){
            ans4 = friendTypes[row]
        }
        if (pickerView == flavorPicker){
            ans1 = flavorTypes[row]
        }
        if (pickerView == weatherPicker){
            ans2 = weatherTypes[row]
        }
        if (pickerView == dayPicker){
            ans3 = dayTypes[row]
        }
        if (pickerView == friendsPicker){
            ans4 = friendTypes[row]
        }
        
        
    }
    
    //  When the user's done then save the user's answers on the database and alert the user of survey completion success.
    @IBAction func done(_ sender: UIButton) {
        let allPickerQsAnswered = survey.pickerQuesAnswered(in0: ans1, in1: ans2, in2: ans3, in3: ans4)
        
        
        
        
        let missingQ = survey.missingQuestionAlert(aTitle: "default", aMessage: "default")
        let completionAlert = survey.completionAlert(aTitle: customTitle, aMessage: customMessage, targetVC: self, email: false)
        
        
        if ( allPickerQsAnswered == false){
            self.present(missingQ, animated: true, completion: nil)
        }
        else{
            answerArray = survey.getAnswerAsArray(company: companyName,email: emailQR,in0: ans1, in1: ans2, in2: ans3, in3: ans4, in4: textAnswer.text!)
            
            cloudKitEng.saveUserAnswerData(recordTypeName: "SurveyData", answerKey: answerKeys, answers: answerArray, actInd: actIndicator, targetVC: self, alert: completionAlert)
            
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
