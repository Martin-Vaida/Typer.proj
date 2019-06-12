//
//  Account.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/28.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class Account:NSObject, NSCoding {
    var name:String
    var developerMode:String
    
    init(name:String, developer:Bool) {
        self.name = name
        self.developerMode = String(developer)
    }
    
    struct propertyKey {
        static let name = "name"
        static let developerMode = "developerMode"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let string = aDecoder.decodeObject(forKey: propertyKey.name) as? String,
        let developerMode = aDecoder.decodeObject(forKey: propertyKey.developerMode) as? String else { return nil }
        self.init(name:string, developer: Bool(developerMode)!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: propertyKey.name)
        aCoder.encode(developerMode, forKey: propertyKey.developerMode)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Account")
    
    static func load() -> Account? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Account.ArchiveURL.path) as? Account
    }
    
    static func save(_ account: Account) {
        NSKeyedArchiver.archiveRootObject(account, toFile: Account.ArchiveURL.path)
    }
}

//All rights reserved.
