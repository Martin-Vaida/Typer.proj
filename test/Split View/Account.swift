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
    
    init(name:String) {
        self.name = name
    }
    
    struct propertyKey {
        static let name = "name"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let string = aDecoder.decodeObject(forKey: propertyKey.name) as? String else { return nil }
        self.init(name:string)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: propertyKey.name)
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
