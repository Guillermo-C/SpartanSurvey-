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
    func saveNewDataWRecord(record_Name: String, recordTypeName: String, recordsToSave: [String], keyList: [String], actInd: UIActivityIndicatorView){
        let recordId = CKRecordID(recordName: record_Name)
        let store = CKRecord(recordType: recordTypeName, recordID: recordId)
        
        //  Save each attribute in its corresponding key
        for i in 0...keyList.count - 1{
            let saveR = recordsToSave[i]
            let recKey = keyList[i]
            
            
            store.setObject(saveR as CKRecordValue?, forKey: recKey)
            publicDataBase.save(store) { (savedRecord, error) -> Void in
                if (error != nil){
                    print("Error while saving data")
                    print(error.debugDescription)
                }
                else{
                    print("\n\n\n\nSweet...it worked :)")
                }
            }
            DispatchQueue.main.async {
                actInd.stopAnimating()
            }
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
    
    //  func get user's login credentials with the associated email
    func getLogInCredentials(email: String, password: String){
        let lookEmail = email
        let predicate = NSPredicate(format: "Email  = %@", lookEmail)
        let query = CKQuery(recordType: "UserInfo", predicate: predicate)
        
        publicDataBase.perform(query, inZoneWith: nil){ results, error in
            if error != nil{
                
            }
            else{
                for result in results!{
                    self.loginCredentials.append(result)
                    print("\n\n\(result) would be appended\n\n")
                }
            }
        }
    }
    
    //  func that check is user is in fact registered with the system. If a record associated with the user, then user might log in.
    func logUserIn() -> Bool{
        if (loginCredentials.count > 1){
            return true
        }
        return false
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
        let pass:String = String(describing: record[0].value(forKey: "Points")!)
        
        return pass
    }

    
    //  func to save the questions 
    func saveUserAnswerData(recordTypeName: String, answerKey: [String], answers: [String]){
        let store = CKRecord(recordType: recordTypeName)
        
        
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
            }
        }
    }
    
    
    //  For testing purposes
    //var recordFound = [CKRecord]()
    
    
    //  func to retrieve all answers with the specified email
    func getAllAnswers(email: String){
        
        //var recordFound = [CKRecord]()
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
    
    func printAnswers(recordArray: [CKRecord], canvas: UITextView) -> [String]{
        var stringArray = [String]()
        var answerKey = ["Answer1", "Answer2", "Answer3", "Answer4", "Answer5"]
        canvas.text = ""
        
        for i in 0...answerKey.count - 2 {
            let currentKey = answerKey[i]
            let answer = recordArray[0].value(forKey: currentKey) as! NSString
            canvas.text = canvas.text! + (answer as String) + "\n"
            stringArray.append(answer as String)
            
            
        }
        
        
        return stringArray
    }
    
    
    
}
