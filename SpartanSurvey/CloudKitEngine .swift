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
    
    /*var Email: String{
        get{
            return self.record!.object(forKey: "Email") as! String
        }
        set(newVal){
            let myRecordId = CKRecordID(recordName: recordName1)
            record = CKRecord(recordType: "UserInfo", recordID: myRecordId)
            record.setObject(newVal as CKRecordValue?, forKey: "Email")
            publicDataBase.save(record) { (savedRecord, error) -> Void in
                if (error != nil){
                    print("user has already registered!")
                }
                else{
                    print("\n\n\n\nSweet...it worked :)")
                }
                
            }
        }
    }*/
    
    

    
}
