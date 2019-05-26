//
//  scoreView.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/9.
//  Copyright © 2019 Vaida. All rights reserved.
//

import Foundation
import UIKit

var scoresViewHasSet = false
class scoresView:UITableViewController, UINavigationControllerDelegate {
    var isPickerHidden:[Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define the first row
        if !scoresViewHasSet {
            let rowFirstCell = Score.init("0", "0", "0", true, "Mary Had A Little lamb", "Taken Date")
            scoresView.scoreCollection.insert(rowFirstCell, at: 0)
            scoresViewHasSet = true
        }
        
        for _ in 1...scoresView.scoreCollection.count {
            isPickerHidden.append(false)
        }
        
        for i in 0...scoresView.scoreCollection.count-1{
            scoresView.scoreCollection[i].index = String(i)
        }
        
        
        guard scoresView.scoreCollection.count != 0 else { return }
        Score.save(scoresView.scoreCollection)
        
        scoresView.scoreCollection.remove(at: 0)
        
        let rowFirstCell = Score.init("0", "0", "0", true, "Mary Had A Little lamb", "Taken Date")
        scoresView.scoreCollection.insert(rowFirstCell, at: 0)
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
        cell.dateLabel.text = score.takenDate
        cell.durationlabel.text = score.timeDescriptionShort()
        cell.accuracyNumberLabel.text = score.accuracyDescription()
        cell.passageLabel.text = score.getPassageName()
        
        if MenuViewController.studentsMode {
            cell.isHidden = false
            cell.scoreLabel.text = score.calculateScore()
        } else {
            cell.scoreLabel.isHidden = true
        }
        
        if score.score >= 170 {
            cell.contentView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1)
        }
        
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
    
    @IBAction func sortByTapped(_ sender: Any) {
        
        let alartController = UIAlertController(title: "Choose The Way To Sort These Items", message: nil, preferredStyle:.actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alartController.addAction(cancelAction)
        
        let sortByTimeAction = UIAlertAction(title: "By Duration", style: .default) { (action) in
            self.sortItems(by: .time)
        }
        alartController.addAction(sortByTimeAction)
        
        let sortByAccuracyAction = UIAlertAction(title: "By Accuracy", style: .default) { (action) in
            self.sortItems(by: .accuracy)
        }
        alartController.addAction(sortByAccuracyAction)
        
        let sortBydateAction = UIAlertAction(title: "By Date", style: .default) { (action) in
            self.sortItems(by: .date)
        }
        alartController.addAction(sortBydateAction)
        
        let sortByScoreAction = UIAlertAction(title: "By Score", style: .default) { (action) in
            self.sortItems(by: .score)
        }
        alartController.addAction(sortByScoreAction)
        
        alartController.popoverPresentationController?.sourceView = sender as? UIView
        present(alartController, animated: true, completion: nil)
    }
    
    enum SortItemsWays {
        case time, accuracy, date, score
    }
    
    func sortItems(by: SortItemsWays) {
        scoresView.scoreCollection.remove(at: 0)
        
        switch by {
        case .time:
            let sortedItmes = scoresView.scoreCollection.sorted { (firstItem, secondItem) -> Bool in
                return Double(firstItem.timePassed)! > Double(secondItem.timePassed)!
            }
            scoresView.scoreCollection = sortedItmes
        case .accuracy:
            let sortedItmes = scoresView.scoreCollection.sorted { (firstItem, secondItem) -> Bool in
                return firstItem.correctLetters*100/firstItem.tappedLatters > secondItem.correctLetters*100/secondItem.tappedLatters
            }
            scoresView.scoreCollection = sortedItmes
        case .date:
            let sortedItmes = scoresView.scoreCollection.sorted { (firstItem, secondItem) -> Bool in
                return firstItem.dateInt < secondItem.dateInt
            }
            scoresView.scoreCollection = sortedItmes
        case .score:
            let sortedItems = scoresView.scoreCollection.sorted { (firstItem, secondItem) -> Bool in
                return firstItem.score > secondItem.score
            }
            scoresView.scoreCollection = sortedItems
        }
        
        let rowFirstCell = Score.init("0", "0", "0", true, "Mary Had A Little lamb", "Taken Date")
        scoresView.scoreCollection.insert(rowFirstCell, at: 0)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View") as! scoresView
        self.navigationController!.pushViewController(viewController, animated: false)
    }
    
}
