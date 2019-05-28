//
//  LightController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/28.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class LightController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        botton.setTitle("OFF", for: .normal)
        self.view.addSubview(botton)
        botton.addTarget(self, action: #selector(bottonPressed), for: .touchUpInside)
    }
    
    var lightOn = true
    let botton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
    
    @objc func bottonPressed() {
        lightOn = !lightOn
        if lightOn {
            view.backgroundColor = .white
            botton.setTitle("OFF", for: .normal)
        }else{
            view.backgroundColor = .black
            botton.setTitle("ON", for: .normal)
        }
    }
}
