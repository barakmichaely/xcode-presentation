//
//  ViewController.swift
//  GroceryListApp
//
//  Created by Barak M on 10/28/14.
//  Copyright (c) 2014 Barak Michaely. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button: UIButton!
    
    @IBOutlet var bgview: UIView!
    @IBAction func changecolor(sender: AnyObject) {
        bgview.backgroundColor = UIColor(red: randomColor(), green: randomColor(), blue: randomColor(), alpha: 1)
    }
    
    func randomColor () -> CGFloat {
        return (CGFloat(rand()%255)/255)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

