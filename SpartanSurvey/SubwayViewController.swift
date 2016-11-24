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
    
    var subOfDayTypes = ["Sweet Onion Chicken Teriyaki","Oven Roasted Chicken","Turkey Breast","Classic Tuna","Black Forest Ham"]
    
    var breakFastTypes = ["Beacon, Egg & Cheese","Egg & Cheese","Steak, Egg & Cheese"]
    
    var saladTypes = ["Corned Beef Reuben Salad","Turkey Reuben Salad","Spicy Italian Salad","Veggie Delite Salad","Tuna Salad","Subway Club Salad"]
    
    var extrasTypes = ["Pepperoni","Cheese","Bacon"]
    
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
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
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
