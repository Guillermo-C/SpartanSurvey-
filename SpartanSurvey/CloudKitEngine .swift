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
    
    
    //  Create a method for saving data with a given record name
    func saveNewDataWRecord(record_Name: String, recordTypeName: String, forKey: String, recordsToSave: [String], keyList: [String]){
        let recordId = CKRecordID(recordName: record_Name)
        let store = CKRecord(recordType: recordTypeName, recordID: recordId)
        
        //  Save each attribute in its corresponding key
        for i in 0...keyList.count - 1{
            store.setObject(recordsToSave[i] as CKRecordValue?, forKey: keyList[i])
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
    

    
    //  Detect if user was previously and still is logged into iCloud on his phone
    
    func isiCloudAvailable() -> Bool {
        if FileManager.default.ubiquityIdentityToken != nil{
            
            return true
        }
        else{
            return false
        }
    }
    
    
}
