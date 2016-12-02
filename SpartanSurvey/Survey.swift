//
//  Survey.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 12/1/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import Foundation
import UIKit


class Survey{
    
    
    
    //  func to alert user didn't finish survey.
    func missingQuestionAlert(aTitle: String, aMessage: String) -> UIAlertController{
        var alertTitle =  aTitle
        var alertMessage = aMessage
        
        if((alertTitle == "default") && (alertMessage == "default")){
            alertTitle = "Check your answers"
            alertMessage = "You are almost there! Make sure that you answered all the questions."
        }
        
        let missingQuesAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        missingQuesAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        return missingQuesAlert
    }
    
    // func to alert user of a successful survey completion, and take the user to the userProfileView when done.
    func completionAlert(aTitle: String, aMessage: String, targetVC: UIViewController) -> UIAlertController{
        var alertTitle =  aTitle
        var alertMessage = aMessage
        
        if((alertTitle == "default") && (alertMessage == "default")){
            alertTitle = "Check your answers"
            alertMessage = "You are almost there! Make sure that you answered all the questions."
        }
        
        
        let completionAlert = UIAlertController(title: "Congrats!", message: "You just earned 5 points. Note: points might take long to reflect", preferredStyle: UIAlertControllerStyle.alert)
        
        completionAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userProfileView") as UIViewController
            targetVC.present(viewC, animated: true, completion: nil)
        }))
        
        return completionAlert
    }
    
    
    // func to check all picker questions were answer
    func pickerQuesAnswered(in0: String, in1: String, in2: String, in3: String) -> Bool {
        var answeredAll:Bool = false
        
        if ((in0 != "") && (in1 != "") && (in2 != "") && (in3 != "")){
            answeredAll = true
        }
        
        return answeredAll
    }
    
    //  func to put answers into an array
    func getAnswerAsArray(company:String, email: String, in0:String, in1: String, in2:String, in3:String, in4: String) -> [String]{
        var tempArray = [String]()
        
        tempArray.append(company)
        tempArray.append(email)
        tempArray.append(in0)
        tempArray.append(in1)
        tempArray.append(in2)
        tempArray.append(in3)
        tempArray.append(in4)
        
        
        return tempArray
        
    }
    
}
