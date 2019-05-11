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
    
    init(_ correctLetters:Int, _ tappedLetters:Int, _ timePassed:String) {
        self.correctLetters = correctLetters
        self.tappedLatters = tappedLetters
        self.timePassed = timePassed
    }
    
    func timeDescription() -> String {
        return "Time: \(timePassed) seconds"
    }
    
    func accuracyRateDescription() -> String {
        return "Accuracy Rate: \(correctLetters*100/tappedLatters)%"
    }
    
    func accuracyDiscription() -> String {
        return "Accuracy: \(correctLetters)/\(tappedLatters)"
    }
    
    func dateDiscription() -> String {
        dateFomatter.dateStyle = .full
        dateFomatter.timeStyle = .medium
        
        dateFomatter.locale = Locale(identifier: "zh_CN")
        
        return "Taken Date: \(dateFomatter.string(from: Date()))"
    }
}
