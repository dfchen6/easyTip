//
//  ViewController.swift
//  easyTip
//
//  Created by Difan Chen on 12/11/15.
//  Copyright © 2015 Difan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DestinationviewDelegate {

    @IBOutlet weak var peopleTag: UILabel!
    @IBOutlet weak var tipTag: UILabel!
    @IBOutlet weak var totalTag: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var reduceButton: UIButton!
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var numberField: UILabel!
    var tipPercentages = [0.18, 0.2, 0.22]    // Default tips percentages
    var numberOfPeople = 1 // Default number of people
    var amount = 0.00      // Deafault number of money
    var nightMode = false  // Default mode is day mode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmount.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func updateNumView(num: Int){
        self.numberOfPeople = num
        numberField.text = "\(num)"
    }
    
    @IBAction func increasePeople(sender: AnyObject) {
        let tmpNum = self.numberOfPeople
        if( tmpNum < 10){
            updateNumView(tmpNum + 1)
        }
        amountChanged(self)
    }
    
    @IBAction func decreasePeople(sender: AnyObject) {
        let tmpNum = self.numberOfPeople
        if( tmpNum > 1){
            updateNumView(tmpNum - 1)
        }
        amountChanged(self)
    }
    
    @IBAction func amountChanged(sender: AnyObject) {
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmounts = NSString(string: billAmount.text!).doubleValue
        let tip = billAmounts * tipPercentage
        let totalAmounts = (billAmounts + tip)/Double(self.numberOfPeople)
        
        tipAmount.text = formatAmount(tip)
        //String(format: "$%.2f", tip)
        print(formatAmount(tip))
        totalAmount.text = formatAmount(totalAmounts)
    }
    
    // Called from the destination controller via delegate
    func setTipPerct(tipPerct1: Int, tipPerct2: Int, tipPerct3: Int, isOn: Bool){
        tipPercentages[0] = Double(Double(tipPerct1)/100);
        tipPercentages[1] = Double(Double(tipPerct2)/100);
        tipPercentages[2] = Double(Double(tipPerct3)/100);
        tipControl.setTitle("\(tipPerct1)%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(tipPerct2)%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(tipPerct3)%", forSegmentAtIndex: 2)
        nightMode = isOn
        amountChanged(self)
    }
    
    // Format the tip value and total value in local currency
    func formatAmount (amount: Double) -> String{
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale() // This is the default
        return formatter.stringFromNumber(amount)!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toSettings"){
            let destination = segue.destinationViewController as! SettingsViewController
            destination.delegate = self
            // Set default value for settings
            
            destination.p1 = Int(tipPercentages[0]*100)
            destination.p2 = Int(tipPercentages[1]*100)
            destination.p3 = Int(tipPercentages[2]*100)
            destination.mode = nightMode
        }
    }
    
    func switchMode(){
        if(nightMode){
            self.view.backgroundColor = UIColor(red:0.33, green:0.35, blue:0.57, alpha:0.5)
            peopleTag.textColor = UIColor(white: 1, alpha: 1)
            tipTag.textColor = UIColor(white: 1, alpha: 1)
            totalTag.textColor = UIColor(white: 1, alpha: 1)
            tipAmount.textColor = UIColor(white: 1, alpha: 1)
            totalAmount.textColor = UIColor(white: 1, alpha: 1)
            billAmount.textColor = UIColor(white: 1, alpha: 1)
            billAmount.backgroundColor = UIColor(red:0.33, green:0.35, blue:0.57, alpha:0.5)
            numberField.textColor = UIColor(white: 1, alpha: 1)
            print("Night Mode is on! Let's work")
        }
        else{
            peopleTag.textColor = UIColor.blackColor()
            tipTag.textColor = UIColor.blackColor()
            totalTag.textColor = UIColor.blackColor()
            tipAmount.textColor = UIColor.blackColor()
            totalAmount.textColor = UIColor.blackColor()
            billAmount.textColor = UIColor.blackColor()
            billAmount.backgroundColor = UIColor.whiteColor()
            numberField.textColor = UIColor.blackColor()
            print("Day Mode is on!")
            self.view.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func saveSettings(){
        let previousDate = NSDate.timeIntervalSinceReferenceDate()
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(NSString(string: billAmount.text!).doubleValue), forKey: "previousAmount")
        defaults.setDouble(previousDate, forKey: "previousTime")
        defaults.synchronize()
    }
    
    func restoreSettings(){
        let defaults = NSUserDefaults.standardUserDefaults()
        let prevAmount = defaults.integerForKey("previousAmount")
                // Check re-enter time
        let now = NSDate.timeIntervalSinceReferenceDate()
        let prevTime = defaults.doubleForKey("previousTime")
        print(now - prevTime)
        if (prevAmount > 0 && (now - prevTime) < (10 * 60)){
              billAmount.text = "\(prevAmount)"
        }
        else{
            billAmount.text = ""
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        restoreSettings()
        switchMode()
        }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
        saveSettings()
        }


}

