//
//  scoreView.swift
//  test
//
//  Created by Vaida on 2019/5/9.
//  Copyright © 2019 Vaida. All rights reserved.
//

import Foundation
import UIKit

var scoresViewHasSet = false
class scoresView:UITableViewController {
    var isPickerHidden:[Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define the first row
        if !scoresViewHasSet {
            let rowFirstCell = Score.init(0, 0, "0", true, .maryHadALittleLamb)
            scoresView.scoreCollection.insert(rowFirstCell, at: 0)
            scoresViewHasSet = true
        }
        
        for _ in 1...scoresView.scoreCollection.count {
            isPickerHidden.append(false)
        }
    }
    
    static var scoreCollection:[Score] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresView.scoreCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scoresViewCell") as? scoresViewCell else {
            fatalError("Could not dequeue a cell")
        }
        
        let score = scoresView.scoreCollection[indexPath.row]
        cell.indexLabel.text = score.indexDescription(indexPath.row)
        cell.accuracyLabel.text = score.accuracyRateDescriptionShort(!isPickerHidden[indexPath.row])
        cell.dateLabel.text = score.dateDescriptionShort()
        cell.durationlabel.text = score.timeDescriptionShort()
        cell.accuracyNumberLabel.text = score.accuracyDescription()
        cell.passageLabel.text = score.getPassageName()
        
       return cell
    }
    
    //make the hight of each cell dynamic
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let normalCellHeight = CGFloat(44)
        let largeCellHeihgt = CGFloat(142)
        
        switch indexPath {
        case [0,0]:
            return normalCellHeight
        default:
            return isPickerHidden[indexPath.row] ? largeCellHeihgt : normalCellHeight
        }
    }
    
    //make the height of each cell dynamic when you tapped...
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            break
        default:
            isPickerHidden[indexPath.row] = !isPickerHidden[indexPath.row]
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
}
