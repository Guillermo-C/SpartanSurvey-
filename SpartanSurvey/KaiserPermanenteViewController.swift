//
//  KaiserPermanenteViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/18/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class KaiserPermanenteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var physicallyHealthyPicker: UIPickerView!
    @IBOutlet weak var exerciseImportancePicker: UIPickerView!
    @IBOutlet weak var exerciseFrequencyPicker: UIPickerView!
    @IBOutlet weak var mealsPicker: UIPickerView!
    
    
    @IBOutlet weak var textAnswer: UITextField!
    
    
    
    
    var physicallyHealthyTypes = ["Extremely healthy","Healthy","Not at all healthy"]
    
    var exerciseImportanceTypes = ["Extremely important","Not at all important","N/A"]
    
    var exerciseFrequencyTypes = ["Lift weights","Walk","Run","Hike","Dance"]
    
    var mealsTypes = ["1","2","3","4", "5", "more than 5"]
    
    //  name of the survey for identification when querying through the database
    var companyName:String = "Kaiser"
    
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
    
    
    var survey =  Survey()

    
    //  func to apply custom font to the pickers.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 12)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        
        if(pickerView == physicallyHealthyPicker){
            pickerLabel.text = physicallyHealthyTypes[row]
        }
        if(pickerView == exerciseImportancePicker){
            pickerLabel.text = exerciseImportanceTypes[row]
        }
        if(pickerView == exerciseFrequencyPicker){
            pickerLabel.text = exerciseFrequencyTypes[row]
        }
        if(pickerView == mealsPicker){
            pickerLabel.text = mealsTypes[row]
        }
        
        return pickerLabel
    }
    
    
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == physicallyHealthyPicker){
            return physicallyHealthyTypes[row]
        }
        
        if (pickerView == exerciseImportancePicker){
            return exerciseImportanceTypes[row]
        }
        
        if (pickerView == exerciseFrequencyPicker){
            return exerciseFrequencyTypes[row]
        }
        
        
        return mealsTypes[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if (pickerView == physicallyHealthyPicker){
            return physicallyHealthyTypes.count
        }
        
        if (pickerView == exerciseImportancePicker){
            return exerciseImportanceTypes.count
        }
        
        if (pickerView == exerciseFrequencyPicker){
            return exerciseFrequencyTypes.count
        }
        
        return mealsTypes.count
    }
    
    //  func for getting current picker choice
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == physicallyHealthyPicker){
            ans1 = physicallyHealthyTypes[row]
        }
        if (pickerView == exerciseImportancePicker){
            ans2 = exerciseImportanceTypes[row]
        }
        if (pickerView == exerciseFrequencyPicker){
            ans3 = exerciseFrequencyTypes[row]
        }
        
        if (pickerView == mealsPicker){
            ans4 = mealsTypes[row]
        }
        
        
    }
 
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    @IBAction func done(_ sender: Any) {
        
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
