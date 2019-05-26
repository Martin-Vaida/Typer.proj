//
//  Support.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/23.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class Support {
    static var width:Int = 100
    static var y:Int = 100
    
    static func setup() {
        
    }
}

extension CGRect {
    struct Point {
        var x:CGFloat = 0.0, y:CGFloat = 0.0
    }
    
    init(center: Point, size: CGSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: CGPoint(x: originX, y: originY), size: size)
    }
}

extension UIView {
    struct Content {
        static var labelText = "labelText"
    }
    
    static func makeView(x:Int, y:Int, labelText:String) -> UIView {
        let view = UIView(frame: CGRect(x: x, y: Support.y+y, width: Support.width-17, height: 88))
        let label = UILabel(frame: CGRect(x: 8, y: 0, width: Support.width-25, height: 44))
        let text = UITextField(frame: CGRect(x: 0, y: 44, width: Support.width-17, height: 44))
        label.text = labelText
        text.borderStyle = .roundedRect
        SetMutiBorderRoundingCorners(view, corner: 10)
        view.addSubview(label)
        view.addSubview(text)
        view.isOpaque = true
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        gameViewController.textArray.append(labelText)
        gameViewController.showTextArray.append(text)
        
        return view
    }
}

func SetMutiBorderRoundingCorners(_ view:UIView,corner:CGFloat) {
    let maskPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: [UIRectCorner.bottomLeft, UIRectCorner.topRight, UIRectCorner.bottomRight, UIRectCorner.topLeft], cornerRadii: CGSize(width: corner, height: corner))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = view.bounds
    maskLayer.path = maskPath.cgPath
    view.layer.mask = maskLayer
}
