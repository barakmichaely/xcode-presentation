//
//  AddItemViewViewController.swift
//  GroceryListApp
//
//  Created by Barak M on 10/28/14.
//  Copyright (c) 2014 Barak Michaely. All rights reserved.
//

import UIKit

class AddItemViewViewController: UIViewController {

    var parent:TableController?
    @IBOutlet var textbox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make Done Button
        var doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "done")
        // Add it as Right Navigation Item
        self.navigationItem.rightBarButtonItem = doneButton
        
        //Make Cancel Button
        var cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        // Add it as Left Navigation Item
        self.navigationItem.leftBarButtonItem = cancelButton
        
        // Remove navigation title by setting it to ""
        self.navigationItem.title = ""
    }
    
    func cancel () {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func done () {
        if (textbox.text != ""){
            parent!.data.addObject(textbox.text)
            parent!.savedata()
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
