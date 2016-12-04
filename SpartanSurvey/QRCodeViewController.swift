//
//  QRCodeViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 10/25/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

@objc protocol QRCodeViewControllerDelegate{
    @objc optional func QRBackButtonPressed()
}

class QRCodeViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var delegate: QRCodeViewControllerDelegate?
    
    //  qrCode needed to be taken to the appropriate survey. 
    var qrCode:String = "1A3BZ99"
    
    @IBOutlet weak var qRCodeEntry: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func QRBackButtonPressed(_ sender: UIBarButtonItem) {
        
        delegate?.QRBackButtonPressed!()
    }
    @IBAction func showInfo(_ sender: UIButton) {
        self.performSegue(withIdentifier: "qRInfoSegue", sender: self)
    }
    
    
    //  For testing only
    
    var cloud = CloudKitEngine()
    @IBAction func submit(_ sender: UIButton) {
        //var number:Int = cloud.getPoints(email: qRCodeEntry.text!)
        //print("Total number of points: \(number)")
        let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "yogurtLScreen") as UIViewController
        
        self.present(viewC, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "qRInfoSegue"{
            
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
