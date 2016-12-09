//
//  SoccerViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/23/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

//  Class for the Soccer survey. 
class SoccerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  UIPickerView for the favorite soccer player question.
    @IBOutlet weak var soccerPlayerPicker: UIPickerView!
    
    //  UIPickerView for the favorite soccer team question.
    @IBOutlet weak var soccerTeamPicker: UIPickerView!
    
    //  UIPickerView for the favorite national team question.
    @IBOutlet weak var nationalTeamPicker: UIPickerView!
    
    //  UIPickerView for the desired position question.
    @IBOutlet weak var desiredPositionPicker: UIPickerView!
    
    // UITextField to hold the answer of text.
    @IBOutlet weak var textAnswer: UITextField!
    
    //  Number of points this survey will give the user.
    let worthPoints:Int = 5
    
    //  Array holding the answers of the user.
    var answerArray = [String]()
    
    //  Invoke the class CloudKitEngine for saving data in the cloud
    let cloudKitEng = CloudKitEngine()
    
    //  Invoke the class Survey for implementing survey completion elements.
    var survey =  Survey()
    
    //  Array with the values for the favorite soccer player question.
    var soccerPlayerVals = ["↓ Scroll down ↓","Cristiano Ronaldo","Lionel Messi","Gareth Bale","Manuel Neuer","Wayne Rooney","Iker Casillas"]
    
    //  Array with the values for the favorite soccer team question.
    var teamVals = ["↓ Scroll down ↓","Real Madrid C.F.","Inter Milan","Atlético Madrid","FC Barcelona","Arsenal F.C."]
    
    //  Array with the values for the favorite national team question.
    var nationalTeamVals = ["↓ Scroll down ↓","Japan National Team","USA National Team","Spain National Team","Argentina National Team"]
    
    //  Array with the values for the desired position question.
    var soccerPositionVals = ["↓ Scroll down ↓","goalkeeper","defensive midfielder","forward","striker"]
    
    //  name of the survey for identification when querying through the database
    var companyName:String = "Soccer"
    
    //  Array holding the key names to properly store the answers of the user.
    var answerKeys = ["SurveyCompany","Email","Answer1","Answer2","Answer3","Answer4","Answer5"]
    
    //  vars for storing the answers from the pickers.
    var ans1:String = ""
    var ans2:String = ""
    var ans3:String = ""
    var ans4:String = ""
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //  func to apply custom font to the pickers.
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == soccerPlayerPicker){
            return soccerPlayerVals[row]
        }
        
        if (pickerView == soccerTeamPicker){
            return teamVals[row]
        }
        
        if (pickerView == nationalTeamPicker){
            return nationalTeamVals[row]
        }
        
        
        return soccerPositionVals[row]
    }
    
    //  func to return proper number of selections in a particular picker.
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if (pickerView == soccerPlayerPicker){
            return soccerPlayerVals.count
        }
        
        if (pickerView == soccerTeamPicker){
            return teamVals.count
        }
        
        if (pickerView == nationalTeamPicker){
            return nationalTeamVals.count
        }
        
        
        return soccerPositionVals.count

    }
    
    //  func to return number of components of picker, all need a value of 1.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    
    //  func for getting current picker choice
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == soccerPlayerPicker){
            ans1 = soccerPlayerVals[row]
        }
        if (pickerView == soccerTeamPicker){
            ans2 = teamVals[row]
        }
        if (pickerView == nationalTeamPicker){
            ans3 = nationalTeamVals[row]
        }
        
        if (pickerView == desiredPositionPicker){
            ans4 = soccerPositionVals[row]
        }
        
        
    }
    
    //  When the user's done then save the user's answers on the database and alert the user of survey completion success.
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
            
            present(completionAlert, animated: true, completion: nil)
        }
        
    }

    

}
