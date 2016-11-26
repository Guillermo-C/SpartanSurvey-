//
//  UPAnswersViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/26/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit
import CloudKit

class UPAnswersViewController: UIViewController {

    @IBOutlet weak var answersBlock: UITextView!
    
    //  Invoke the class CloudKitEngine for saving data in the cloud
    let cloudKitEng = CloudKitEngine()
    
    var retrieveAns = [CKRecord]()
    
    var answerArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //retrieveAns = cloudKitEng.getAllAnswers(email: emailOfUser)
        //answerArray = cloudKitEng.printAnswers(recordArray: retrieveAns)
        //answersBlock.text = cloudKitEng.printAnswers(recordArray: retrieveAns)
        answersBlock.isEditable = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        //answerArray = cloudKitEng.printAnswers(recordArray: retrieveAns)
        retrieveAns = cloudKitEng.getAllAnswers(email: emailOfUser)
        dump(answerArray)
        //answersBlock.text =  String(describing: cloudKitEng.getAllAnswers(email: emailOfUser))
    }
    

    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
