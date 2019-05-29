//
//  LightViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/28.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class LightViewController:UITableViewController {
    @IBOutlet var introductionLabel: [UILabel]!     //seven objects
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var lineArray: [UITextField]!
    
    var currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    var currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    var unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var correct = false
    var botton = UIButton(frame: CGRect(x: 23, y: 70, width: 100, height: 44))
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        for i in introductionLabel {
            i.text = "//  "
        }
        introductionLabel[1].text! += "ViewController.swift"
        introductionLabel[2].text! += "Light"
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "zh_CN")
        let takenDate = String(dateFormatter.string(from: Date()))
        introductionLabel[4].text! += "Created by \(MenuViewController.userName) on \(takenDate)."
        
        currentLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[0].red)!), green: CGFloat(Double(colorMixViewController.colorArray[0].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[0].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[0].alpha)!))
        currentLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[1].red)!), green: CGFloat(Double(colorMixViewController.colorArray[1].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[1].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[1].alpha)!))
        unusedLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[2].red)!), green: CGFloat(Double(colorMixViewController.colorArray[2].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[2].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[2].alpha)!))
        unusedLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[3].red)!), green: CGFloat(Double(colorMixViewController.colorArray[3].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[3].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[3].alpha)!))
        
        for i in lineArray {
            i.textColor = unusedLineColor
        }
        for i in labelArray {
            i.textColor = unusedLabelColor
        }
    }
    
    func check() {
        for i in 0...labelArray.count-1 {
            if labelArray[i].text! == lineArray[i].text! {
            } else {
                lineArray[i].backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.1)
                correct = false
            }
        }
    }
    
    let iPhoneFace = UIImageView(image: UIImage(named: "iPhone XR face black"))
    
    @IBAction func build(_ sender: Any) {
        check()
        if MenuViewController.developerMode {
            correct = true
        }
        
        guard correct else { return }
        
        let iPhone = UIImageView(image: UIImage(named: "iPhone XR"))
        iPhone.frame = CGRect(x: 0, y: 0, width: (view.frame.height-100)/1532*759, height: view.frame.height-100)
        self.view.addSubview(iPhone)
        
        iPhoneFace.frame = CGRect(x: 0, y: 0, width: (view.frame.height-100)/1532*759, height: view.frame.height-100)
        self.view.addSubview(iPhoneFace)
        
        botton.backgroundColor = .blue
        botton.setTitle("OFF", for: .normal)
        self.view.addSubview(botton)
        botton.addTarget(self, action: #selector(bottonPressed), for: .touchUpInside)
        
        UIView.animate(withDuration: 2) {
            self.navigationItem.rightBarButtonItems?.append(UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(self.done)))
        }
    }
    
    @objc func done() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Menu_View") as! MenuViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    func jumpToNextLine(line: Int) {
        lineArray[line-1].textColor = unusedLineColor
        labelArray[line-1].textColor = unusedLabelColor
        lineArray[line-1].resignFirstResponder()
        lineArray[line].becomeFirstResponder()
        lineArray[line].textColor = currentLineColor
        labelArray[line].textColor = currentLabelColor
    }
    
    var lightOn = true
    @objc func bottonPressed() {
        lightOn = !lightOn
        if lightOn {
            iPhoneFace.image = UIImage(named: "iPhone XR face black")
            botton.setTitle("OFF", for: .normal)
        }else{
            iPhoneFace.image = UIImage(named: "iPhone XR face")
            botton.setTitle("ON", for: .normal)
        }
    }
    
    @IBAction func lineOneBegin(_ sender: Any) {
        lineArray[0].textColor = currentLineColor
        labelArray[0].textColor = currentLabelColor
    }
    @IBAction func lineOne(_ sender: Any) {
        jumpToNextLine(line: 1)
    }
    @IBAction func lineTwo(_ sender: Any) {
        jumpToNextLine(line: 2)
    }
    @IBAction func lineThree(_ sender: Any) {
        jumpToNextLine(line: 3)
    }
    @IBAction func lineFour(_ sender: Any) {
        jumpToNextLine(line: 4)
    }
    @IBAction func lineFive(_ sender: Any) {
        jumpToNextLine(line: 5)
    }
    @IBAction func lineSix(_ sender: Any) {
        jumpToNextLine(line: 6)
    }
    @IBAction func lineSeven(_ sender: Any) {
        jumpToNextLine(line: 7)
    }
    @IBAction func lineEight(_ sender: Any) {
        jumpToNextLine(line: 8)
    }
    @IBAction func lineNine(_ sender: Any) {
        jumpToNextLine(line: 9)
    }
    @IBAction func lineTen(_ sender: Any) {
        jumpToNextLine(line: 10)
    }
    @IBAction func lineEleven(_ sender: Any) {
        jumpToNextLine(line: 11)
    }
    @IBAction func lineTwelve(_ sender: Any) {
        jumpToNextLine(line: 12)
    }
    @IBAction func lineThirtee(_ sender: Any) {
        jumpToNextLine(line: 13)
    }
    
    
}
