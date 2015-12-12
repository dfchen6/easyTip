//
//  ViewController.swift
//  easyTip
//
//  Created by Difan Chen on 12/11/15.
//  Copyright © 2015 Difan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DestinationviewDelegate {

    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var numberField: UITextField!
    var tipPercentages = [0.18, 0.2, 0.22]    // Default tips percentages
    var numberOfPeople = 1 // Default number of people
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmount.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func increasePeople(sender: AnyObject) {
        var tmpNum = self.numberOfPeople
        if( tmpNum < 10){
            tmpNum = tmpNum + 1
            self.numberOfPeople  = tmpNum
            numberField.text = "\(tmpNum)"
        }
        amountChanged(self)
    }
    @IBAction func decreasePeople(sender: AnyObject) {
        var tmpNum = self.numberOfPeople
        if( tmpNum > 1){
            tmpNum = tmpNum - 1
            self.numberOfPeople  = tmpNum
            numberField.text = "\(tmpNum)"
        }
        amountChanged(self)
    }
    
    @IBAction func amountChanged(sender: AnyObject) {
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmounts = NSString(string: billAmount.text!).doubleValue
        let tip = billAmounts * tipPercentage
        let totalAmounts = (billAmounts + tip)/Double(self.numberOfPeople)
        
        tipAmount.text = String(format: "$%.2f", tip)
        totalAmount.text = String(format: "$%.2f", totalAmounts)
    }
    
    // Called from the destination controller via delegate
    func setTipPerct(tipPerct1: Int, tipPerct2: Int, tipPerct3: Int){
        tipPercentages[0] = Double(Double(tipPerct1)/100);
        tipPercentages[1] = Double(Double(tipPerct2)/100);
        tipPercentages[2] = Double(Double(tipPerct3)/100);
        tipControl.setTitle("\(tipPerct1)%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(tipPerct2)%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(tipPerct3)%", forSegmentAtIndex: 2)
        amountChanged(self)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toSettings"){
            let destination = segue.destinationViewController as! SettingsViewController
            destination.delegate = self
            // Set default value for settings
            
            destination.p1 = Int(tipPercentages[0]*100)
            destination.p2 = Int(tipPercentages[1]*100)
            destination.p3 = Int(tipPercentages[2]*100)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        let defaults = NSUserDefaults.standardUserDefaults()
        let prevAmount = defaults.integerForKey("previousAmount")
        
        let now = NSDate.timeIntervalSinceReferenceDate()
        let prevTime = defaults.doubleForKey("previousTime")
        print(now - prevTime)
        if (prevAmount > 0 && (now - prevTime) < 10*60){
        billAmount.text = "\(prevAmount)"
        }
        else{
            billAmount.text = ""
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
        let previousDate = NSDate.timeIntervalSinceReferenceDate()
        //return (now - previousBillDate) < (10 * 60) // Ten minutes
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(NSString(string: billAmount.text!).doubleValue), forKey: "previousAmount")
        defaults.setDouble(previousDate, forKey: "previousTime")
        defaults.synchronize()
    }


}

