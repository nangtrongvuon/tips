//
//  ViewController.swift
//  tips
//
//  Created by Dzũng Lê on 2/20/16.
//  Copyright © 2016 Dzũng Lê. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults()
        let currentDefault = defaults.integerForKey("defaultTip")
        tipControl.selectedSegmentIndex = currentDefault
        tipControl.sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    override func viewDidAppear(animated: Bool) {
        if billField.text!.isEmpty {
            billField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        billField.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onEditingStart(sender: AnyObject) {
        self.resultView.alpha = 0
        billField.text?.removeAll()
    }
    

    @IBAction func onEditing(sender: AnyObject) {
        
        if billField.text!.isEmpty {
            UIView.animateWithDuration(0.2) {
                self.resultView.alpha = 0
            }
        } else {
            
        self.resultView.alpha = 1
    
        let billAmount: Double
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        
        var tipPercentage = [ 0.05, 0.1, 0.15 ]
        let selectedTipPercentage = tipPercentage[tipControl.selectedSegmentIndex]
        
        if let billFormattedAmount = formatter.numberFromString(billField.text!)?.doubleValue {
            billAmount = billFormattedAmount
        }
        else {
            billAmount = NSString(string: billField.text!).doubleValue
        }
        
        let tip = billAmount * selectedTipPercentage
        let total = billAmount + tip
        
        let billNumber = formatter.stringFromNumber(billAmount) ?? ""
        let tipNumber = formatter.stringFromNumber(tip) ?? ""
        let totalNumber = formatter.stringFromNumber(total) ?? ""
        
        billField.text = "\(billNumber)"
        tipLabel.text = "\(tipNumber)"
        totalLabel.text = "\(totalNumber)"
        
        }
        
    }

    @IBAction func onTap(sender: AnyObject) {
        if billField.text!.isEmpty == false {
        view.endEditing(true)
        }
    }
}

