//
//  GiftCardViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 12/3/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class GiftCardViewController: UIViewController {
    
    
    //  Alert for not sufficient points. Shown when "not enough points"
    let notEnoughAlert = UIAlertController(title: "Need more points", message: "You can't afford this gift card, go take more surveys!", preferredStyle: UIAlertControllerStyle.alert)

    override func viewDidLoad() {
        super.viewDidLoad()

        //  Add action "Ok" for the wrongCredentialsAlert
        notEnoughAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mcDonaldsImg: UIImageView!
    

    @IBAction func buy(_ sender: UIButton) {
       // mcDonaldsImg.alpha = 0.2
        present(notEnoughAlert, animated: true, completion: nil)
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
