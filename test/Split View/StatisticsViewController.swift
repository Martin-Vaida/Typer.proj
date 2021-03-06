//
//  StatisticsViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/14.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class StatisticsViewController:UITableViewController {
    
    @IBOutlet weak var averageAccuracyRateView: UIView!
    
    var scoreCollectionß = scoresView.scoreCollection
    
    var isViewHiddenå = [Bool](repeating: true, count: 4)
    var isViewHiddenß = [Bool](repeating: true, count: 4)
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if MenuViewController.studentsMode {
            return 2
        } else {
            return 1
        }
    }
    
    //make the hight of each cell dynamic
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let normalCellHeight = CGFloat(44)
        let largeCellHeihgt = CGFloat(274)
        if indexPath.section == 0 {
            return isViewHiddenå[indexPath.row] ? normalCellHeight : largeCellHeihgt
        } else if indexPath.section == 1 {
            return isViewHiddenß[indexPath.row] ? normalCellHeight : largeCellHeihgt
        } else {
            return normalCellHeight
        }
    }
    
    //make the height of each cell dynamic when you tapped...
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            isViewHiddenå[indexPath.row] = !isViewHiddenå[indexPath.row]
        }
        if indexPath.section == 1 {
            isViewHiddenß[indexPath.row] = !isViewHiddenß[indexPath.row]
        }
    
        tableView.beginUpdates()
        tableView.endUpdates()
        
        guard scoreCollectionß.count >= 2 else { return }
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                makeAverageAccuracyChart(from: .averageAccuracyRate)
            case 1:
                makeAverageAccuracyChart(from: .HighestRate)
            case 2:
                makeAverageAccuracyChart(from: .LowistRate)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                makeScoreChart()
            default:
                break
            }
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        guard scoreCollectionß.count >= 2 else { return }
        var average = 0
        var correct = 0
        var tapped = 0
        var heighest = 0
        var lowest = 100
        
        for i in scoreCollectionß {
            correct += i.correctLetters
            tapped += i.tappedLatters
        }
        average = correct*100/tapped
        
        let title = NSAttributedString(string: "Average Accuracy Rate: ", attributes:  [NSAttributedString.Key.foregroundColor: UIColor.black])
        let contents = NSAttributedString(string: "\(average)%", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        let message = NSMutableAttributedString(attributedString: title)
        message.append(contents)
        averayAccuracyLabel.attributedText = message
        
        for i in scoreCollectionß {
            average = i.correctLetters*100/i.tappedLatters
            if average > heighest {
                heighest = average
            }
        }
        
        let titleß = NSAttributedString(string: "Highest Accuracy Rate: ", attributes:  [NSAttributedString.Key.foregroundColor: UIColor.black])
        let contentsß = NSAttributedString(string: "\(heighest)%", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        let messageß = NSMutableAttributedString(attributedString: titleß)
        messageß.append(contentsß)
        heighestAccuracyLabel.attributedText = messageß
        
        for i in scoreCollectionß {
            average = i.correctLetters*100/i.tappedLatters
            if average < lowest{
                lowest = average
            }
        }
        
        let titleå = NSAttributedString(string: "Lowest Accuracy Rate: ", attributes:  [NSAttributedString.Key.foregroundColor: UIColor.black])
        let contentså = NSAttributedString(string: "\(lowest)%", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        let messageå = NSMutableAttributedString(attributedString: titleå)
        messageå.append(contentså)
        lowestAccuracyLabel.attributedText = messageå
        
        var score = 0
        
        for i in scoreCollectionß {
            let scoreß = i.correctLetters*60/Int(Double(i.timePassed)!)
            score += scoreß
        }
        score /= scoreCollectionß.count
        
        let titleœ = NSAttributedString(string: "Average Score: ", attributes:  [NSAttributedString.Key.foregroundColor: UIColor.black])
        let contentsœ = NSAttributedString(string: "\(score)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        let messageœ = NSMutableAttributedString(attributedString: titleœ)
        messageœ.append(contentsœ)
        averageScoreLabel.attributedText = messageœ
    }
    
    func setup() {
        scoreCollectionß = scoresView.scoreCollection
        
        guard scoreCollectionß.count >= 2 else { return }
        scoreCollectionß.remove(at: 0)
        
        guard MenuViewController.studentsMode else { return }
        
        var a = -1
        for _ in 0...scoreCollectionß.count-1 {
            a += 1
            if Double(scoreCollectionß[a].timePassed) == nil {
                scoreCollectionß.remove(at: a)
                a -= 1
                continue
            }
            if Double(scoreCollectionß[a].timePassed)! < 60.0 {
                scoreCollectionß.remove(at: a)
                a -= 1
            }
        }
    }
    
    //Make Cahrts
        //Average Accurcy Charts
    @IBOutlet weak var averageAccuracyView: UIView!
    @IBOutlet weak var averayAccuracyLabel: UILabel!
    @IBOutlet weak var highestAccuracyView: UIView!
    @IBOutlet weak var heighestAccuracyLabel: UILabel!
    @IBOutlet weak var lowestAccuracyView: UIView!
    @IBOutlet weak var lowestAccuracyLabel: UILabel!
    @IBOutlet weak var averageScoreLabel: UILabel!
    @IBOutlet weak var averageScoreView: UIView!
    
    
    enum rowName {
        case averageAccuracyRate
        case HighestRate
        case LowistRate
        case averageScore
    }
    
    func makeAverageAccuracyChart(from: rowName) {
        let viewArray = [averageAccuracyView, highestAccuracyView, lowestAccuracyView]
        var viewInt = 0
        
        switch from {
        case .averageAccuracyRate:
            viewInt = 0
        case .HighestRate:
            viewInt = 1
        case .LowistRate:
            viewInt = 2
        case .averageScore:
            viewInt = 3
        }
        
        var average = 0
        var correct = 0
        var tapped = 0
        var heighest = 0
        var lowest = 100
        
        if from == .averageAccuracyRate {
            for i in scoreCollectionß {
                correct += i.correctLetters
                tapped += i.tappedLatters
            }
            average = correct*100/tapped
        } else if from == .HighestRate {
            for i in scoreCollectionß {
                average = i.correctLetters*100/i.tappedLatters
                if average > heighest {
                    heighest = average
                }
            }
        } else if from == .LowistRate {
            for i in scoreCollectionß {
                average = i.correctLetters*100/i.tappedLatters
                if average < lowest{
                    lowest = average
                }
            }
        }
        
        
        // Y-Axis Name Labels
        let yAxisNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        yAxisNameLabel.text = "Percentage"
        yAxisNameLabel.textColor = .lightGray
        yAxisNameLabel.font = .systemFont(ofSize: 12)
        yAxisNameLabel.textAlignment = .center
        yAxisNameLabel.adjustsFontSizeToFitWidth = true
        viewArray[viewInt]!.addSubview(yAxisNameLabel)
        
        // Y-Axis Design
        let yAxisArray:NSArray = ["100", "80", "60", "40", "20", "0"]
        for i:Int in 0 ..< yAxisArray.count {
            // Y-Axis Value
            let yAxisValue = UILabel(frame: CGRect(x: 0, y: 30+CGFloat(i)*30, width: 30, height: 30))
            yAxisValue.text = yAxisArray[i] as? String
            yAxisValue.font = .systemFont(ofSize: 11)
            yAxisValue.textAlignment = .center
            yAxisValue.adjustsFontSizeToFitWidth = true
            yAxisValue.textColor = .lightGray
            viewArray[viewInt]!.addSubview(yAxisValue)
            
        }
        
        //Set X-Axis Layer
        let xlayer = CAShapeLayer()
        xlayer.fillColor = UIColor.clear.cgColor
        xlayer.lineWidth = 1.0
        xlayer.strokeColor = UIColor.black.cgColor
        viewArray[viewInt]!.layer.addSublayer(xlayer)
        
        let pathß = UIBezierPath()
        pathß.move(to: CGPoint(x: 30, y: 195))
        pathß.addLine(to: CGPoint(x: 630, y: 195))
        xlayer.path = pathß.cgPath
        
        //Set Y-Axis Layer
        let ylayer = CAShapeLayer()
        ylayer.fillColor = UIColor.clear.cgColor
        ylayer.lineWidth = 1.0
        ylayer.strokeColor = UIColor.black.cgColor
        viewArray[viewInt]!.layer.addSublayer(ylayer)
        
        let pathå = UIBezierPath()
        pathå.move(to: CGPoint(x: 30, y: 30))
        pathå.addLine(to: CGPoint(x: 30, y: 195))
        ylayer.path = pathå.cgPath
        
        // X-Axis Name Labels
        let xAxisNameLabel = UILabel(frame: CGRect(x: 600, y: 200, width: 60, height: 30))
        xAxisNameLabel.text = "Times"
        xAxisNameLabel.textColor = .lightGray
        xAxisNameLabel.font = .systemFont(ofSize: 12)
        xAxisNameLabel.textAlignment = .center
        xAxisNameLabel.adjustsFontSizeToFitWidth = true
        viewArray[viewInt]!.addSubview(xAxisNameLabel)
        
        // X-Axis Design
        var xAxisArray:[String] = []
        for i in 0...scoreCollectionß.count {
            xAxisArray.append("\(i)")
        }
        
        
        for i in 0 ..< xAxisArray.count {
            // X-Axis value
            let xAxisValue = UILabel(frame: CGRect(x: CGFloat(600/xAxisArray.count*i), y: 200, width: 30, height: 30))
            xAxisValue.text = xAxisArray[i]
            xAxisValue.font = .systemFont(ofSize: 12)
            xAxisValue.adjustsFontSizeToFitWidth = true
            xAxisValue.textAlignment = .right
            xAxisValue.textColor = .lightGray
            viewArray[viewInt]!.addSubview(xAxisValue)
        }
        
        //Set Layer
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.0
        layer.strokeColor = UIColor.blue.cgColor
        viewArray[viewInt]!.layer.addSublayer(layer)
        
        let path = UIBezierPath()
        //Starting Point
        var xArray:[Int] = []
        var yArray:[Double] = []
        
        for i in 1 ... scoreCollectionß.count {
            xArray.append(30+600/xAxisArray.count*i)
        }
        
        for i in scoreCollectionß {
            yArray.append(45.0+150.0 - ((Double(i.correctLetters)/Double(i.tappedLatters)*150.0)))
        }
        
        path.move(to: CGPoint(x: xArray[0] , y: Int(yArray[0])))
        for i in 1..<scoreCollectionß.count {
            path.addLine(to: CGPoint(x: CGFloat(xArray[i]), y: CGFloat(yArray[i])))
        }
        layer.path = path.cgPath
        
        //Connect the points
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 5.0
        layer.add(animation, forKey: "strokeEnd")
        
        
        if from == .averageAccuracyRate {
            let layer = CAShapeLayer()
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 0.5
            layer.strokeColor = UIColor.red.cgColor
            viewArray[viewInt]!.layer.addSublayer(layer)
            
            let pathƒ = UIBezierPath()
            pathƒ.move(to: CGPoint(x: 30, y: 45+150-average*3/2))
            pathƒ.addLine(to: CGPoint(x: 630, y: 45+150-average*3/2))
            layer.path = pathƒ.cgPath
        } else if from == .HighestRate {
            let layer = CAShapeLayer()
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 0.5
            layer.strokeColor = UIColor.red.cgColor
            viewArray[viewInt]!.layer.addSublayer(layer)
            
            let pathƒ = UIBezierPath()
            pathƒ.move(to: CGPoint(x: 30, y: 45+150-heighest*3/2))
            pathƒ.addLine(to: CGPoint(x: 630, y: 45+150-heighest*3/2))
            layer.path = pathƒ.cgPath
        } else if from == .LowistRate {
            let layer = CAShapeLayer()
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 0.5
            layer.strokeColor = UIColor.red.cgColor
            viewArray[viewInt]!.layer.addSublayer(layer)
            
            let pathƒ = UIBezierPath()
            pathƒ.move(to: CGPoint(x: 30, y: 45+150-lowest*3/2))
            pathƒ.addLine(to: CGPoint(x: 630, y: 45+150-lowest*3/2))
            layer.path = pathƒ.cgPath
        }
    }
    
    func makeScoreChart() {
        var score = 0
        
        for i in scoreCollectionß {
            let scoreß = i.correctLetters*60/Int(Double(i.timePassed)!)
            score += scoreß
        }
        score /= scoreCollectionß.count
        
        // Y-Axis Name Labels
        let yAxisNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        yAxisNameLabel.text = "Score"
        yAxisNameLabel.textColor = .lightGray
        yAxisNameLabel.font = .systemFont(ofSize: 12)
        yAxisNameLabel.textAlignment = .center
        yAxisNameLabel.adjustsFontSizeToFitWidth = true
        averageScoreView.addSubview(yAxisNameLabel)
        
        // Y-Axis Design
        let yAxisArray:NSArray = ["250", "200", "150", "100", "50", "0"]
        for i:Int in 0 ..< yAxisArray.count {
            // Y-Axis Value
            let yAxisValue = UILabel(frame: CGRect(x: 0, y: 30+CGFloat(i)*30, width: 30, height: 30))
            yAxisValue.text = yAxisArray[i] as? String
            yAxisValue.font = .systemFont(ofSize: 11)
            yAxisValue.textAlignment = .center
            yAxisValue.adjustsFontSizeToFitWidth = true
            yAxisValue.textColor = .lightGray
           averageScoreView.addSubview(yAxisValue)
            
        }
        
        //Set X-Axis Layer
        let xlayer = CAShapeLayer()
        xlayer.fillColor = UIColor.clear.cgColor
        xlayer.lineWidth = 1.0
        xlayer.strokeColor = UIColor.black.cgColor
        averageScoreView.layer.addSublayer(xlayer)
        
        let pathß = UIBezierPath()
        pathß.move(to: CGPoint(x: 30, y: 195))
        pathß.addLine(to: CGPoint(x: 630, y: 195))
        xlayer.path = pathß.cgPath
        
        //Set Y-Axis Layer
        let ylayer = CAShapeLayer()
        ylayer.fillColor = UIColor.clear.cgColor
        ylayer.lineWidth = 1.0
        ylayer.strokeColor = UIColor.black.cgColor
        averageScoreView.layer.addSublayer(ylayer)
        
        let pathå = UIBezierPath()
        pathå.move(to: CGPoint(x: 30, y: 30))
        pathå.addLine(to: CGPoint(x: 30, y: 195))
        ylayer.path = pathå.cgPath
        
        // X-Axis Name Labels
        let xAxisNameLabel = UILabel(frame: CGRect(x: 600, y: 200, width: 60, height: 30))
        xAxisNameLabel.text = "Times"
        xAxisNameLabel.textColor = .lightGray
        xAxisNameLabel.font = .systemFont(ofSize: 12)
        xAxisNameLabel.textAlignment = .center
        xAxisNameLabel.adjustsFontSizeToFitWidth = true
        averageScoreView.addSubview(xAxisNameLabel)
        
        // X-Axis Design
        var xAxisArray:[String] = []
        for i in 0...scoreCollectionß.count {
            xAxisArray.append("\(i)")
        }
        
        
        for i in 0 ..< xAxisArray.count {
            // X-Axis value
            let xAxisValue = UILabel(frame: CGRect(x: CGFloat(600/xAxisArray.count*i), y: 200, width: 30, height: 30))
            xAxisValue.text = xAxisArray[i]
            xAxisValue.font = .systemFont(ofSize: 12)
            xAxisValue.adjustsFontSizeToFitWidth = true
            xAxisValue.textAlignment = .right
            xAxisValue.textColor = .lightGray
            averageScoreView.addSubview(xAxisValue)
        }
        
        //Set Layer
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.0
        layer.strokeColor = UIColor.blue.cgColor
        averageScoreView.layer.addSublayer(layer)
        
        let path = UIBezierPath()
        //Starting Point
        var xArray:[Int] = []
        var yArray:[Double] = []
        
        for i in 1 ... scoreCollectionß.count {
            xArray.append(30+600/xAxisArray.count*i)
        }
        
        for i in scoreCollectionß {
            let score = i.correctLetters*60/Int(Double(i.timePassed)!)
            yArray.append(45.0+150.0 - Double(score)*150.0/250.0)
        }
        
        path.move(to: CGPoint(x: xArray[0] , y: Int(yArray[0])))
        for i in 1..<scoreCollectionß.count {
            path.addLine(to: CGPoint(x: CGFloat(xArray[i]), y: CGFloat(yArray[i])))
        }
        layer.path = path.cgPath
        
        //Connect the points
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 5.0
        layer.add(animation, forKey: "strokeEnd")
        
        
        for _ in 0...0 {
            let layer = CAShapeLayer()
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 0.5
            layer.strokeColor = UIColor.green.cgColor
            averageScoreView.layer.addSublayer(layer)
            
            let pathƒ = UIBezierPath()
            let scoreß = 170
            let coordinate = 45.0+150.0 - Double(scoreß)*150.0/250.0
            pathƒ.move(to: CGPoint(x: 30, y: coordinate))
            pathƒ.addLine(to: CGPoint(x: 630, y: coordinate))
            layer.path = pathƒ.cgPath
            
            let nameLabel = UILabel(frame: CGRect(x: 600, y: coordinate-5, width: 60, height: 30))
            nameLabel.text = "170"
            nameLabel.textColor = .green
            nameLabel.font = .systemFont(ofSize: 12)
            nameLabel.textAlignment = .center
            nameLabel.adjustsFontSizeToFitWidth = true
            averageScoreView.addSubview(nameLabel)
        }
    }
    
    
}

//All rights reserved.
