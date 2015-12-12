//
//  SettingsViewController.swift
//  easyTip
//
//  Created by Difan Chen on 12/11/15.
//  Copyright © 2015 Difan Chen. All rights reserved.
//

import UIKit

protocol DestinationviewDelegate{
    func setTipPerct(tipPerct1: Int, tipPerct2: Int, tipPerct3: Int);
}

class SettingsViewController: UIViewController {
    var delegate : DestinationviewDelegate?
    @IBOutlet weak var smallTipField: UITextField!
    @IBOutlet weak var midTipField: UITextField!
    @IBOutlet weak var largeTipField: UITextField!
    var p1: Int! = nil
    var p2: Int! = nil
    var p3: Int! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smallTipField.text = "\(p1)"
        midTipField.text = "\(p2)"
        largeTipField.text = "\(p3)"
        smallTipField.placeholder = "\(p1)"
        midTipField.placeholder = "\(p2)"
        largeTipField.placeholder = "\(p3)"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        let tipPerc1 = Int(NSString(string: smallTipField.text!).doubleValue)
        let tipPerc2 = Int(NSString(string: midTipField.text!).doubleValue)
        let tipPerc3 = Int(NSString(string: largeTipField.text!).doubleValue)
        print("keep working")
        if((delegate) != nil){
            print("delegate works")
            self.delegate?.setTipPerct(tipPerc1, tipPerct2: tipPerc2, tipPerct3: tipPerc3)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
