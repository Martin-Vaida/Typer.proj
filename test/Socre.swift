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
    
}
