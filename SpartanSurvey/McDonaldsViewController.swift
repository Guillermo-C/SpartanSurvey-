//
//  McDonaldsViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/12/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit


class McDonaldsViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    //  UIPickerView for the mcNuggets question.
    @IBOutlet weak var mcNuggetsPicker: UIPickerView!
    
    //  UIPickerView for the burger question.
    @IBOutlet weak var burgerPicker: UIPickerView!
    
    //  UIPickerView for the mcCafe question.
    @IBOutlet weak var mcCaféPicker: UIPickerView!
    
    //  UIPickerView for salad question.
    @IBOutlet weak var saladPicker: UIPickerView!

    
    @IBOutlet weak var titleLabel: UILabel!
    
    // UITextField to hold the answer of text. 
    @IBOutlet weak var textAnswer: UITextField!
    
    
    //
    var titleString: String = "McDonald's"
    
    //  Array holding the answers of the user. 
    var answerArray = [String]()
    
    //  Invoke the class CloudKitEngine for saving data in the cloud
    let cloudKitEng = CloudKitEngine()
    
    //  Activity indicator.
    var actIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    //  Array with possible answers for the mcNugget question.
    var numberOfNuggets = ["↓ Scroll down ↓","4","6","10","20"]
    
    //  Array with possible answers for the burger question.
    var burgerTypes = ["↓ Scroll down ↓","Big Mac", "McDouble", "Double Cheeseburger"]
    
    //  Array with possible answers for the mcCafe question.
    var mcCafeTypes = ["↓ Scroll down ↓","McCafé Coffee","McCafé Caramel Mocha","McCafe Latte","McCafé Peppermint Mocha","McCafé Peppermint Hot Chocolate","McCafé® Hot Chocolate"]
    
    //  Array with possible answers for the salads question.
    var saladTypes = ["↓ Scroll down ↓","Bacon Ranch Salad & Buttermilk Crispy Chicken","Bacon Ranch Grilled Chicken Salad","Southwest Buttermilk Crispy Chicken Salad","Southwest Grilled Chicken Salad","Side Salad"]
    
    //  Array holding the key names to properly store the answers of the user.
    var answerKeys = ["Email","Answer1","Answer2","Answer3","Answer4","Answer5"]
    
    //  Alert for user when the survey is completed.
    let completionAlert = UIAlertController(title: "Congrats!", message: "You just earned 5 points. Note: points might take long to reflect", preferredStyle: UIAlertControllerStyle.alert)
    
    
    
    let missingQuestionAlert = UIAlertController(title: "Check your answers", message: "You are almost there! Make sure that you answered all the questions.", preferredStyle: UIAlertControllerStyle.alert)
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.titleLabel.text = self.titleString
        
        //  For activity indicator
        actIndicator.center = self.view.center
        actIndicator.hidesWhenStopped = true
        actIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(actIndicator)

        
        
        missingQuestionAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  vars for storing the answers from the pickers.
    var ans1:String = ""
    var ans2:String = ""
    var ans3:String = ""
    var ans4:String = ""
    
    //  func to apply custom font to the pickers.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 12)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        
        if(pickerView == burgerPicker){
            pickerLabel.text = burgerTypes[row]
        }
        if(pickerView == saladPicker){
            pickerLabel.text = saladTypes[row]
        }
        if(pickerView == mcCaféPicker){
            pickerLabel.text = mcCafeTypes[row]
        }
        if(pickerView == mcNuggetsPicker){
            pickerLabel.text = numberOfNuggets[row]
        }
        
        return pickerLabel
    }
    
    //  func to return proper picker content.
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var choice:String = ""
        
        if (pickerView == burgerPicker){
            choice = burgerTypes[row]
            return choice
            //return burgerTypes[row]
        }
        if (pickerView == mcCaféPicker){
            return mcCafeTypes[row]
        }
        if (pickerView == saladPicker){
            return saladTypes[row]
        }
        
        return numberOfNuggets[row]
    }
    
    //  func to return proper number of selections in a particular picker.
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if (pickerView == burgerPicker){
            return burgerTypes.count
        }
        if (pickerView == mcCaféPicker){
            return mcCafeTypes.count
        }
        if (pickerView == saladPicker){
            return saladTypes.count
        }
        
        return numberOfNuggets.count
    }
    
    //  func to return number of components of picker, all need a value of 1.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    //  func for getting current picker choice
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == mcNuggetsPicker){
            ans2 = numberOfNuggets[row]
        }
        if (pickerView == mcCaféPicker){
            ans3 = mcCafeTypes[row]
        }
        if (pickerView == saladPicker){
            ans4 = saladTypes[row]
        }
        
        if (pickerView == burgerPicker){
            ans1 = burgerTypes[row]
        }

        
    }
    
    //  When the user's done then save the user's answers on the database and alert the user of survey completion success.
    @IBAction func done(_ sender: UIButton) {
        let allPickerQsAnswered = pickerQuesAnswered(in0: ans1, in1: ans2, in2: ans3, in3: ans4)
        
        if ( allPickerQsAnswered == false){
            self.present(missingQuestionAlert, animated: true, completion: nil)
            
        }
        else{
            answerArray = getAnswerAsArray(email: emailOfUser,in0: ans1, in1: ans2, in2: ans3, in3: ans4, in4: textAnswer.text!)
            
            cloudKitEng.saveUserAnswerData(recordTypeName: "SurveyData", answerKey: answerKeys, answers: answerArray, actInd: actIndicator, targetVC: self, alert: completionAlert)
            
            completionAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
                let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userProfileView") as UIViewController
                self.present(viewC, animated: true, completion: nil)
            }))
            
            present(completionAlert, animated: true, completion: nil)
        }
        
        //  Code below works
        //  Uncomment after testing
        /*answerArray = getAnswerAsArray(email: emailOfUser,in0: ans1, in1: ans2, in2: ans3, in3: ans4, in4: textAnswer.text!)
        
        cloudKitEng.saveUserAnswerData(recordTypeName: "SurveyData", answerKey: answerKeys, answers: answerArray, actInd: actIndicator, targetVC: self, alert: completionAlert)
        
        completionAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userProfileView") as UIViewController
            self.present(viewC, animated: true, completion: nil)
        }))
        
        present(completionAlert, animated: true, completion: nil)*/
    }
    
    //  func to put answers into an array
    func getAnswerAsArray(email: String, in0:String, in1: String, in2:String, in3:String, in4: String) -> [String]{
        var tempArray = [String]()
        
        tempArray.append(email)
        tempArray.append(in0)
        tempArray.append(in1)
        tempArray.append(in2)
        tempArray.append(in3)
        tempArray.append(in4)
        
        
        return tempArray
        
    }
    

    
    // func to check all picker questions were answer 
    func pickerQuesAnswered(in0: String, in1: String, in2: String, in3: String) -> Bool {
        var answeredAll:Bool = false
        
        if ((in0 != "") && (in1 != "") && (in2 != "") && (in3 != "")){
            answeredAll = true
        }
        
        return answeredAll
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
