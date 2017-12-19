//
//  ViewController.swift
//  yutingtest03
//
//  Created by Admin on 12/19/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import AppCenterCrashes

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func button(_ sender: Any) {
       // label.text = "yuting is so cool"
       MSCrashes.generateTestCrash()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

