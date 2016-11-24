//
//  SoccerViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/23/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class SoccerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var soccerPlayerPicker: UIPickerView!
    @IBOutlet weak var soccerTeamPicker: UIPickerView!
    @IBOutlet weak var nationalTeamPicker: UIPickerView!
    @IBOutlet weak var desiredPositionPicker: UIPickerView!
    
    var soccerPlayerVals = ["Cristiano Ronaldo","Lionel Messi","Gareth Bale","Manuel Neuer","Wayne Rooney","Iker Casillas"]
    
    var teamVals = ["Real Madrid C.F.","Inter Milan","Atlético Madrid","FC Barcelona","Arsenal F.C."]
    
    var nationalTeamVals = ["Japan National Team","USA National Team","Spain National Team","Argentina National Team"]
    
    var soccerPositionVals = ["goalkeeper","defensive midfielder","forward","striker"]
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }

}
