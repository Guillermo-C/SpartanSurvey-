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
    
    
    func saveRecordAt(saveR:String, recordT: String){
        let store = CKRecord(recordType: recordT)
        store.setObject(saveR as CKRecordValue?, forKey: recordT)
    }
    
    
}
