//
//  TableControllerTableViewController.swift
//  GroceryListApp
//
//  Created by Barak M on 10/28/14.
//  Copyright (c) 2014 Barak Michaely. All rights reserved.
//

import UIKit

class TableController: UITableViewController {
    
    var data:NSMutableArray = ["Bananas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loaddata()
        
        // Create an Button with the style 'Add' , and attach it an action refering to addItem() function
        var addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addItem")
        
        // Set the Right Bar Item to the add button created above
        self.navigationItem.rightBarButtonItem = addButton
        
        // Set hte Left Bar Item to built in 'edit' button (it has added functionalities)
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    func savedata () {
        // Convert the 'data' from type array to type NSData, necessary for writing files
        var datafiedData:NSData = NSJSONSerialization.dataWithJSONObject(self.data, options: NSJSONWritingOptions.PrettyPrinted, error: nil)!
        
        // Write the converted data to a file at the location 'home_directory/data.wtf'
        datafiedData.writeToFile(NSHomeDirectory().stringByAppendingPathComponent("data.wtf"), atomically: true)
    }
    
    func loaddata () {
        // Create an NSData variable from the file at the path specified
        var rawdata:NSData? = NSData(contentsOfFile: NSHomeDirectory().stringByAppendingPathComponent("data.wtf"))
        
        // Check if it exists
        if (rawdata == nil) {
            println("NO FILE FOUND")
            
            // If not don't continue to load it
            return
        }
        
        // Decode the data back to an NSArray
        var dedatafiedData = NSJSONSerialization.JSONObjectWithData(rawdata!, options: NSJSONReadingOptions.MutableLeaves, error: nil)
        
        // Set the temporary data variable to what was just loaded from the file
        // Change the data loaded back to Mutable, as it is immutable when loaded from a file
        self.data = (dedatafiedData as NSArray).mutableCopy() as NSMutableArray
        

    }
    
    func addItem () {
        // Make Pop Up View
        var popup = self.storyboard?.instantiateViewControllerWithIdentifier("addView") as AddItemViewViewController
        // Set its 'parent' variable to this class instance (self)
        popup.parent = self
        
        self.navigationController?.pushViewController(popup, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Register the Custom Nib with the table
        tableView.registerNib(UINib(nibName: "BasicCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Create a cell with the identifier registered above
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        // Set the cell's text to correspond to the data array
        cell.textLabel?.text = data[indexPath.row] as NSString

        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            data.removeObjectAtIndex(indexPath.row)
            self.savedata()
            // Delete row from Table View
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }



    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

        // Switch the positions of the items in the array
        var tempItem = data[fromIndexPath.row]
        data[fromIndexPath.row] = data[toIndexPath.row]
        data[toIndexPath.row] = tempItem
        
        // Save
        self.savedata()
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
