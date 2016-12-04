//
//  GiftCardViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 12/3/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class GiftCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mcDonaldsImg: UIImageView!
    

    @IBAction func buy(_ sender: UIButton) {
        mcDonaldsImg.alpha = 0.2
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
