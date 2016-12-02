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
    
    
    
    //  func to alert user didn't finish survey 
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
    
}
