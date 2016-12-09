//
//  QRCodeViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 10/25/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

//  Create an obj protcol for using the back button within the walkthrough.
@objc protocol QRCodeViewControllerDelegate{
    @objc optional func QRBackButtonPressed()
}

//  This class is for the QR Code. The QR Code is simulated with a string, which is: '1A3BZ99'.
class QRCodeViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    //  Delegate var for the QR Code class which is used in the walkthrough.
    var delegate: QRCodeViewControllerDelegate?
    
    //  qrCode needed to be taken to the appropriate survey. 
    var qrCode:String = "1A3BZ99"
    
    //  UITextField which takes the qrCode String value.
    @IBOutlet weak var qRCodeEntry: UITextField!
    
    //  Back button for the bar menu in this QRCodeViewController.
    @IBAction func QRBackButtonPressed(_ sender: UIBarButtonItem) {
        
        delegate?.QRBackButtonPressed!()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wrongQRAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  Information button which displays a PopOver for additional information when the user requests it.
    @IBAction func showInfo(_ sender: UIButton) {
        self.performSegue(withIdentifier: "qRInfoSegue", sender: self)
    }
    
    //  Alert user in case of an incorrect QR code.
    let wrongQRAlert = UIAlertController(title: "Wrong QR Code", message: "Please verify your QR code.", preferredStyle: UIAlertControllerStyle.alert)

    


    //  func to validate the QR Code submitted by the user. And if it's valid then show the Yogurtland survey.
    @IBAction func submit(_ sender: UIButton) {
        
        let userQREntry = qRCodeEntry.text!
        validateQRCode(userEntry: userQREntry, qrCode: qrCode, targetVC: self, alert: wrongQRAlert)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation.
    //  func prepare() is used for the segue 'qRInfoSegue'
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

    //  func required for the PopOver.
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //  Validate the QR Code that the user enters.
    func validateQRCode(userEntry:String, qrCode: String, targetVC: UIViewController, alert: UIAlertController){
        if (userEntry == qrCode){
            let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "yogurtLScreen") as UIViewController
            
            self.present(viewC, animated: true, completion: nil)
        }
        else{
            targetVC.present(alert, animated: true, completion: nil)
        }
    }    
    

}
