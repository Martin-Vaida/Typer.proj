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
    
    //make the hight of each cell dynamic
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let normalCellHeight = CGFloat(44)
        let largeCellHeihgt = CGFloat(274)
        if indexPath.section == 0 {
            return isViewHiddenå[indexPath.row] ? normalCellHeight : largeCellHeihgt
        } else {
            return normalCellHeight
        }
    }
    
    //make the height of each cell dynamic when you tapped...
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            isViewHiddenå[indexPath.row] = !isViewHiddenå[indexPath.row]
            }
        setup()
        tableView.beginUpdates()
        tableView.endUpdates()
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                makeAverageAccuracyChart()
            default:
                break
            }
        default:
            break
        }
    }
    
    func setup() {
        
        scoreCollectionß = scoresView.scoreCollection
        print("Ha")
        guard scoreCollectionß.count >= 2 else { return }
        scoreCollectionß.remove(at: 0)
        print(scoreCollectionß)
    }
    
    //Make Cahrts
        //Average Accurcy Charts
    @IBOutlet weak var averageAccuracyView: UIView!
    
    func makeAverageAccuracyChart() {
        
        // Y-Axis Name Labels
        let yAxisNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        yAxisNameLabel.text = "Percentage"
        yAxisNameLabel.textColor = .lightGray
        yAxisNameLabel.font = .systemFont(ofSize: 12)
        yAxisNameLabel.textAlignment = .center
        yAxisNameLabel.adjustsFontSizeToFitWidth = true
        averageAccuracyView.addSubview(yAxisNameLabel)
        
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
            averageAccuracyView.addSubview(yAxisValue)
            // Y-Axis Line
            let yAxisLine = UIView(frame: CGRect(x: 30, y: 45+30*CGFloat(i) , width: 600, height: 1))
            if i == yAxisArray.count-1 {
                yAxisLine.backgroundColor = .black
            } else {
                yAxisLine.backgroundColor = .lightGray
            }
            averageAccuracyView.addSubview(yAxisLine)
        }
        
        // X-Axis Name Labels
        let xAxisNameLabel = UILabel(frame: CGRect(x: 600, y: 200, width: 60, height: 30))
        xAxisNameLabel.text = "Time"
        xAxisNameLabel.textColor = .lightGray
        xAxisNameLabel.font = .systemFont(ofSize: 12)
        xAxisNameLabel.textAlignment = .center
        xAxisNameLabel.adjustsFontSizeToFitWidth = true
        averageAccuracyView.addSubview(xAxisNameLabel)
        
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
            averageAccuracyView.addSubview(xAxisValue)
            // X-Axis Line
            let xAxisLine = UIView(frame: CGRect(x: CGFloat(600/xAxisArray.count*i)+30, y: 30, width: 1, height: 165))
            if i == 0 {
                xAxisLine.backgroundColor = .black
            } else {
                xAxisLine.backgroundColor = .lightGray
            }
            averageAccuracyView.addSubview(xAxisLine)
        }
        
        //Set Layer
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.0
        layer.strokeColor = UIColor.blue.cgColor
        averageAccuracyView.layer.addSublayer(layer)
        
        let path = UIBezierPath()
        //Starting Point
        var xArray:[Int] = []
        var yArray:[Double] = []
        
        for i in 1 ... scoreCollectionß.count {
            xArray.append(30+600/xAxisArray.count*i)
        }
        
        for i in scoreCollectionß {
            yArray.append(45.0+150.0 - ((Double(i.correctLetters)/Double(i.tappedLatters)*150.0)))
            print(i.correctLetters)
            print(i.tappedLatters)
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
    }
    
    
}
