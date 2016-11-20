//
//  McDonaldsViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/12/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class McDonaldsViewController: UIViewController {
    

    @IBOutlet weak var titleLabel: UILabel!
    
    
    var titleString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.titleString

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var numberOfNuggets = [1,2,3,5]
    

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfNuggets.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return String(numberOfNuggets[row])
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
