//
//  Socre.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/11.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class Score {
    let correctLetters:Int
    let tappedLatters:Int
    let timePassed:String
    let dateFomatter = DateFormatter()
    var index = ""
    var firstRow:Bool
    var passageChoice:PassageChoice
    var dateInt = 0
    var score = 0  //change to 0
    
    enum PassageChoice {
        case maryHadALittleLamb
    }
    
    init(_ correctLetters:Int, _ tappedLetters:Int, _ timePassed:String, _ firstRow:Bool, _ passageChoice:PassageChoice) {
        self.correctLetters = correctLetters
        self.tappedLatters = tappedLetters
        self.timePassed = timePassed
        self.firstRow = firstRow
        self.passageChoice = passageChoice
    }
    
    func timeDescription() -> String {
        return "Time: \(timePassed) seconds"
    }
    
    func accuracyRateDescreption() -> String {
        return "Accuracy Rate: \(correctLetters*100/tappedLatters)%"
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
        
        if !firstRow {
            return "\(correctLetters*100/tappedLatters)%"
        } else {
            return "Accuracy Rate"
        }
    }
    
    func dateDescriptionShort() -> String {
        if !firstRow {
            dateFomatter.dateStyle = .short
            dateFomatter.timeStyle = .none
            
            dateFomatter.locale = Locale(identifier: "zh_CN")
            
            return String(dateFomatter.string(from: Date()))
        } else {
            return "Date"
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
        switch passageChoice {
        case .maryHadALittleLamb:
            return "Passage: Mary Had A Little lamb"
        }
    }
    
    func calculateScore() -> String {
        if firstRow {
            return "Score"
        } else {
            guard Double(timePassed)! >= 60.0 else {
                score = 0
                return "Incompleted"
            }
            score = correctLetters/Int(Double(timePassed)!)*60
            return "\(score)"
        }
    }
    
}
