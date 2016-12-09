//
//  GiftCardViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 12/3/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class GiftCardViewController: UIViewController {
    
    
    //  Points the McDonald's gift card is worth. 
    let mcDWorth:Int = 100
    
    //  Points the Subway gift card is worth.
    let subWorth:Int = 80
    
    //  Points the YogurtLand gift card is worth.
    let yogWorth:Int = 60
    
    //  Alert for not sufficient points. Shown when "not enough points"
    let notEnoughAlert = UIAlertController(title: "Need more points!", message: "You can't afford this gift card, go take more surveys!", preferredStyle: UIAlertControllerStyle.alert)

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
    
    @IBOutlet weak var subwayImg: UIImageView!
    
    @IBOutlet weak var yogurtLandImg: UIImageView!
    
    

    /*@IBAction func buy(_ sender: UIButton) {
       // mcDonaldsImg.alpha = 0.2
        present(notEnoughAlert, animated: true, completion: nil)
    }*/
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        let viewC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcomeScreen") as UIViewController
        
        self.present(viewC, animated: true, completion: nil)
    }
    
    @IBAction func buyMcDonalds(_ sender: UIButton) {
        let canDo:Bool = canAffordGiftCard(usrPts: Int (userPoints)!, worth: mcDWorth)
        _ = buyCard(eligible: canDo, img: mcDonaldsImg, alert: notEnoughAlert, targetVC: self)
        
    }
    
    @IBAction func buySubway(_ sender: UIButton) {
        let canDo:Bool = canAffordGiftCard(usrPts: Int (userPoints)!, worth: subWorth)
        _ = buyCard(eligible: canDo, img: subwayImg, alert: notEnoughAlert, targetVC: self)
    }
    
    @IBAction func buyYogurtL(_ sender: UIButton) {
        let canDo:Bool = canAffordGiftCard(usrPts: Int (userPoints)!, worth: yogWorth)
        _ = buyCard(eligible: canDo, img: yogurtLandImg, alert: notEnoughAlert, targetVC: self)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //  func to check if user can afford the gift card
    func canAffordGiftCard(usrPts: Int, worth: Int) -> Bool{
        var can:Bool = false
        
        if (usrPts >= worth){
            can = true
        }
        
        return can
    }
    
    //  func to check if user can buy gift card. If possible then, grey out the card a little. 
    func buyCard(eligible: Bool, img: UIImageView, alert: UIAlertController, targetVC: UIViewController){
        switch eligible {
        case true:
            img.alpha = 0.5
        default:
            targetVC.present(alert, animated: true, completion: nil)
            print("User couldn't afford it.")
        }
    }
    

}
