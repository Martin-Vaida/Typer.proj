//
//  colorMixViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/14.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class colorMixViewController:UITableViewController {
    
    static var colorArray:[UIColorß] = []
    
    var red:CGFloat = 0.5
    var yellow:CGFloat = 0.5
    var blue:CGFloat = 0.5
    var black:CGFloat = 0.5
    
    let currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    let currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    let unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    let unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if colorMixViewController.colorArray.count == 0 {
            colorMixViewController.colorArray.append(UIColorß("0.5", "0.5", "0.5", "1"))
            colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "1"))
            colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "0.2"))
            colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "0.2"))
        }
        
        switch DetailViewController.target {
        case .currentLabel:
            sampleLabel.text = "Editing: Current Label"
            redSlider.value = 0.5
            yellowSlider.value = 0.5
            blueSlider.value = 0.5
            blackSlider.value = 1
            
        case .currentLine:
            sampleLabel.text = "Editing: Current Line"
            redSlider.value = 0
            yellowSlider.value = 0
            blueSlider.value = 0
            blackSlider.value = 1
        case .unusedLabel:
            sampleLabel.text = "Editing: Unused Label"
            redSlider.value = 0
            yellowSlider.value = 0
            blueSlider.value = 0
            blackSlider.value = 0.2
        case .unusedLine:
            sampleLabel.text = "Editing: Unsed Line"
            redSlider.value = 0
            yellowSlider.value = 0
            blueSlider.value = 0
            blackSlider.value = 0.2
        }
        
        updateColor()
        
    }
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var yellowSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blackSlider: UISlider!
    
    @IBOutlet weak var sampleLabel: UILabel!
    
    @IBAction func redSliderChanged(_ sender: Any) {
        updateColor()
    }
    
    @IBAction func yellowSliderChanged(_ sender: Any) {
        updateColor()
    }
    
    @IBAction func blueSliderChanged(_ sender: Any) {
        updateColor()
    }
    
    @IBAction func blackSliderChanged(_ sender: Any) {
        updateColor()
    }
    
    func updateColor() {
        red = CGFloat(redSlider.value)
        yellow = CGFloat(yellowSlider.value)
        blue = CGFloat(blueSlider.value)
        black = CGFloat(blackSlider.value)
        sampleLabel.textColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        switch DetailViewController.target {
        case .currentLabel:
            MarryHadALittleLambController.currentLabelColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
            let color = UIColorß(String(Double(red)), String(Double(yellow)), String(Double(blue)), String(Double(black)))
            colorMixViewController.colorArray[0] = color
            
        case .currentLine:
            MarryHadALittleLambController.currentLineColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
            let color = UIColorß(String(Double(red)), String(Double(yellow)), String(Double(blue)), String(Double(black)))
            colorMixViewController.colorArray[1] = color
        case .unusedLabel:
            MarryHadALittleLambController.unusedLabelColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
            let color = UIColorß(String(Double(red)), String(Double(yellow)), String(Double(blue)), String(Double(black)))
            colorMixViewController.colorArray[2] = color
        case .unusedLine:
            MarryHadALittleLambController.unusedLineColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
            let color = UIColorß(String(Double(red)), String(Double(yellow)), String(Double(blue)), String(Double(black)))
            colorMixViewController.colorArray[3] = color
            
        }
        
        UIColorß.save(colorMixViewController.colorArray)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        switch DetailViewController.target {
        case .currentLabel:
            let alert = UIAlertController(title: "Reset?", message: "Are you sure? \n The color of current label will be set to default", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                self.redSlider.value = 0.5
                self.yellowSlider.value = 0.5
                self.blueSlider.value = 0.5
                self.blackSlider.value = 1
            }
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        case .currentLine:
            let alert = UIAlertController(title: "Reset?", message: "Are you sure? \n The color of current line will be set to default", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                self.redSlider.value = 0
                self.yellowSlider.value = 0
                self.blueSlider.value = 0
                self.blackSlider.value = 1
            }
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        case .unusedLabel:
            let alert = UIAlertController(title: "Reset?", message: "Are you sure? \n The color of unused label will be set to default", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                self.redSlider.value = 0
                self.yellowSlider.value = 0
                self.blueSlider.value = 0
                self.blackSlider.value = 0.2
            }
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        case .unusedLine:
            let alert = UIAlertController(title: "Reset?", message: "Are you sure? \n The color of unused line will be set to default", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                self.redSlider.value = 0
                self.yellowSlider.value = 0
                self.blueSlider.value = 0
                self.blackSlider.value = 0.2
            }
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        updateColor()
    }
    
}
