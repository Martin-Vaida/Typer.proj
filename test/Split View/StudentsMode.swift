//
//  studentsMode.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/20.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class StudentsMode:NSObject, NSCoding {
    var isOn:Bool
    var autoStop:Bool
    var isOnß:String
    var autoStopß:String
    
    init(isOn:Bool, autoStop:Bool) {
        self.isOn = isOn
        self.autoStop = autoStop
        
        self.isOnß = String(isOn)
        self.autoStopß = String(autoStop)
    }
    
    struct PropertyKey {
        static let isOn = "isOn"
        static let autoStop = "autoStop"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let isOn = aDecoder.decodeObject(forKey: PropertyKey.isOn) as? String,
            let autoStop = aDecoder.decodeObject(forKey: PropertyKey.autoStop) as?String else {
                return nil
        }
        
        self.init(isOn:Bool(isOn)!, autoStop:Bool(autoStop)!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(isOnß, forKey: PropertyKey.isOn)
        aCoder.encode(autoStopß, forKey: PropertyKey.autoStop)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("StudentsMode")
    
    static func load() -> StudentsMode? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: StudentsMode.ArchiveURL.path) as? StudentsMode
    }
    
    static func save(_ object: StudentsMode) {
        NSKeyedArchiver.archiveRootObject(object, toFile: StudentsMode.ArchiveURL.path)
    }
    
    override var description: String {
        return "isOn:\(isOnß), autoStop:\(autoStopß)"
    }
}
