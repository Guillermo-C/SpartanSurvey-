//
//  McDonaldsViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/12/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class McDonaldsViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var mcNuggetsPicker: UIPickerView!
    @IBOutlet weak var burgerPicker: UIPickerView!
    @IBOutlet weak var mcCaféPicker: UIPickerView!
    @IBOutlet weak var saladPicker: UIPickerView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textAnswer: UITextField!
    
    //  Current picker choice
    var currentPickerChoice:String = ""
    
    //
    var titleString: String!
    
    //  Array holding the answers of the user. 
    var answerArray = [String]()
    
    //  Invoke the class CloudKitEngine for saving data in the cloud
    let cloudKitEng = CloudKitEngine()
    
    var ans1:String = ""
    var ans2:String = ""
    var ans3:String = ""
    var ans4:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleString = "Did I even put this?"
        self.titleLabel.text = self.titleString
        
        mcNuggetsPicker.delegate = self
        mcNuggetsPicker.dataSource = self
        
        burgerPicker.delegate = self
        burgerPicker.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var numberOfNuggets = ["4","6","10","20"]
    var burgerTypes = ["Big Mac", "McDouble", "Double Cheeseburger"]
    var mcCafeTypes = ["McCafé Coffee","McCafé Caramel Mocha","McCafe Latte","McCafé Peppermint Mocha","McCafé Peppermint Hot Chocolate","McCafé® Hot Chocolate"]
    var saladTypes = ["Bacon Ranch Salad & Buttermilk Crispy Chicken","Bacon Ranch Grilled Chicken Salad","Southwest Buttermilk Crispy Chicken Salad","Southwest Grilled Chicken Salad","Side Salad"]
    
    var answerKeys = ["Email","Answer1","Answer2","Answer3","Answer4","Answer5"]
    
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == burgerPicker){
            return burgerTypes[row]
        }
        if (pickerView == mcCaféPicker){
            return mcCafeTypes[row]
        }
        if (pickerView == saladPicker){
            return saladTypes[row]
        }
        
        return numberOfNuggets[row]
    }
    
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
        
        ans1 = burgerTypes[row]
        
    }
    
    @IBAction func done(_ sender: UIButton) {
        answerArray = getAnswerAsArray(email: emailOfUser,in0: ans1, in1: ans2, in2: ans3, in3: ans4, in4: textAnswer.text!)
        cloudKitEng.saveUserAnswerData(recordTypeName: "SurveyData", answerKey: answerKeys, answers: answerArray)
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
