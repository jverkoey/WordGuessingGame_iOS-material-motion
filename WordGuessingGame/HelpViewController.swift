//
//  HelpViewController.swift
//  WordGuessingGame
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
