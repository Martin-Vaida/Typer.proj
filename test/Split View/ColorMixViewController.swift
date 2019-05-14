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
    
    var red:CGFloat = 0.5
    var yellow:CGFloat = 0.5
    var blue:CGFloat = 0.5
    var black:CGFloat = 0.5
    
    let currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    let currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    let unsedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    let unsedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch DetailViewController.target {
        case .currentLabel:
            sampleLabel.text = "Editing: Current Label"
            sampleLabel.textColor = currentLabelColor
            
        case .currentLine:
            sampleLabel.text = "Editing: Current Line"
        case .unusedLabel:
            sampleLabel.text = "Editing: Unused Label"
        case .unusedLine:
            sampleLabel.text = "Editing: Unsed Line"
        }
        
    }
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var yellowSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blackSlider: UISlider!
    
    @IBOutlet weak var sampleLabel: UILabel!
    
    @IBAction func redSliderChanged(_ sender: Any) {
        red = CGFloat(redSlider.value)
        updateColor()
    }
    
    @IBAction func yellowSliderChanged(_ sender: Any) {
        yellow = CGFloat(yellowSlider.value)
        updateColor()
    }
    
    @IBAction func blueSliderChanged(_ sender: Any) {
        blue = CGFloat(blueSlider.value)
        updateColor()
    }
    
    @IBAction func blackSliderChanged(_ sender: Any) {
        black = CGFloat(blackSlider.value)
        updateColor()
    }
    
    func updateColor() {
        sampleLabel.textColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        switch DetailViewController.target {
        case .currentLabel:
            print("CurrentLable")
            MarryHadALittleLambController.currentLabelColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
        case .currentLine:
            print("CurrentLine")
        case .unusedLabel:
            print("UnusedtLable")
        case .unusedLine:
            print("UnusedLine")
        }
    }
}
