//
//  scoreView.swift
//  test
//
//  Created by Vaida on 2019/5/9.
//  Copyright © 2019 Vaida. All rights reserved.
//

import Foundation
import UIKit

class scoresView:UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    static var scoreCollection:[Score] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresView.scoreCollection.count
    }
    
    
}
