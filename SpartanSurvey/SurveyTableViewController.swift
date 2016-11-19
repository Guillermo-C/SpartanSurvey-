//
//  SurveyTableViewController.swift
//  SpartanSurvey
//
//  Created by Guillermo Colin on 11/12/16.
//  Copyright © 2016 SJSU. All rights reserved.
//

import UIKit

class SurveyTableViewController: UITableViewController {

    
    //  Create a struct that holds the name of the section, its sublist and its corresponding view controllers
    struct TableViewObjects {
        var sectionName:String
        //  First string value holds the name of the sublist
        //  Second string value holds the name of the corresponding view controller
        var sectionObjects = [String: String]()
    }
    

    //  Dismiss the available surveys table view when done
    @IBAction func goBackToUserProfile(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //  Declare an array of type TableViewObjects for holding data of its type, for populating the table view
    var TableViewArray = [TableViewObjects]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Declare values for TableViewArray
        TableViewArray = [TableViewObjects(sectionName: "Restaurants", sectionObjects: ["Subway":"subwayScreen",
                                                                                        "McDonald's":"mcDonaldsScreen"]),
                          TableViewObjects(sectionName:"Sports", sectionObjects:["Soccer":"soccerScreen"]),
                          TableViewObjects(sectionName:"Health", sectionObjects:["Kaiser":"kaiserScreen"])]
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //  Return the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return TableViewArray.count

    }

    //  Return the number of sublists
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewArray[section].sectionObjects.count
    }

    //  Print proper sublist for each section
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //  Instantiate a cell, named 'Cell', to be reused again and again for all elements within the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        //  Get keys for printing the sublist inside of 'section objects' and print it in ascending order
        let getKeys = [String](TableViewArray[indexPath.section].sectionObjects.keys.sorted(by: <))
        
        cell?.textLabel?.text = getKeys[indexPath.row]
        

        return cell!
    }
    
    //  Return the name of the sections in the table view
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
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }*/
    
    //  Return appropriate view for selected cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //  Get the right view(as value by using a key) for the corresponding cell
        let getValues = [String](TableViewArray[indexPath.section].sectionObjects.values)
        //  Get name of the view
        let vcName = getValues[indexPath.row]
        //  Instantiate the view
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        //  Push the view controller for viewing
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    

    
}
