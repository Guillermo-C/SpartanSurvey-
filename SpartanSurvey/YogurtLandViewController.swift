//
//  YogurtLandViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 12/4/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class YogurtLandViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var flavorPicker: UIPickerView!
    
    @IBOutlet weak var weatherPicker: UIPickerView!
    
    @IBOutlet weak var dayPicker: UIPickerView!
    
    @IBOutlet weak var friendsPicker: UIPickerView!
    
    @IBOutlet weak var textAnswer: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var flavorTypes = ["Birthday Cupcake Batter","Almond Midnight Mocha","DJ Suki's Cranberry Raspberry Tart","Creek's Butterscotch Pudding Gelato","Guy Diamond's White Chocolate Peppermint","Pineapple Sorbet"]
    
    var weatherTypes = ["Sunny","Cloudy","Rainy","Windy","Snowy"]

    var dayTypes = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday", "Saturday"]
    
    var friendTypes = ["0","1","2","3", "more than 3"]
    
    
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
        
        /*if (pickerView == mcNuggetsPicker){
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
        }*/
        
        
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
