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

    @IBOutlet weak var titleLabel: UILabel!
    
    
    var titleString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    var numberOfNuggets = ["1","2","3","4"]
    var burgerTypes = ["Big Mac", "McDouble", "Double Cheeseburger"]
    
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (pickerView == burgerPicker){
            return burgerTypes[row]
        }
        
        return numberOfNuggets[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if (pickerView == burgerPicker){
            return burgerTypes.count
        }
        
        return numberOfNuggets.count
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
