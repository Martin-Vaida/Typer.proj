//
//  UIColor.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/19.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class UIColorß: NSObject, NSCoding {
    var red:String
    var green:String
    var blue:String
    var alpha:String
    
    init(_ red:String, _ green:String, _ blue:String, _ alpha:String) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    struct PropertyKey {
        static let red = "red"
        static let green = "green"
        static let blue = "blue"
        static let alpha = "alpha"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let red = aDecoder.decodeObject(forKey: PropertyKey.red) as? String,
        let green = aDecoder.decodeObject(forKey: PropertyKey.green) as? String,
        let blue = aDecoder.decodeObject(forKey: PropertyKey.blue) as? String,
            let alpha = aDecoder.decodeObject(forKey: PropertyKey.alpha) as? String else {
                return nil
        }
        
        print("succeed")
        self.init(red, green, blue, alpha)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(red, forKey: PropertyKey.red)
        aCoder.encode(green, forKey: PropertyKey.green)
        aCoder.encode(blue, forKey: PropertyKey.blue)
        aCoder.encode(alpha, forKey: PropertyKey.alpha)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Color")
    
    static func load() -> [UIColorß]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: UIColorß.ArchiveURL.path) as? [UIColorß]
    }
    
    static func save(_ colors: [UIColorß]) {
        NSKeyedArchiver.archiveRootObject(colors, toFile: UIColorß.ArchiveURL.path)
    }
}
