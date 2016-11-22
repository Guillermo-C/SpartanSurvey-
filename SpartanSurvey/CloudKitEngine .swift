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
    
    
    fileprivate func saveRecord(saveR:String, rDestination: String){
        let store = CKRecord(recordType: rDestination)
        store.setObject(saveR as CKRecordValue?, forKey: rDestination)
        
        publicDataBase.save(store){ (savedRecord, error) -> Void in
            if (error != nil){
                print("Data not successfully saved")
            }
            else{
                print("Nice! it worked.")
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
