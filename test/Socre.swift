//
//  Socre.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/11.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class Score:NSObject, NSCoding{
    var correctLetters:Int
    var tappedLatters:Int
    var correctLettersß:String {
        didSet {
            correctLetters = Int(correctLettersß)!
        }
    }
    var tappedLattersß:String {
        didSet {
            tappedLatters = Int(tappedLattersß)!
        }
    }
    let timePassed:String
    let dateFomatter = DateFormatter()
    var index = ""
    var firstRow:Bool
    var passageChoice:String
    var dateInt = 0
    var score = 0  //change to 0
    var takenDate = "?"
    
    enum PassageChoice {
        case maryHadALittleLamb
    }
    
    init(_ correctLetters:String, _ tappedLetters:String, _ timePassed:String, _ firstRow:Bool, _ passageChoice:String, _ takenDate: String) {
        self.correctLettersß = correctLetters
        self.tappedLattersß = tappedLetters
        self.correctLetters = Int(correctLetters)!
        self.tappedLatters = Int(tappedLetters)!
        self.timePassed = timePassed
        self.firstRow = firstRow
        self.passageChoice = passageChoice
        self.takenDate = takenDate
    }
    
    func timeDescription() -> String {
        return "Time: \(timePassed) seconds"
    }
    
    func accuracyRateDescreption() -> String {
        return "Accuracy Rate: \(correctLetters*100/tappedLatters)%"
    }
    
    func setupß() {
        correctLetters = Int(correctLettersß)!
        tappedLatters = Int(tappedLattersß)!
    }
    
    func accuracyDescription() -> String {
        if !firstRow {
            return "Accuracy: \(correctLetters)/\(tappedLatters)"
        } else {
            return " "
        }
    }
    
    func dateDescription() -> String {
        dateFomatter.dateStyle = .full
        dateFomatter.timeStyle = .medium
        
        dateFomatter.locale = Locale(identifier: "zh_CN")
        
        return "Taken Date: \(dateFomatter.string(from: Date()))"
    }
    
    func getDateInt() {
        dateFomatter.dateStyle = .short
        dateFomatter.timeStyle = .medium
        dateFomatter.locale = Locale(identifier: "zh_CN")
        
        let str = dateFomatter.string(from: Date())
        var strArray:[String] = []
        
        for i in str {
            if i == "上" {
                continue
            } else if i == "下" {
                continue
            } else if i == "午" {
                continue
            } else {
                strArray.append(String(i))
            }
        }
        
        var tempIntString = ""
        var used = false
        for i in strArray {
            if Int(String(i)) != nil {
                tempIntString += String(i)
                
                if i != strArray[strArray.count-1] {
                    continue
                }
            }
            
            if i == "/" && tempIntString.count == 4 {
                if Int(tempIntString)! % 4 == 0 {
                    dateInt += Int(tempIntString)!*366*24*60*60
                } else {
                    dateInt += Int(tempIntString)!*365*24*60*60
                }
                tempIntString = ""
            } else if i == "/" {
                guard Int(tempIntString)! != 1,
                    Int(tempIntString)! != 3,
                    Int(tempIntString)! != 5,
                    Int(tempIntString)! != 7,
                    Int(tempIntString)! != 8,
                    Int(tempIntString)! != 10,
                    Int(tempIntString)! != 12 else {
                        dateInt += Int(tempIntString)!*30*24*60*60
                        tempIntString = ""
                        continue
                }
                dateInt += Int(tempIntString)!*31*24*60*60
                
                tempIntString = ""
            } else if i == " " {
                dateInt += Int(tempIntString)!*24*60*60
                tempIntString = ""
            } else if i == ":" && !used {
                used = true
                dateInt += Int(tempIntString)!*60*60
                tempIntString = ""
            } else if i == ":" {
                dateInt += Int(tempIntString)!*60
                tempIntString = ""
            } else {
                dateInt += Int(tempIntString)!
            }
        }
    }
    
    func timeDescriptionShort() -> String {
        if !firstRow {
            return String(timePassed)
        } else {
            return "Duration"
        }
    }
    
    func accuracyRateDescriptionShort(_ installed:Bool) -> String {
        guard installed else {
            return " "
        }
        
        guard tappedLatters != 0 else { return "Accuracy Rate" }
        if !firstRow {
            return "\(correctLetters*100/tappedLatters)%"
        } else {
            return "Accuracy Rate"
        }
    }
    
    func dateDescriptionShort() {
        if !firstRow {
            dateFomatter.dateStyle = .short
            dateFomatter.timeStyle = .none
            
            dateFomatter.locale = Locale(identifier: "zh_CN")
            
            takenDate = String(dateFomatter.string(from: Date()))
        } else {
            takenDate = "Date"
        }
    }
    
    func indexDescription(_ index:Int) -> String {
        if !firstRow {
            return String(index)
        } else {
            return " "
        }
    }
    
    func getPassageName() -> String {
        return "Passage: \(passageChoice)"
    }
    
    func calculateScore() -> String {
        if firstRow {
            return "Score"
        } else {
            guard Double(timePassed) != nil else { return "Incompleted" }
            guard Double(timePassed)! >= 60.0 else {
                score = 0
                return "Incompleted"
            }
            score = 60*correctLetters/Int(Double(timePassed)!)
            return "\(score)"
        }
    }
    
    
    
    //saving Data
    
    struct PropertyKey {
        static let correctLetters = "correctLetters"
        static let tappedLetters = "tappedletters"
        static let timePassed = "timePassed"
        static let firstRow = "forstRow"
        static let passageChoice = "passageChoice"
        static let takenDate = "takenDate"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let timepassed = aDecoder.decodeObject(forKey: PropertyKey.timePassed) as? String,
            let passageChoice = aDecoder.decodeObject(forKey: PropertyKey.passageChoice) as? String,
            let correctLetters = aDecoder.decodeObject(forKey: PropertyKey.correctLetters) as? String,
            let tappedLetters = aDecoder.decodeObject(forKey: PropertyKey.tappedLetters) as? String,
            let takenDate = aDecoder.decodeObject(forKey: PropertyKey.takenDate) as? String else {
                return nil
        }
        
        let firstRow = aDecoder.decodeObject(forKey: PropertyKey.firstRow)
        
        self.init(correctLetters , tappedLetters , timepassed, (firstRow != nil), passageChoice, takenDate)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(correctLettersß, forKey: PropertyKey.correctLetters)
        aCoder.encode(tappedLattersß, forKey: PropertyKey.tappedLetters)
        aCoder.encode(timePassed, forKey: PropertyKey.timePassed)
        aCoder.encode(firstRow, forKey: PropertyKey.firstRow)
        aCoder.encode(passageChoice, forKey: PropertyKey.passageChoice)
        aCoder.encode(takenDate, forKey: PropertyKey.takenDate)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("save")
    
    static func load() -> [Score]? {
        print(Score.ArchiveURL.path)
        return NSKeyedUnarchiver.unarchiveObject(withFile: Score.ArchiveURL.path) as? [Score]
    }
    
    static func save(_ score: [Score]) {
        NSKeyedArchiver.archiveRootObject(score, toFile: Score.ArchiveURL.path)
    }
}
