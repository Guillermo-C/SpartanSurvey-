//
//  SignInViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 10/25/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit


@objc protocol SignInViewControllerDelegate{
    @objc optional func signInBackButtonPressed()
}

class SignInViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var delegate: SignInViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignInBackButtunPressed(_ sender: UIBarButtonItem) {
        
        delegate?.signInBackButtonPressed!()
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signInInfoSegue"{
            
            let viewC = segue.destination
            let controller = viewC.popoverPresentationController
            
            if (controller != nil) {
                controller?.delegate = self
            }
            
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    

}
