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
    
    
    func saveRecord(saveR:String, rDestination: String){
        let store = CKRecord(recordType: rDestination)
        store.setObject(saveR as CKRecordValue?, forKey: rDestination)
    }
    
    
}
