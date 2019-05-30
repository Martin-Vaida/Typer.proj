//
//  PassedStudentsViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/30.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class PassedStudentsViewController:UITableViewController {
    var passedStudents:[Score] = []
    
    override func viewDidLoad() {
        for i in scoresView.scoreCollection {
            i.calculateScore()
            if i.score >= 170 {
                passedStudents.append(i)
                print(passedStudents)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedStudents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Passed_Students_Cell") as? PassedStudentsCell else {
            fatalError("Could not dequeue a cell")
        }
        let score = passedStudents[indexPath.row]
        cell.label.text = score.userName
        return cell
    }
}
