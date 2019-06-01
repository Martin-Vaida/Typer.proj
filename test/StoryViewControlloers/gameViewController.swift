//
//  gameViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/23.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class gameViewController:UIViewController {
    var viewArray:[UIView] = []
    var time = 4
    var timer:Timer?
    static var textArray:[String] = []
    static var showTextArray:[UITextField] = []
    var tempText = ""
    var currentLine = 0
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var centerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        centerLabel.text = ""
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            self.time -= 1
            self.centerLabel.text = String(self.time)
            if self.time == 0 {
                self.textField.becomeFirstResponder()
                self.stopTimer()
                self.centerLabel.text = ""
                
                self.viewArray.append(UIView.makeView(x: Support.width, y: 0, labelText: "HaHaHa"))
                self.view.addSubview(self.viewArray[0])
                
                UIView.animate(withDuration: 10) {
                    self.viewArray[0].frame = CGRect(x: 0, y:Int(self.viewArray[0].frame.origin.y), width: Support.width, height: 88)
                }
                UIView.animate(withDuration: 10, delay: 9.8, options: [], animations: {
                    self.viewArray[0].frame = CGRect(x: -Support.width, y:Int(self.viewArray[0].frame.origin.y), width: Support.width, height: 88)
                }, completion: nil)
            }
        }
        
    }
    
    func stopTimer() {
        timer!.invalidate()
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        tempText = textField.text!
        textField.text = ""
        gameViewController.showTextArray[currentLine].text! += tempText
    }
    
}

//All rights reserved.
