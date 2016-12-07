//
//  ViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 10/25/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit



//  GitHub commit/push test
//  Verify submission is succesful

class ViewController: UIViewController, BWWalkthroughViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showWalkThrough() {
        print("walkthrough button pressed")
        
        //  Instantiate main storyboard for providing viewing priviledge to the walkthrough 
        let stb = UIStoryboard(name: "Main", bundle: nil)
        
        //  Build the walkthrough
        let walkthrough = stb.instantiateViewController(withIdentifier: "walk0") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewController(withIdentifier: "walk1") as UIViewController
        let page_two = stb.instantiateViewController(withIdentifier: "walk2") as UIViewController
        let page_three = stb.instantiateViewController(withIdentifier: "walk3") as UIViewController
        let page_four = stb.instantiateViewController(withIdentifier: "walk4") as UIViewController
        let page_five = stb.instantiateViewController(withIdentifier: "walk5") as UIViewController
        
        //  Attach pages to master
        walkthrough.delegate = self
        walkthrough.addViewController(page_one)
        walkthrough.addViewController(page_two)
        walkthrough.addViewController(page_three)
        walkthrough.addViewController(page_four)
        walkthrough.addViewController(page_five)
        
        self.present(walkthrough, animated: true, completion: nil)
    }
    
    func walkthroughCloseButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }

}

