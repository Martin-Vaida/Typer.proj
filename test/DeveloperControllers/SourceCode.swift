//
//  SourceCode.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/18.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation

struct SourceCode {
    static let MenuViewController = """
//
//  MenuViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/9.
//  Copyright © 2019 Vaida. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController:UIViewController {
    
@IBAction func unwindToMenu(segue:UIStoryboardSegue) {
        
}
    
static var studentsMode = false
static var forceQuite = false
}

"""
    
    static let scoresView = """
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
            let rowFirstCell = Score.init(0, 0, "0", true, .maryHadALittleLamb)
            scoresView.scoreCollection.insert(rowFirstCell, at: 0)
            scoresViewHasSet = true
        }
        
        for _ in 1...scoresView.scoreCollection.count {
            isPickerHidden.append(false)
        }
        
        for i in 0...scoresView.scoreCollection.count-1{
            scoresView.scoreCollection[i].index = String(i)
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
        
        if MenuViewController.studentsMode {
            cell.isHidden = false
            cell.scoreLabel.text = score.calculateScore()
        } else {
            cell.scoreLabel.isHidden = true
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
        
        let rowFirstCell = Score.init(0, 0, "0", true, .maryHadALittleLamb)
        scoresView.scoreCollection.insert(rowFirstCell, at: 0)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View") as! scoresView
        self.navigationController!.pushViewController(viewController, animated: false)
    }
    
}

"""
    static let Score = """
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
    var index = ""
    var firstRow:Bool
    var passageChoice:PassageChoice
    var dateInt = 0
    var score = 0  //change to 0
    
    enum PassageChoice {
    case maryHadALittleLamb
    }
    
    init(_ correctLetters:Int, _ tappedLetters:Int, _ timePassed:String, _ firstRow:Bool, _ passageChoice:PassageChoice) {
    self.correctLetters = correctLetters
    self.tappedLatters = tappedLetters
    self.timePassed = timePassed
    self.firstRow = firstRow
    self.passageChoice = passageChoice
    }
    
    func timeDescription() -> String {
    return "Time: \\(timePassed) seconds"
    }
    
    func accuracyRateDescreption() -> String {
    return "Accuracy Rate: \\(correctLetters*100/tappedLatters)%"
    }
    
    func accuracyDescription() -> String {
    if !firstRow {
    return "Accuracy: \\(correctLetters)/\\(tappedLatters)"
    } else {
    return " "
    }
    }
    
    func dateDescription() -> String {
    dateFomatter.dateStyle = .full
    dateFomatter.timeStyle = .medium
    
    dateFomatter.locale = Locale(identifier: "zh_CN")
    
    return "Taken Date: \\(dateFomatter.string(from: Date()))"
    }
    
    func getDateInt() {
    dateFomatter.dateStyle = .short
    dateFomatter.timeStyle = .medium
    dateFomatter.locale = Locale(identifier: "zh_CN")
    
    let str = dateFomatter.string(from: Date())
    var strArray:[String] = []
    
    for i in str {
    if i == "上" {
    continue
    } else if i == "下" {
    continue
    } else if i == "午" {
    continue
    } else {
    strArray.append(String(i))
    }
    }
    
    var tempIntString = ""
    var used = false
    for i in strArray {
    if Int(String(i)) != nil {
    tempIntString += String(i)
    
    if i != strArray[strArray.count-1] {
    continue
    }
    }
    
    if i == "/" && tempIntString.count == 4 {
    if Int(tempIntString)! % 4 == 0 {
    dateInt += Int(tempIntString)!*366*24*60*60
    } else {
    dateInt += Int(tempIntString)!*365*24*60*60
    }
    tempIntString = ""
    } else if i == "/" {
    guard Int(tempIntString)! != 1,
    Int(tempIntString)! != 3,
    Int(tempIntString)! != 5,
    Int(tempIntString)! != 7,
    Int(tempIntString)! != 8,
    Int(tempIntString)! != 10,
    Int(tempIntString)! != 12 else {
    dateInt += Int(tempIntString)!*30*24*60*60
    tempIntString = ""
    continue
    }
    dateInt += Int(tempIntString)!*31*24*60*60
    
    tempIntString = ""
    } else if i == " " {
    dateInt += Int(tempIntString)!*24*60*60
    tempIntString = ""
    } else if i == ":" && !used {
    used = true
    dateInt += Int(tempIntString)!*60*60
    tempIntString = ""
    } else if i == ":" {
    dateInt += Int(tempIntString)!*60
    tempIntString = ""
    } else {
    dateInt += Int(tempIntString)!
    }
    }
    }
    
    func timeDescriptionShort() -> String {
    if !firstRow {
    return String(timePassed)
    } else {
    return "Duration"
    }
    }
    
    func accuracyRateDescriptionShort(_ installed:Bool) -> String {
    guard installed else {
    return " "
    }
    
    if !firstRow {
    return "\\(correctLetters*100/tappedLatters)%"
    } else {
    return "Accuracy Rate"
    }
    }
    
    func dateDescriptionShort() -> String {
    if !firstRow {
    dateFomatter.dateStyle = .short
    dateFomatter.timeStyle = .none
    
    dateFomatter.locale = Locale(identifier: "zh_CN")
    
    return String(dateFomatter.string(from: Date()))
    } else {
    return "Date"
    }
    }
    
    func indexDescription(_ index:Int) -> String {
    if !firstRow {
    return String(index)
    } else {
    return " "
    }
    }
    
    func getPassageName() -> String {
    switch passageChoice {
    case .maryHadALittleLamb:
    return "Passage: Mary Had A Little lamb"
    }
    }
    
    func calculateScore() -> String {
    if firstRow {
    return "Score"
    } else {
    guard Double(timePassed) != nil else { return "Incompleted" }
    guard Double(timePassed)! >= 60.0 else {
    score = 0
    return "Incompleted"
    }
    score = 60*correctLetters/Int(Double(timePassed)!)
    return "\\(score)"
    }
    }
    
    }

"""
    static let scoresViewCell = """
//
//  scoresViewCell.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/11.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class scoresViewCell:UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var durationlabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var passageLabel: UILabel!
    @IBOutlet weak var accuracyNumberLabel: UILabel!
}

"""
    static let ChoosePassageController = """
//
//  ChoosePassageController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/9.
//  Copyright © 2019 Vaida. All rights reserved.
//

import Foundation
import UIKit

class ChoosePassageController:UITableViewController {
    
    @IBAction func unwindToChoosePassage(segue:UIStoryboardSegue) {
        guard segue.identifier == "MarryHadALittleLambReturn" else { return }
    }
}

"""
    static let ScoreViewController = """
//
//  ScoreViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/11.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class ScoreViewController:UITableViewController {
    static var score:Score?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScore()
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var accuracyLabelOne: UILabel!
    @IBOutlet weak var accuracyLabelTwo: UILabel!
    @IBOutlet weak var takenTimeLabel: UILabel!
    
    func updateScore() {
        guard ScoreViewController.score?.timeDescription() != nil,
            ScoreViewController.score?.accuracyRateDescreption() != nil,
            ScoreViewController.score?.accuracyDescription() != nil,
            ScoreViewController.score?.dateDescription() != nil else {
                defaultScore()
                return
        }
        
        timeLabel.text = ScoreViewController.score!.timeDescription()
        accuracyLabelOne.text = ScoreViewController.score!.accuracyRateDescreption()
        accuracyLabelTwo.text = ScoreViewController.score!.accuracyDescription()
        takenTimeLabel.text = ScoreViewController.score!.dateDescription()
        ScoreViewController.score!.getDateInt()
        
        scoresView.scoreCollection.append(ScoreViewController.score!)
    }
    
    func defaultScore() {
        timeLabel.text = "nil"
        accuracyLabelOne.text = "nil"
        accuracyLabelTwo.text = "nil"
        takenTimeLabel.text = "nil"
    }
}


"""
    static let MasterViewController = """
//
//  masterViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/13.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MasterViewControllerCell") as? MasterViewControllerCell else {
            fatalError("Could not dequeue a cell")
        }
        
        switch indexPath.section {
        case 0:
            cell.label.text = "Configurations"
            cell.leftImage.image = UIImage(named: "Settings")
        case 1:
            cell.label.text = "Statistics"
            cell.leftImage.image = UIImage(named: "Statistics")
        case 2:
            cell.label.text = "About Developers"
            cell.leftImage.image = UIImage(named: "Developers")
        default:
            break
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                if indexPath.section == 0 {
                    controller.enableColorMix = true
                }
                
                if indexPath.section == 1 {
                    controller.toStatisticsBool = true
                }
                
                if indexPath.section == 2 {
                    controller.enableSourceCode = true
                }
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}
"""
    static let MasterViewControllerCell = """
//
//  MasterViewControllerCell.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/13.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class MasterViewControllerCell:UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var leftImage: UIImageView!
    
}
"""
    static let DetailViewController = """
//
//  DetailViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/14.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController:UIViewController {
    
    @IBOutlet weak var colorMixView: UIStackView!
    @IBOutlet weak var colorMixImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var studentsModeNotification: UILabel!
    @IBOutlet weak var studentsModeBakcground: UIImageView!
    @IBOutlet weak var studentsModeLabel: UIButton!
    @IBOutlet weak var studentsModeSwitch: UISwitch!
    @IBOutlet weak var forceQuiteBackground: UIImageView!
    @IBOutlet weak var forceQuiteLabel: UIButton!
    @IBOutlet weak var forceQuiteSwitch: UISwitch!
    @IBOutlet weak var developerLabel: UIButton!
    @IBOutlet weak var showSourceCodeLabel: UIButton!
    @IBOutlet weak var showSourceCodeBackground: UIImageView!
    
    
    
    static var target:Target = .currentLabel
    
    enum Target {
        case currentLabel, currentLine, unusedLabel, unusedLine
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTableView()
        enableSourceCodeß()
        toStatistics()
        
        studentsModeSwitch.isOn = MenuViewController.studentsMode
        forceQuiteSwitch.isOn = MenuViewController.forceQuite
    }
    
    var enableColorMix = false {
        didSet {
            enableTableView()
        }
    }
    
    var enableSourceCode = false {
        didSet {
            enableSourceCodeß()
        }
    }
    
    func enableTableView() {
        if let tabelViewß = colorMixView {
            tabelViewß.isHidden = !enableColorMix
        }
        if let colorMixImageViewß = colorMixImageView {
            colorMixImageViewß.isHidden = !enableColorMix
        }
        if let labelß = label {
            labelß.isHidden = !enableColorMix
        }
        if let label = studentsModeNotification {
            label.isHidden = !enableColorMix
            label.text = "Notice: This is a mode designed for students in NFLSXL."
        }
        if let bg = studentsModeBakcground {
            bg.isHidden = !enableColorMix
        }
        if let label = studentsModeLabel {
            label.isHidden = !enableColorMix
        }
        if let switchß = studentsModeSwitch {
            switchß.isHidden = !enableColorMix
        }
        if let bg = forceQuiteBackground {
            if enableColorMix {
                bg.isHidden = !MenuViewController.studentsMode
            } else {
                bg.isHidden = true
            }
        }
        if let label = forceQuiteLabel {
            if enableColorMix {
                label.isHidden = !MenuViewController.studentsMode
            } else {
                label.isHidden = true
            }
        }
        if let switchß = forceQuiteSwitch {
            if enableColorMix {
                switchß.isHidden = !MenuViewController.studentsMode
            } else {
                switchß.isHidden = true
            }
        }
    }
    
    func enableSourceCodeß() {
        if let label = developerLabel {
            label.isHidden = !enableSourceCode
        }
        if let bg = showSourceCodeBackground {
            bg.isHidden = !enableSourceCode
        }
        if let label = showSourceCodeLabel {
            label.isHidden = !enableSourceCode
        }
    }
    
    var toStatisticsBool:Bool = false {
        didSet {
            toStatistics()
        }
    }
    
    func toStatistics() {
        guard toStatisticsBool else { return }
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Statistics") as! StatisticsViewController
        viewController.navigationItem.title = "Statistics"
        self.navigationController!.pushViewController(viewController, animated: false)
    }
    
    @IBAction func studentsModeSwitch(_ sender: Any) {
        MenuViewController.studentsMode = studentsModeSwitch.isOn
        
        if let bg = forceQuiteBackground {
            bg.isHidden = !MenuViewController.studentsMode
        }
        if let label = forceQuiteLabel {
            label.isHidden = !MenuViewController.studentsMode
        }
        if let switchß = forceQuiteSwitch {
            switchß.isHidden = !MenuViewController.studentsMode
        }
        
        forceQuiteSwitch.isOn = false
        MenuViewController.forceQuite = false
    }
    
    @IBAction func forceQuiteButton(_ sender: Any) {
        MenuViewController.forceQuite = forceQuiteSwitch.isOn
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCurrentLabelColorMixView" {
            DetailViewController.target = .currentLabel
        } else if segue.identifier == "ToCurrentLineColorMixView" {
            DetailViewController.target = .currentLine
        } else if segue.identifier == "ToUnusedLabelColorMixView" {
            DetailViewController.target = .unusedLabel
        } else if segue.identifier == "ToUnusedLineColorMixView" {
            DetailViewController.target = .unusedLine
        }
        
    }
}

"""
    static let ColorMixViewController = """
//
//  colorMixViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/14.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class colorMixViewController:UITableViewController {
    
    var red:CGFloat = 0.5
    var yellow:CGFloat = 0.5
    var blue:CGFloat = 0.5
    var black:CGFloat = 0.5
    
    let currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    let currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    let unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    let unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch DetailViewController.target {
        case .currentLabel:
            sampleLabel.text = "Editing: Current Label"
            redSlider.value = 0.5
            yellowSlider.value = 0.5
            blueSlider.value = 0.5
            blackSlider.value = 1
            
        case .currentLine:
            sampleLabel.text = "Editing: Current Line"
            redSlider.value = 0
            yellowSlider.value = 0
            blueSlider.value = 0
            blackSlider.value = 1
        case .unusedLabel:
            sampleLabel.text = "Editing: Unused Label"
            redSlider.value = 0
            yellowSlider.value = 0
            blueSlider.value = 0
            blackSlider.value = 0.2
        case .unusedLine:
            sampleLabel.text = "Editing: Unsed Line"
            redSlider.value = 0
            yellowSlider.value = 0
            blueSlider.value = 0
            blackSlider.value = 0.2
        }
        
        updateColor()
        
    }
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var yellowSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var blackSlider: UISlider!
    
    @IBOutlet weak var sampleLabel: UILabel!
    
    @IBAction func redSliderChanged(_ sender: Any) {
        updateColor()
    }
    
    @IBAction func yellowSliderChanged(_ sender: Any) {
        updateColor()
    }
    
    @IBAction func blueSliderChanged(_ sender: Any) {
        updateColor()
    }
    
    @IBAction func blackSliderChanged(_ sender: Any) {
        updateColor()
    }
    
    func updateColor() {
        red = CGFloat(redSlider.value)
        yellow = CGFloat(yellowSlider.value)
        blue = CGFloat(blueSlider.value)
        black = CGFloat(blackSlider.value)
        sampleLabel.textColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        switch DetailViewController.target {
        case .currentLabel:
            MarryHadALittleLambController.currentLabelColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
        case .currentLine:
            MarryHadALittleLambController.currentLineColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
        case .unusedLabel:
            MarryHadALittleLambController.unusedLabelColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
        case .unusedLine:
            MarryHadALittleLambController.unusedLineColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
            
        }
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        switch DetailViewController.target {
        case .currentLabel:
            let alert = UIAlertController(title: "Reset?", message: "Are you sure? \n The color of current label will be set to default", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                self.redSlider.value = 0.5
                self.yellowSlider.value = 0.5
                self.blueSlider.value = 0.5
                self.blackSlider.value = 1
            }
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        case .currentLine:
            let alert = UIAlertController(title: "Reset?", message: "Are you sure? \n The color of current line will be set to default", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                self.redSlider.value = 0
                self.yellowSlider.value = 0
                self.blueSlider.value = 0
                self.blackSlider.value = 1
            }
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        case .unusedLabel:
            let alert = UIAlertController(title: "Reset?", message: "Are you sure? \n The color of unused label will be set to default", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                self.redSlider.value = 0
                self.yellowSlider.value = 0
                self.blueSlider.value = 0
                self.blackSlider.value = 0.2
            }
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        case .unusedLine:
            let alert = UIAlertController(title: "Reset?", message: "Are you sure? \n The color of unused line will be set to default", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
                self.redSlider.value = 0
                self.yellowSlider.value = 0
                self.blueSlider.value = 0
                self.blackSlider.value = 0.2
            }
            alert.addAction(confirmAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        updateColor()
    }
    
}

"""
    static let StatisticsViewController = """
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
    let contents = NSAttributedString(string: "\\(average)%", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
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
    let contentsß = NSAttributedString(string: "\\(heighest)%", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
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
    let contentså = NSAttributedString(string: "\\(lowest)%", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
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
    let contentsœ = NSAttributedString(string: "\\(score)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    let messageœ = NSMutableAttributedString(attributedString: titleœ)
    messageœ.append(contentsœ)
    averageScoreLabel.attributedText = messageœ
    }
    
    func setup() {
    scoreCollectionß = scoresView.scoreCollection
    
    scoreCollectionß.append(Score(100,100,"100",true, .maryHadALittleLamb))
    scoreCollectionß.append(Score(50,100,"100",false, .maryHadALittleLamb))
    scoreCollectionß.append(Score(100,100,"100",false, .maryHadALittleLamb))
    scoreCollectionß.append(Score(100,100,"10",false, .maryHadALittleLamb))
    
    guard scoreCollectionß.count >= 2 else { return }
    scoreCollectionß.remove(at: 0)
    
    for i in 0...scoreCollectionß.count-1 {
    if Double(scoreCollectionß[i].timePassed)! < 60.0 {
    scoreCollectionß.remove(at: i)
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
    xAxisArray.append("\\(i)")
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
    xAxisArray.append("\\(i)")
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

"""
    static let maryHadALittlelambController = """
    //
    //  MarryHadALittleLambController.swift
    //  Typer.proj
    //
    //  Created by Vaida on 2019/5/9.
    //  Copyright © 2019 Vaida. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    class MarryHadALittleLambController:UITableViewController {
    
    static var currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    static var currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static var unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    static var unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var timer:Timer?
    var timeCounter = 0.0
    var timePassed = ""
    
    var timeTappedBool = false
    var accuracyTappedBool = false
    
    var tappedLetersInAll = -1
    var correctLettersInAll = 0
    
    var labelArray:[UILabel] = []
    var lineArray:[UITextField] = []
    
    var correctLettersArray = [Int](repeatElement(0, count: 15))
    var tappedLettersArray = [Int](repeatElement(0, count: 15))
    
    override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    self.navigationItem.title = "Mary Had A Little Lamb"
    
    }
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    @IBOutlet weak var labelSix: UILabel!
    @IBOutlet weak var labelSeven: UILabel!
    @IBOutlet weak var labelEight: UILabel!
    @IBOutlet weak var labelNine: UILabel!
    @IBOutlet weak var labelTen: UILabel!
    @IBOutlet weak var labelEleven: UILabel!
    @IBOutlet weak var labelTwelve: UILabel!
    @IBOutlet weak var labelThirteen: UILabel!
    @IBOutlet weak var labelFourteen: UILabel!
    @IBOutlet weak var labelFifteen: UILabel!
    
    @IBOutlet weak var lineOne: UITextField!
    @IBOutlet weak var lineTow: UITextField!
    @IBOutlet weak var lineThree: UITextField!
    @IBOutlet weak var lineFour: UITextField!
    @IBOutlet weak var lineFive: UITextField!
    @IBOutlet weak var lineSix: UITextField!
    @IBOutlet weak var lineSeven: UITextField!
    @IBOutlet weak var lineEight: UITextField!
    @IBOutlet weak var lineNine: UITextField!
    @IBOutlet weak var lineTen: UITextField!
    @IBOutlet weak var lineEleven: UITextField!
    @IBOutlet weak var lineTwelve: UITextField!
    @IBOutlet weak var lineThirteen: UITextField!
    @IBOutlet weak var lineFourteen: UITextField!
    @IBOutlet weak var lineFifteen: UITextField!
    
    @IBOutlet weak var timeLabel: UIBarButtonItem!
    @IBOutlet weak var accuracylabel: UIBarButtonItem!
    
    
    //define texts
    func setup() {
    labelOne.text = "Mary had a little lamb, little lamb, little lamb,"
    labelTwo.text = "Mary had a little lamb, its fleece was white as snow."
    labelThree.text = "And everywhere that Mary went, Mary went, Mary went,"
    labelFour.text = "And everywhere that Mary went, the lamb was sure to go."
    labelFive.text = "It followed her to school one day, school one day, school one day,"
    labelSix.text = "It followed her to school one day, which was against the rules."
    labelSeven.text = "It made the children laugh and play, laugh and play, laugh and play,"
    labelEight.text = "It made the children laugh and play to see a lamb at school."
    labelNine.text = "And so the teacher turned it out, turned it out, turned it out,"
    labelTen.text = "And so the teacher turned it out, but still it lingered near, And waited patiently about"
    labelEleven.text = "And waited patiently about till Mary did appear."
    labelTwelve.text = "Why does the lamb love Mary so? Love Mary so? Love Mary so?"
    labelThirteen.text = "Why does the lamb love Mary so, the eager children cry."
    labelFourteen.text = "Why, Mary loves the lamb, you know. The lamb, you know, the lamb, you know"
    labelFifteen.text = "Why, Mary loves the lamb, you know, the teacher did reply."
    
    lineOne.text = " "
    
    //cancel auto correcting
    lineOne.autocorrectionType = .no
    lineTow.autocorrectionType = .no
    lineThree.autocorrectionType = .no
    lineFour.autocorrectionType = .no
    lineFive.autocorrectionType = .no
    lineSix.autocorrectionType = .no
    lineSeven.autocorrectionType = .no
    lineEight.autocorrectionType = .no
    lineNine.autocorrectionType = .no
    lineTen.autocorrectionType = .no
    lineEleven.autocorrectionType = .no
    lineTwelve.autocorrectionType = .no
    lineThirteen.autocorrectionType = .no
    lineFourteen.autocorrectionType = .no
    lineFifteen.autocorrectionType = .no
    
    //Define labelArray
    labelArray.append(labelOne)
    labelArray.append(labelTwo)
    labelArray.append(labelThree)
    labelArray.append(labelFour)
    labelArray.append(labelFive)
    labelArray.append(labelSix)
    labelArray.append(labelSeven)
    labelArray.append(labelEight)
    labelArray.append(labelNine)
    labelArray.append(labelTen)
    labelArray.append(labelEleven)
    labelArray.append(labelTwelve)
    labelArray.append(labelThirteen)
    labelArray.append(labelFourteen)
    labelArray.append(labelFifteen)
    
    //Define lineArray
    lineArray.append(lineOne)
    lineArray.append(lineTow)
    lineArray.append(lineThree)
    lineArray.append(lineFour)
    lineArray.append(lineFive)
    lineArray.append(lineSix)
    lineArray.append(lineSeven)
    lineArray.append(lineEight)
    lineArray.append(lineNine)
    lineArray.append(lineTen)
    lineArray.append(lineEleven)
    lineArray.append(lineTwelve)
    lineArray.append(lineThirteen)
    lineArray.append(lineFourteen)
    lineArray.append(lineFifteen)
    
    //make colors of used labels gray
    for i in labelArray {
    i.textColor = MarryHadALittleLambController.unusedLabelColor
    }
    }
    
    
    //Timer
    
    func startTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
    self.timeCounter += 0.1
    guard self.timer != nil else { return }
    
    let str = String(self.timeCounter)
    var array:[String] = []
    self.timePassed = ""
    
    for i in str {
    array.append(String(i))
    }
    
    for i in 0...array.count-1 {
    self.timePassed += array[i]
    
    if array[i] == "." {
    self.timePassed += array[i+1]
    break
    }
    }
    
    self.timeLabel.title = "Time: \\(String(self.timePassed))"
    
    if self.timeTappedBool {
    self.navigationItem.title = self.timeLabel.title
    self.timeLabel.title = "Time"
    }
    if !self.timeTappedBool && !self.accuracyTappedBool {
    self.navigationItem.title = "Mary Had A Little Lamb"
    }
    
    if MenuViewController.forceQuite {
    if self.timeCounter >= 60.0 {
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    
    ScoreViewController.score = Score(correctLetters, tappedLetters, self.timePassed, false, .maryHadALittleLamb)
    
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View_Single") as! ScoreViewController
    self.navigationController!.pushViewController(viewController, animated: true)
    }
    }
    })
    }
    
    func stopTimer() {
    if timer != nil {
    timer!.invalidate() //销毁timer
    timer = nil
    }
    }
    
    
    
    func updateAccuracyLabel() {
    if accuracyTappedBool {
    self.navigationItem.title = "Correct Letters: \\(correctLettersInAll), Tapped Letters: \\(tappedLetersInAll), Accuracy Rate: \\(correctLettersInAll*100/tappedLetersInAll)%"
    self.accuracylabel.title = "Accuracy Rate"
    } else {
    self.accuracylabel.title = "Accuracy: \\(correctLettersInAll*100/tappedLetersInAll)%"
    }
    }
    
    //viewcontrollers
    
    @IBAction func lineOneBegin(_ sender: Any) {
    startTimer()
    
    labelOne.textColor = MarryHadALittleLambController.currentLabelColor
    lineOne.textColor = MarryHadALittleLambController.currentLineColor
    }
    
    //When User changed Valve...
    func updateValue(line:Int) {
    
    if lineArray[line-1].text?.count == labelArray[line-1].text!.count+1 {
    guard line != 15 else {
    stopTimer()
    return
    }
    
    lineArray[line-1].resignFirstResponder()
    lineArray[line].text = " "
    lineArray[line].becomeFirstResponder()
    
    labelArray[line-1].textColor = MarryHadALittleLambController.unusedLabelColor
    labelArray[line].textColor = MarryHadALittleLambController.currentLabelColor
    
    lineArray[line-1].textColor = MarryHadALittleLambController.unusedLineColor
    lineArray[line].textColor = MarryHadALittleLambController.currentLineColor
    }
    
    guard lineArray[line-1].text != nil else { return }
    
    if lineArray[line-1].text!.count == 0 {
    if line == 1 {
    lineArray[line-1].text = " "
    } else {
    lineArray[line-1].resignFirstResponder()
    lineArray[line-2].becomeFirstResponder()
    
    labelArray[line-1].textColor = MarryHadALittleLambController.unusedLabelColor
    labelArray[line-2].textColor = MarryHadALittleLambController.currentLabelColor
    
    lineArray[line-1].textColor = MarryHadALittleLambController.unusedLineColor
    lineArray[line-2].textColor = MarryHadALittleLambController.currentLineColor
    }
    }
    
    guard labelArray[line-1].text != nil else { return }
    guard lineArray[line-1].text!.count >= 2 else { return }
    tappedLetersInAll = lineArray[line-1].text!.count
    
    var tempCorrectLetterCount = 0
    tempCorrectLetterCount = 0
    
    for i in 1...lineArray[line-1].text!.count-1 {
    let inputLetter = lineArray[line-1].text![lineArray[line-1].text!.index(lineArray[line-1].text!.startIndex, offsetBy: i)]
    let origenalLetter = labelArray[line-1].text![labelArray[line-1].text!.index(labelArray[line-1].text!.startIndex, offsetBy: i-1)]
    
    if inputLetter == origenalLetter {
    tempCorrectLetterCount += 1
    } else {
    lineArray[line-1].text!.remove(at: lineArray[line-1].text!.index(lineArray[line-1].text!.startIndex, offsetBy: i))
    lineArray[line-1].text!.insert("_", at: lineArray[line-1].text!.index(lineArray[line-1].text!.startIndex, offsetBy: i))
    }
    }
    
    correctLettersArray[line-1] = tempCorrectLetterCount
    tappedLettersArray[line-1] = lineArray[line-1].text!.count - 1
    
    correctLettersInAll = 0
    for i in correctLettersArray {
    correctLettersInAll += i
    }
    
    tappedLetersInAll = 0
    for i in tappedLettersArray {
    tappedLetersInAll += i
    }
    
    updateAccuracyLabel()
    }
    
    //User is editing lineOne
    @IBAction func lineOneChanged(_ sender: Any) {
    updateValue(line: 1)
    }
    
    @IBAction func lineTwoChaged(_ sender: Any) {
    updateValue(line: 2)
    }
    
    @IBAction func lineThreeChanged(_ sender: Any) {
    updateValue(line: 3)
    }
    
    @IBAction func lineFourChanged(_ sender: Any) {
    updateValue(line: 4)
    }
    
    @IBAction func lineFiveChanged(_ sender: Any) {
    updateValue(line: 5)
    }
    
    @IBAction func lineSixChanged(_ sender: Any) {
    updateValue(line: 6)
    }
    
    @IBAction func lineSevenChanged(_ sender: Any) {
    updateValue(line: 7)
    }
    
    @IBAction func lineEightChanged(_ sender: Any) {
    updateValue(line: 8)
    }
    
    @IBAction func lineNineChanged(_ sender: Any) {
    updateValue(line: 9)
    }
    
    @IBAction func lineTenChanged(_ sender: Any) {
    updateValue(line: 10)
    }
    
    @IBAction func lineElevenChanged(_ sender: Any) {
    updateValue(line: 11)
    }
    
    @IBAction func lineTwelveChanged(_ sender: Any) {
    updateValue(line: 12)
    }
    
    @IBAction func lineThirteenChanged(_ sender: Any) {
    updateValue(line: 13)
    }
    
    @IBAction func lineFourteenChanged(_ sender: Any) {
    updateValue(line:14)
    }
    
    @IBAction func lineFifteenChanged(_ sender: Any) {
    updateValue(line: 15)
    }
    
    
    //Navigation Item
    
    @IBAction func timetapped(_ sender: Any) {
    guard timeLabel.title != nil else { return }
    timeTappedBool = !timeTappedBool
    }
    
    @IBAction func accuracyTapped(_ sender: Any) {
    guard accuracylabel.title != nil else { return }
    accuracyTappedBool = !accuracyTappedBool
    updateAccuracyLabel()
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
    stopTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(true)
    stopTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    guard segue.identifier == "ResultsSegue" else { return }
    
    let correctLetters = correctLettersInAll
    let tappedLetters = tappedLetersInAll
    
    ScoreViewController.score = Score(correctLetters, tappedLetters, timePassed, false, .maryHadALittleLamb)
    }
    }

"""
    
    
}
