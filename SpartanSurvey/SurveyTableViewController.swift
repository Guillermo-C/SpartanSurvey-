//
//  SurveyTableViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/12/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class SurveyTableViewController: UITableViewController {

    
    
    struct TableViewObjects {
        var sectionName:String
        //var sectionObjects:[String]!  //  uncomment when done testing
        //var identities:[String]!
        var sectionObjects = [String: String]()

        
    }
    

    
    @IBAction func goBackToUserProfile(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    

    //var identitites = [String]()
    
    var TableViewArray = [TableViewObjects]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //  code below for showing table with headers works
        //  deleted just for testing purposes
        /*TableViewArray = [TableViewObjects(sectionName: "Restaurants", sectionObjects: ["McDonald's", "Subway","something"]), TableViewObjects(sectionName: "Health", sectionObjects: ["Kaiser Permanente"])]*/
        TableViewArray = [TableViewObjects(sectionName: "Restaurants", sectionObjects: ["Subway":"subwayScreen",
                                                                                        "McDonald's":"mcDonaldsScreen"]),
                          TableViewObjects(sectionName:"Sports", sectionObjects:["Soccer":"soccerScreen"]),
                          TableViewObjects(sectionName:"Health", sectionObjects:["Kaiser":"kaiserScreen"])]
        
        
        
        //  identitites work, uncomment out when done testing
        //identitites = ["redScreen", "greenScreen", "kaiserScreen"]
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return TableViewArray.count

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewArray[section].sectionObjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        
        let getKeys = [String](TableViewArray[indexPath.section].sectionObjects.keys.sorted(by: <))
        
       
        cell?.textLabel?.text = getKeys[indexPath.row]
        
        //  code below works, uncomment when done testing
        //cell?.textLabel?.text = TableViewArray[indexPath.section].sectionObjects[indexPath.row]
        return cell!
    }
    
    //  works, uncomment when done testing
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TableViewArray[section].sectionName
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
     
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*if (segue.identifier == "McDShowView") {
            //let cell = sender as! UITableViewCell
            //let indexPath = tableView.indexPath(for: cell)
            let indexPath = self.tableView.indexPathForSelectedRow
            let surveyController: McDonaldsViewController = segue.destination as! McDonaldsViewController
            
        
            
            surveyController.titleString = "McDShowView"
            self.tableView.deselectRow(at: indexPath!, animated: true)
            

        }*/
        

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //  works, uncomment when done testing
        //let vcName = identitites[indexPath.row]
        
        //  get the right view for the corresponding cell
        let getValues = [String](TableViewArray[indexPath.section].sectionObjects.values)
        let vcName = getValues[indexPath.row]


        //  works, uncomment when done testing
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    

    
}
