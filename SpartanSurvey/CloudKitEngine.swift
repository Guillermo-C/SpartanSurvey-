//
//  CloudKitEngine .swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/20/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitEngine{
    
    let publicDataBase = CKContainer.default().publicCloudDatabase
    
    
    var record: CKRecord!
    
    
    var namesArray: Array<CKRecord> = []
    
    var emailArray = [String]()
    
    
    var counter:Int = 0
    
    
    func checkIfUserRegistered(){
        namesArray = Array<CKRecord>()
        
        
        //let targetEmail:String = "michael@sjsu.edu"
        //let firstName: String = "Michael"
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
        //print("\n\nThe contents of namesArray is \(namesArray)\nand its size is \(namesArray.count)\n\n")
        print("\nConunter value at end is \(counter)")
    }

    
    func checkIfDataAvailable() -> Bool {
        if(namesArray.count > 0){
            return true
        }
        return false
    }
    
    func valueOfCounter(){
        print("\ncounter outside of query is: \(counter)")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //  Create a method for saving data with a given record name
    func saveNewDataWRecord(record_Name: String, recordTypeName: String, recordsToSave: [String], keyList: [String]){
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
    
    
    func recordFetchBlock(record: CKRecord!){
        print("Fetched a record\n\n \(record)")
    }
    
    
    

    
}
