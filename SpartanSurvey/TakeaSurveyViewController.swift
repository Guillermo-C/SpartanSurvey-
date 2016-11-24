//
//  TakeaSurveyViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/23/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class TakeaSurveyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcomeScreen") as UIViewController
        
        self.present(viewC, animated: true, completion: nil)
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
