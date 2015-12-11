//
//  ViewController.swift
//  easyTip
//
//  Created by Difan Chen on 12/11/15.
//  Copyright © 2015 Difan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    var tipPercentages = [0.18, 0.2, 0.22]    // Default tips percentages
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func amountChanged(sender: AnyObject) {
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmounts = NSString(string: billAmount.text!).doubleValue
        let tip = billAmounts * tipPercentage
        let totalAmounts = billAmounts + tip
        
        tipAmount.text = String(format: "$%.2f", tip)
        totalAmount.text = String(format: "$%.2f", totalAmounts)
    }

}

