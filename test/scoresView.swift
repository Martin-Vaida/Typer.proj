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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define the first row
        if !scoresViewHasSet {
            let rowFirstCell = Score.init(0, 0, "0", true)
            scoresView.scoreCollection.insert(rowFirstCell, at: 0)
            scoresViewHasSet = true
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
        cell.accuracyLabel.text = score.accuracyRateDescriptionShort()
        cell.dateLabel.text = score.dateDescriptionShort()
        cell.durationlabel.text = score.timeDescriptionShort()
        
       return cell
    }
}
