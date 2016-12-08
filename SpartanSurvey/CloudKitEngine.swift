//
//  CloudKitEngine .swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/20/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import Foundation
import CloudKit
import UIKit



//  For testing purposes
var recordFound = [CKRecord]()



class CloudKitEngine{
    
    //  Connect to the default public database in iCloud.
    let publicDataBase = CKContainer.default().publicCloudDatabase
    
    //  Variable holding a record.
    var record: CKRecord!
    
    //  Array containing records of specified queries.
    var namesArray: Array<CKRecord> = []
    
    //  Array containing the login credentials (email & pasword).
    var loginCredentials: Array<CKRecord> = []
    
    //  Array holding the registered emails.
    var emailArray = [String]()
    
    //  Var used as a counter, mainly for testing. Might delete it in the future.
    var counter:Int = 0
    
    
    //  func to be used in the ViewDidLoad() in the SignUpViewController. Mainly for query-testing purposes.
    func checkIfUserRegistered(){
        namesArray = Array<CKRecord>()
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "UserInfo", predicate: predicate)
        
        publicDataBase.perform(query, inZoneWith: nil){ results, error in
            if error != nil{
                
            }
            else{
                for result in results!{
                    self.namesArray.append(result)
                    print("\n\n\(result) would be appended\n\n")
                    print("\n\(self.namesArray.count) is the size of the array")
                    self.counter += 1
                }
            }
        }
        print("\nConunter value at end is \(counter)")
    }

    //  func to get all emails from the retrieved records (users registed in the system).
    func retrieveEmails(){
        print("Here would print them values")
        
        for i in 0...namesArray.count - 1 {
            let email = namesArray[i].value(forKey: "Email") as! NSString
            self.emailArray.append(email as String)
            print("Email: \(email)\n")
        }
    }
    
    //  func that detects if the user's email is registered and exists in the system.
    func userRegistered(email: String) -> Bool{
        if (emailArray.contains(email)){
            return true
        }
        return false
    }
    
    //  Create a method for saving data with a given record name.
    func saveNewDataWRecord(record_Name: String, recordTypeName: String, recordsToSave: [String], keyList: [String], actInd: UIActivityIndicatorView, targetVC: UIViewController){
        actInd.startAnimating()
        let recordId = CKRecordID(recordName: record_Name)
        let store = CKRecord(recordType: recordTypeName, recordID: recordId)

        
        //  Save each attribute in its corresponding key
        for i in 0...keyList.count - 1{
            let saveR = recordsToSave[i]
            let recKey = keyList[i]
            //actInd.startAnimating()
            //  If the record value to store is Int, save it as such.
            if(recKey == "Points"){
                let intValue:Int = Int(saveR)!
                
                store.setObject(intValue as CKRecordValue?, forKey: recKey)
                publicDataBase.save(store) { (savedRecord, error) -> Void in
                    if (error != nil){
                        print("Error while saving data")
                    }
                    else{
                        print("\n\n\n\nSweet...it worked :)")
                    }
                }
                
            }
            else{
                //  If the record value to store is String, save it as such.
                store.setObject(saveR as CKRecordValue?, forKey: recKey)
                publicDataBase.save(store) { (savedRecord, error) -> Void in
                    if (error != nil){
                        print("Error while saving data")
                    }
                    else{
                        print("\n\n\n\nSweet...it worked :)")
                    }
                }
            }
        }
        DispatchQueue.main.async {
            actInd.stopAnimating()
            let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signIn") as UIViewController
            targetVC.present(viewC, animated: true, completion: nil)
        }
    }
    
    //  Detect if user was previously and still is logged into iCloud on his phone
    func isiCloudAvailable() -> Bool {
        if FileManager.default.ubiquityIdentityToken != nil{
            
            return true
        }
        else{
            return false
        }
    }
    
    //  func for printing a fetched block of data.
    func recordFetchBlock(record: CKRecord!){
        print("Fetched a record\n\n \(record)")
    }

    
    //  func to retrieve all users registered in the system.
    func registeredUsers(){
        namesArray = Array<CKRecord>()
        let predicate = NSPredicate(value:true)
        let query = CKQuery(recordType: "UserInfo", predicate: predicate)
        
        publicDataBase.perform(query, inZoneWith: nil){ results, error in
            if error != nil{
                
            }
            else{
                for result in results!{
                    self.namesArray.append(result)
                }
            }
        }
    }
    
    //  func get user's login credentials with the associated email. Grant access if user provides the right credentials, alert the user otherwise.
    func getLogInCredentials(email: String, password: String, actInd: UIActivityIndicatorView, targetVC: UIViewController, alert: UIAlertController){
        let lookEmail = email
        let predicate = NSPredicate(format: "Email  = %@", lookEmail)
        let query = CKQuery(recordType: "UserInfo", predicate: predicate)
        actInd.startAnimating()
        
        
        publicDataBase.perform(query, inZoneWith: nil){ results, error in
            if error != nil{
                
            }
            else{
                for result in results!{
                    self.loginCredentials.append(result)
                }
            }
            
            DispatchQueue.main.async {
                
                if (self.loginCredentials.count > 0){
                    let retrievedPass:String = self.loginCredentials[0].value(forKey: "Password") as! String
                    actInd.stopAnimating()
                    
                    if (password == retrievedPass){
                        let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userProfileView") as UIViewController
                        targetVC.present(viewC, animated: true, completion: nil)
                        
                        nameOfUser = self.getNameOfUser(record: self.loginCredentials)
                        userPoints = self.pointsOfUser(record: self.loginCredentials) 
                        emailOfUser = self.getEmailFromCred(record: self.loginCredentials)
                        
                    }
                    else{
                        targetVC.present(alert, animated: true, completion: nil)
                    }
                  
                }
                /*let retrievedPass:String = self.loginCredentials[0].value(forKey: "Password") as! String
                actInd.stopAnimating()
                
                if (password == retrievedPass){
                    let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userProfileView") as UIViewController
                    targetVC.present(viewC, animated: true, completion: nil)
                    
                    nameOfUser = self.getNameOfUser(record: self.loginCredentials)
                    userPoints = self.pointsOfUser(record: self.loginCredentials)
                    emailOfUser = self.getEmailFromCred(record: self.loginCredentials)
                    
                }
                else{
                    targetVC.present(alert, animated: true, completion: nil)
                }*/
            }
        }

    }

    
    //  func to retrieve the email of the user from the record obtained previously with a query
    func getEmailFromCred(record: [CKRecord]) -> String{
        let email:String = record[0].value(forKey: "Email") as! String
        
        return email
    }
    
    
    //  func to retrieve the password of the user from the record obtained previously with a query
    func getPassFromCred(record: [CKRecord]) -> String{
        let pass:String = record[0].value(forKey: "Password") as! String
        
        return pass
    }
    
    //  func to get the name of the user with the associated email
    func getNameOfUser(record: [CKRecord]) -> String{
        let pass:String = record[0].value(forKey: "FirstName") as! String
        
        return pass
    }
    
    //  func to get the points of the loggedin user
    func pointsOfUser(record: [CKRecord]) -> String{
        
        var pass:String = "0"
        
        if (record.count > 0){
            pass = String(describing: record[0].value(forKey: "Points")!)
        }
        
        return pass
    }

    
    //  func to save the questions 
    func saveUserAnswerData(recordTypeName: String, answerKey: [String], answers: [String], actInd: UIActivityIndicatorView, targetVC: UIViewController, alert: UIAlertController){
        let store = CKRecord(recordType: recordTypeName)
        actInd.startAnimating()
        
        for i in 0...answerKey.count - 1{
            let saveR = answers[i]
            let recKey = answerKey[i]
            
            
            store.setObject(saveR as CKRecordValue?, forKey: recKey)
            publicDataBase.save(store) { (savedRecord, error) -> Void in
                if (error != nil){
                    print("Error, perhaps not answers were properly saved in the database")
                }else{
                    print("All user's responses were saved")
                }
                DispatchQueue.main.async {
                    actInd.stopAnimating()
                    //targetVC.present(alert, animated: true, completion: nil)
                    
                    /*let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "userProfileView") as UIViewController
                    targetVC.present(viewC, animated: true, completion: nil)*/
                }
            }
        }
    }
    
    //  func to retrieve all answers with the specified email
    func getAllAnswers(email: String){
        
        let lookEmail = email
        let predicate = NSPredicate(format: "Email  = %@", lookEmail)
        let query = CKQuery(recordType: "SurveyData", predicate: predicate)
        
        print("\nThe result for the 'Answers' part would be as follows. \n")
        
        publicDataBase.perform(query, inZoneWith: nil){ results, error in
            if error != nil{
                
            }
            else{
                for result in results!{
                    
                    recordFound.append(result)
                    print("\n\n\(result) would be appended\n\n")
                }
            }
             print("\nThe size of the answer record is \(recordFound.count)\n")
        }

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //  testing
    //  purpose: make sure that all the answers of the user are successfully printed.
    var recordAnswers = [CKRecord]()
    func retrieveAnswers(email: String, textblock: UITextView){
        //var stringArray = [String]()
        //var records = [CKRecord]()
        
        let lookEmail = email
        let predicate = NSPredicate(format: "Email  = %@", lookEmail)
        let query = CKQuery(recordType: "SurveyData", predicate: predicate)
        publicDataBase.perform(query, inZoneWith: nil){ results, error in
            if error != nil{
                textblock.text = textblock.text! + "\nThere was an internal error in the SpartanSurvey app"
            }
            else{
                for result in results!{
                    self.recordAnswers.append(result)
                    //recordFound.append(result)
                    print("\nSize of recordAnswers: \(self.recordAnswers.count)")
                }
            }
            //print("\nThe size of the answer record is \(recordFound.count)\n")
            DispatchQueue.main.async {
                self.getAnswers(textBlock: textblock)
            }
        }

        
        
        //return stringArray
    }
    
    //  func to get the answers to be displayed in a UITextView. 
    //  This func is called within the retrieveAnswers()
    func getAnswers(textBlock: UITextView){
        /*var stringArray = [String]()
        let numberOfKeys = recordAnswers[0].allKeys().count
        var keyArray = [String]()
        keyArray = recordAnswers[0].allKeys()
        let numberOfRec = recordAnswers.count*/
        
        if (recordAnswers.count > 0){
            //var stringArray = [String]()
            let numberOfKeys = recordAnswers[0].allKeys().count
            var keyArray = [String]()
            keyArray = recordAnswers[0].allKeys()
            let numberOfRec = recordAnswers.count
            var currentVal:String = ""
            textBlock.text = ""
            
            for i in 0...numberOfRec - 1{
                let currentRec = recordAnswers[i]
                //let currentKey = keyArray[i]
                //textBlock.text = textBlock.text! + "Key: \(currentKey)"
                for j in 0...numberOfKeys - 1{
                    //var forKey:String =
                    let currentKey = keyArray[j]
                    currentVal = currentRec.value(forKey: keyArray[j]) as! String
                    textBlock.text = textBlock.text! + "Key: \(currentKey)\t Val: \(currentVal)\n"
                    
                }
                textBlock.text = textBlock.text! + "\n"
            }
        }
        
        
        
       // return stringArray
    }
    
    
    
    //  end of testing
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //  This is the previous printAnswers() used. It works to an extent. Uncomment out when done testing
    
    /*func printAnswers(recordArray: [CKRecord], canvas: UITextView) -> [String]{
        var stringArray = [String]()
        var count:Int = 0                    // Keep track of counter for printing values from database
        var sizeToGo:Int = recordArray.count // Number of surveys found taken by the user
        var answerKey = ["Answer1", "Answer2", "Answer3", "Answer4", "Answer5"]
        canvas.text = ""
        var loadedAll:Bool = false
        //  code below works, uncomment when done testing
        /*for var i in 0...answerKey.count - 1 {

            let currentKey = answerKey[i]
            let answer = recordArray[count].value(forKey: currentKey) as! NSString
            canvas.text = canvas.text! + (answer as String) + "\n"
            stringArray.append(answer as String)
            
            if((i == answerKey.count - 1) && (sizeToGo > 0)){
                i = 0
                count = 0
                sizeToGo -= 1
                canvas.text = canvas.text! + "\ndid go in last if"
                
            }

            
        }*/
        
        //  Code below for testing only, delete after
        while ((sizeToGo >= 0)){
            
            for var i in 0...answerKey.count - 1 {
                
                let currentKey = answerKey[i]
                let answer = recordArray[count].value(forKey: currentKey) as! NSString
                canvas.text = canvas.text! + (answer as String) + "\n"
                stringArray.append(answer as String)
                
                if((i == answerKey.count - 1) && (sizeToGo > 0)){
                    i = 0
                    count = 0
                    sizeToGo -= 1
                }

                
            }
            canvas.text = canvas.text! + "\n"
            count += 1
            sizeToGo -= 1
            
           
        }
        
        
        return stringArray
    }*/

    var tempRecord = [CKRecord]()
    
    //  func to get the answer to the security question given by the user, returns answer as String. 
    func getSecurityQuetionAns(email: String, alert: UIAlertController, actInd: UIActivityIndicatorView){
        //var tempRecord = [CKRecord]()
        //var answer:String = ""
        actInd.startAnimating()
        let Email = email
        let answer:String = ""
        let predicate = NSPredicate(format: "Email  = %@", Email)
        let query = CKQuery(recordType: "UserInfo", predicate: predicate)
        
        
        if (answer == ""){
            publicDataBase.perform(query, inZoneWith: nil){ results, error in
                if error != nil{
                    
                }
                else{
                    for result in results!{
                        //answer = result.value(forKey: "SecurityQuestionAnswer") as! String
                        
                        self.tempRecord.append(result)
                        //temp = self.answer
                        //answer = "Was modified"
                        //print("\nThe answer retrieved was: \(answer)")
                        //break
                        //tempRecord.append(result)
                    }
                    //answer = tempRecord[0].value(forKey: "SecurityQuestionAnswer") as! String
                }
                DispatchQueue.main.async {
                    if (self.tempRecord.count > 0){
                        alert.textFields?.last?.isUserInteractionEnabled = true
                        alert.message = self.tempRecord[0].value(forKey: "SecurityQuestion") as! String
                        
                    }
                    if (self.tempRecord.count == 0){
                        alert.textFields?.last?.isUserInteractionEnabled = false
                        alert.textFields?.last?.text = ""
                        alert.message = "No records were found with the email provided."
                    }

                    actInd.stopAnimating()
                }
                
            }
        }
        
        

        /*publicDataBase.perform(query, inZoneWith: nil){ results, error in
            if error != nil{
                
            }
            else{
                for result in results!{
                    answer = result.value(forKey: "SecurityQuestionAnswer") as! String
                    //temp = self.answer
                    //answer = "Was modified"
                    print("\nThe answer retrieved was: \(answer)")
                    break
                    //tempRecord.append(result)
                }
                //answer = tempRecord[0].value(forKey: "SecurityQuestionAnswer") as! String
            }

            
        }*/


        
        //return answer
    }
    
    //  func to get the answer to the security question to later on compare to user's answer.
    func getAns() -> String{
        
        if(self.tempRecord.count > 0){
            let answer:String = tempRecord[0].value(forKey: "SecurityQuestionAnswer") as! String
            tempRecord.removeAll()
            return answer
        }
        return ""
    }
    
    // func to get the password of the user. Delete the tempRecord when done.
    func getPass() -> String{
        if (self.tempRecord.count > 0){
            let pass:String = tempRecord[0].value(forKey: "Password") as! String
            return pass
        }
        return ""
    }
    
    //  func to get the number of points earned by the user after taking a survey
    func getPoints() -> Int{
        if (self.tempRecord.count > 0){
            let pts:Int = tempRecord[0].value(forKey: "Points") as! Int
            return pts
        }
        return 0
    }

    
    
    
    
    //  func to update user's points 
    var fetchedRecord:CKRecord!
    
    func updatePoints(email: String, worthPts: Int){
        if (email != "No Email"){
            let recordID:CKRecordID = CKRecordID(recordName: email)
            var points:Int = getPoints()
            publicDataBase.fetch(withRecordID: recordID){ (record, error) in
                if error != nil{
                    
                }else{
                    self.fetchedRecord = record!
                    points += worthPts
                    self.fetchedRecord?.setObject(points as CKRecordValue?, forKey: "Points")
                }
                DispatchQueue.main.async {
                    self.publicDataBase.save(self.fetchedRecord){ (savedRecord, error) -> Void in
                        if error != nil {
                            
                        }
                        else{
                            
                        }
                    }
                    
                }
            }
        }




    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //  var to hold the number of points of the user
    //var points:Int = -1
    //  func to get the current number of points of a user 
    /*func getPoints(email: String) -> Int {
        let lookEmail = email
        let predicate = NSPredicate(format: "Email  = %@", lookEmail)
        let query = CKQuery(recordType: "UserInfo", predicate: predicate)
        //var points:Int = -1
        var record:CKRecord!
        
        
        publicDataBase.perform(query, inZoneWith: nil){ results, error in
            if error != nil{
                
            }
            else{
                for result in results!{
                    //recordFound.append(result)
                    //record = result
                    self.points = result.value(forKey: "Points") as! Int
                    
                }

            }

        }

        return self.points
    }*/
    

    
    
    
}
