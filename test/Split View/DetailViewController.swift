//
//  DetailViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/14.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController:UIViewController {
    
    @IBOutlet weak var colorMixView: UIStackView!
    
    @IBOutlet weak var colorMixImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    static var target:Target = .currentLabel
    
    enum Target {
        case currentLabel, currentLine, unusedLabel, unusedLine
    }
    
    var enableColorMix = false {
        didSet {
            enableTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTableView()
    }
    
    func enableTableView() {
        if let tabelViewß = colorMixView {
            tabelViewß.isHidden = !enableColorMix
        }
        if let colorMixImageViewß = colorMixImageView {
            colorMixImageViewß.isHidden = !enableColorMix
        }
        if let labelß = label {
            labelß.isHidden = !enableColorMix
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCurrentLabelColorMixView" {
            DetailViewController.target = .currentLabel
        } else if segue.identifier == "ToCurrentLineColorMixView" {
            DetailViewController.target = .currentLine
        } else if segue.identifier == "ToUnusedLabelColorMixView" {
            DetailViewController.target = .unusedLabel
        } else if segue.identifier == "ToUnusedLineColorMixView" {
            DetailViewController.target = .unusedLine
        }
        
    }
}
