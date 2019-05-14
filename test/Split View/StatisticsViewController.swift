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
        let largeCellHeihgt = CGFloat(244)
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
    
}
