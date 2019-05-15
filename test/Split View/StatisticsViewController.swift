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
    
    var isViewHiddenå = [Bool](repeating: true, count: 4)
    
    //make the hight of each cell dynamic
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let normalCellHeight = CGFloat(44)
        let largeCellHeihgt = CGFloat(254)
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
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeAverageAccuracyChart()
    }
    
    //Make Cahrts
        //Average Accurcy Charts
    @IBOutlet weak var averageAccuracyView: UIView!
    
    func makeAverageAccuracyChart() {
        
        // Y-Axis Name Label
        let yAxisNameLabel = UILabel(frame: CGRect(x: 0, y: 10, width: 60, height: 30))
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
            let yAxisValue = UILabel(frame: CGRect(x: 0, y: 40+CGFloat(i)*30, width: 30, height: 30))
            yAxisValue.text = yAxisArray[i] as? String
            yAxisValue.font = .systemFont(ofSize: 11)
            yAxisValue.textAlignment = .center
            yAxisValue.adjustsFontSizeToFitWidth = true
            yAxisValue.textColor = .lightGray
            averageAccuracyView.addSubview(yAxisValue)
            // Y-Axis Line
            let yAxisLine = UIView(frame: CGRect(x: 30, y: 55+30*CGFloat(i) , width: 600, height: 1))
            if i == yAxisArray.count-1 {
                yAxisLine.backgroundColor = .black
            } else {
                yAxisLine.backgroundColor = .lightGray
            }
            averageAccuracyView.addSubview(yAxisLine)
        }
        
    }
    
    
}
