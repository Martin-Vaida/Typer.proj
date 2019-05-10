//
//  TableViewController.swift
//  test
//
//  Created by Vaida on 2019/5/9.
//  Copyright © 2019 Vaida. All rights reserved.
//

import Foundation
import UIKit

class MarryHadALittleLambController:UITableViewController {
    var timer:Timer?
    var timeCounter = 0.0
    var strß = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    @IBOutlet weak var labelSix: UILabel!
    @IBOutlet weak var labelSeven: UILabel!
    @IBOutlet weak var labelEight: UILabel!
    @IBOutlet weak var labelNine: UILabel!
    @IBOutlet weak var labelTen: UILabel!
    @IBOutlet weak var labelEleven: UILabel!
    @IBOutlet weak var labelTwelve: UILabel!
    @IBOutlet weak var labelThirteen: UILabel!
    @IBOutlet weak var labelFourteen: UILabel!
    @IBOutlet weak var labelFifteen: UILabel!
    
    @IBOutlet weak var lineOne: UITextField!
    @IBOutlet weak var lineTow: UITextField!
    @IBOutlet weak var lineThree: UITextField!
    @IBOutlet weak var lineFour: UITextField!
    @IBOutlet weak var lineFive: UITextField!
    @IBOutlet weak var lineSix: UITextField!
    @IBOutlet weak var lineSeven: UITextField!
    @IBOutlet weak var lineEight: UITextField!
    @IBOutlet weak var lineNine: UITextField!
    @IBOutlet weak var lineTen: UITextField!
    @IBOutlet weak var lineEleven: UITextField!
    @IBOutlet weak var lineTwelve: UITextField!
    @IBOutlet weak var lineThirteen: UITextField!
    @IBOutlet weak var lineFourteen: UITextField!
    @IBOutlet weak var lineFifteen: UITextField!
    
    
    //define texts
    func setup() {
        labelOne.text = "Mary had a little lamb, little lamb, little lamb,"
        labelTwo.text = "Mary had a little lamb, its fleece was white as snow."
        labelThree.text = "And everywhere that Mary went, Mary went, Mary went,"
        labelFour.text = "And everywhere that Mary went, the lamb was sure to go."
        labelFive.text = "It followed her to school one day school one day, school one day,"
        labelSix.text = "It followed her to school one day, which was against the rules."
        labelSeven.text = "It made the children laugh and play, laugh and play, laugh and play,"
        labelEight.text = "It made the children laugh and play to see a lamb at school."
        labelNine.text = "And so the teacher turned it out, turned it out, turned it out,"
        labelTen.text = "And so the teacher turned it out, but still it lingered near, And waited patiently about"
        labelEleven.text = "And waited patiently about till Mary did appear."
        labelTwelve.text = "Why does the lamb love Mary so? Love Mary so? Love Mary so?"
        labelThirteen.text = "Why does the lamb love Mary so, the eager children cry."
        labelFourteen.text = "Why, Mary loves the lamb, you know. The lamb, you know, the lamb, you know"
        labelFifteen.text = "Why, Mary loves the lamb, you know, the teacher did reply."
        
        lineOne.text = " "
    }
    
    
    //Timer
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.timeCounter += 0.1
            guard self.timer != nil else { return }
            
            let str = String(self.timeCounter)
            var array:[String] = []
            self.strß = ""
            
            for i in str {
                array.append(String(i))
            }
            
            for i in 0...array.count-1 {
                self.strß += array[i]
                
                if array[i] == "." {
                    self.strß += array[i+1]
                    break
                }
            }
            
            self.navigationItem.title = String(self.strß)
        })
    }
    
    func stopTimer() {
        if timer != nil {
            timer!.invalidate() //销毁timer
            timer = nil
        }
    }
    
    //new
    
    
    
    @IBAction func lineOneBegin(_ sender: Any) {
        startTimer()
    }
    
    @IBAction func lineOneChanged(_ sender: Any) {
        if lineOne.text?.count == labelOne.text!.count+1 {
            lineOne.resignFirstResponder()
            lineTow.text = " "
            lineTow.becomeFirstResponder()
        }
    }
    
    @IBAction func lineTwoChaged(_ sender: Any) {
        if lineTow.text?.count == labelTwo.text!.count+1 {
            lineTow.resignFirstResponder()
            lineThree.text = " "
            lineThree.becomeFirstResponder()
        }
        
        if lineTow.text?.count == 0 {
            lineTow.resignFirstResponder()
            lineOne.becomeFirstResponder()
        }
    }
    
    @IBAction func lineThreeChanged(_ sender: Any) {
        if lineThree.text?.count == labelThree.text!.count+1 {
            lineThree.resignFirstResponder()
            lineFour.text = " "
            lineFour.becomeFirstResponder()
        }
        
        if lineThree.text?.count == 0 {
            lineThree.resignFirstResponder()
            lineTow.becomeFirstResponder()
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        stopTimer()
    }
    
    
}
