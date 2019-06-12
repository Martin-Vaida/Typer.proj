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
    
    @IBOutlet weak var nameLabel: UIButton!
    static var studentsMode = false
    static var forceQuite = false
    static var userName = "user"
    static var developerMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorMixViewController.colorArray.append(UIColorß("0.5", "0.5", "0.5", "1"))
        colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "1"))
        colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "0.2"))
        colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "0.2"))
        
        if Score.load() != nil {
            scoresView.scoreCollection = Score.load()!
            scoresViewHasSet = true
        }
        
        if UIColorß.load() != nil {
            colorMixViewController.colorArray = UIColorß.load()!
        }
        
        if StudentsMode.load() != nil {
            MenuViewController.studentsMode = StudentsMode.load()!.isOn
            MenuViewController.forceQuite = StudentsMode.load()!.autoStop
        }
        
        if Account.load() != nil {
            MenuViewController.userName = Account.load()!.name
            MenuViewController.developerMode = Bool(Account.load()!.developerMode)!
        }
        
        nameLabel.setTitle(MenuViewController.userName, for: .normal)
        
    }
    
    @objc func back() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Menu_View") as! MenuViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
}

//All rights reserved.


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
    
    class Score:NSObject, NSCoding{
    var correctLetters:Int
    var tappedLatters:Int
    var correctLettersß:String {
    didSet {
    correctLetters = Int(correctLettersß)!
    }
    }
    var tappedLattersß:String {
    didSet {
    tappedLatters = Int(tappedLattersß)!
    }
    }
    let timePassed:String
    let dateFomatter = DateFormatter()
    var index = ""
    var firstRow:Bool
    var passageChoice:String
    var dateInt = 0
    var score = 0  //change to 0
    var takenDate = "?"
    var userName = "nil"
    
    enum PassageChoice {
    case maryHadALittleLamb
    }
    
    init(_ correctLetters:String, _ tappedLetters:String, _ timePassed:String, _ firstRow:Bool, _ passageChoice:String, _ takenDate: String, _ userName:String) {
    self.correctLettersß = correctLetters
    self.tappedLattersß = tappedLetters
    self.correctLetters = Int(correctLetters)!
    self.tappedLatters = Int(tappedLetters)!
    self.timePassed = timePassed
    self.firstRow = firstRow
    self.passageChoice = passageChoice
    self.takenDate = takenDate
    self.userName = userName
    }
    
    func timeDescription() -> String {
    return "Time: \\(timePassed) seconds"
    }
    
    func accuracyRateDescreption() -> String {
    return "Accuracy Rate: \\(correctLetters*100/tappedLatters)%"
    }
    
    func setupß() {
    correctLetters = Int(correctLettersß)!
    tappedLatters = Int(tappedLattersß)!
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
    
    func getUserName() -> String {
    if !firstRow {
    return "User Name: \\(userName)"
    } else {
    return "User Names"
    }
    }
    
    func accuracyRateDescriptionShort(_ installed:Bool) -> String {
    guard installed else {
    return " "
    }
    
    guard tappedLatters != 0 else { return "Accuracy Rate" }
    if !firstRow {
    return "\\(correctLetters*100/tappedLatters)%"
    } else {
    return "Accuracy Rate"
    }
    }
    
    func dateDescriptionShort() {
    if !firstRow {
    dateFomatter.dateStyle = .short
    dateFomatter.timeStyle = .none
    
    dateFomatter.locale = Locale(identifier: "zh_CN")
    
    takenDate = String(dateFomatter.string(from: Date()))
    } else {
    takenDate = "Date"
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
    return "Passage: \\(passageChoice)"
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
    
    
    
    //saving Data
    
    struct PropertyKey {
    static let correctLetters = "correctLetters"
    static let tappedLetters = "tappedletters"
    static let timePassed = "timePassed"
    static let firstRow = "forstRow"
    static let passageChoice = "passageChoice"
    static let takenDate = "takenDate"
    static let userName = "userName"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
    guard let timepassed = aDecoder.decodeObject(forKey: PropertyKey.timePassed) as? String,
    let passageChoice = aDecoder.decodeObject(forKey: PropertyKey.passageChoice) as? String,
    let correctLetters = aDecoder.decodeObject(forKey: PropertyKey.correctLetters) as? String,
    let tappedLetters = aDecoder.decodeObject(forKey: PropertyKey.tappedLetters) as? String,
    let takenDate = aDecoder.decodeObject(forKey: PropertyKey.takenDate) as? String,
    let userName = aDecoder.decodeObject(forKey: PropertyKey.userName) as? String else {
    return nil
    }
    
    let firstRow = aDecoder.decodeObject(forKey: PropertyKey.firstRow)
    
    self.init(correctLetters , tappedLetters , timepassed, (firstRow != nil), passageChoice, takenDate, userName)
    }
    
    func encode(with aCoder: NSCoder) {
    aCoder.encode(correctLettersß, forKey: PropertyKey.correctLetters)
    aCoder.encode(tappedLattersß, forKey: PropertyKey.tappedLetters)
    aCoder.encode(timePassed, forKey: PropertyKey.timePassed)
    aCoder.encode(firstRow, forKey: PropertyKey.firstRow)
    aCoder.encode(passageChoice, forKey: PropertyKey.passageChoice)
    aCoder.encode(takenDate, forKey: PropertyKey.takenDate)
    aCoder.encode(userName, forKey: PropertyKey.userName)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("save")
    
    static func load() -> [Score]? {
    print(Score.ArchiveURL.path)
    return NSKeyedUnarchiver.unarchiveObject(withFile: Score.ArchiveURL.path) as? [Score]
    }
    
    static func save(_ score: [Score]) {
    NSKeyedArchiver.archiveRootObject(score, toFile: Score.ArchiveURL.path)
    }
    }
    
    //All rights reserved.

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
    @IBOutlet weak var nameLabel: UILabel!
    
}

//All rights reserved.


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
    
    @IBOutlet weak var label: UIButton!
    
    @IBAction func unwindToChoosePassage(segue:UIStoryboardSegue) {
        guard segue.identifier == "MarryHadALittleLambReturn" else { return }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Support.width = Int(view.frame.width)
    }
    
    @IBAction func tappedOne(_ sender: Any) {
        storyViewController.scrips.removeAll()
        storyViewController.scrips.append("But why, some say, the moon, why choose this as our goal.")
        storyViewController.scrips.append("And they may as well ask, why climb the highest mountain,")
        storyViewController.scrips.append("why, 35 years ago, fly the Atlantic, why does Rice play Texas.")
        storyViewController.scrips.append("We choose to go to the moon, we choose to go to the moon, we choose to go to the moon.")
        storyViewController.scrips.append("In this decade and do the other things, not because they are easy, but because they are hard.")
        storyViewController.scrips.append("Because that goal will serve to organize, and measure the best, of our energies and skills.")
        storyViewController.scrips.append("Because that challenge is one, that we are willing to accept, one we are unwilling to postpone,")
        storyViewController.scrips.append("and one which we intend to win,")
        storyViewController.scrips.append("and the others, too.")
        storyViewController.passageName = "We choose to go to the moon"
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Story_View") as! storyViewController
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tappedTwo(_ sender: Any) {
        storyViewController.scrips.removeAll()
        storyViewController.scrips.append("Pumas are large, cat-like animals which are found in America.")
        storyViewController.scrips.append("When reports came into London Zoo that a wild puma had been spotted forty-five miles south of London, they were not taken seriously.")
        storyViewController.scrips.append("However, as the evidence be began to accumulate, experts from the Zoo felt obliged to investigate,")
        storyViewController.scrips.append("for the descriptions given by people who claimed to have seen the puma were extraordinarily similar.")
        storyViewController.scrips.append("The hunt for the puma began in a small village where a woman picking blackberries saw 'a large cat' only five yards away from her.")
        storyViewController.scrips.append("It immediately ran away when she saw it, and experts confirmed that a puma will not attack a human being unless it is cornered.")
        storyViewController.scrips.append("The search  proved difficult, for the puma was often observed  at one place in the morning and at another place twenty miles away in the evening.")
        storyViewController.scrips.append("Wherever it went, it left behind it a trail of dead deer and small animals like rabbits.")
        storyViewController.scrips.append("Paw prints were seen in a number of places and puma fur was found clinging to bushes.")
        storyViewController.scrips.append("Several people complained of 'cat-like noises' at night and a businessman on a fishing trip saw the puma up a tree.")
        storyViewController.scrips.append("The experts were now fully convinced that the animal was a puma, but where had it come from?")
        storyViewController.scrips.append("As no pumas had been reported missing from any zoo in the country, this one must have been in the possession of a private collector and some how managed to escape.")
        storyViewController.scrips.append("The hunt went on for several weeks, but the puma was not caught.")
        storyViewController.scrips.append("It is disturbing to think that a dangerous wild animal is still at large in the quiet countryside.")
        storyViewController.passageName = "New Concept English"
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Story_View") as! storyViewController
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tappedThree(_ sender: Any) {
        storyViewController.scrips.removeAll()
        storyViewController.scrips.append("Our vicar is always raising money for one cause or another, but he has never managed to get enough money to have the church clock repaired.")
        storyViewController.scrips.append("The big clock which used to strike the hours day and night was damaged many years ago and has been silent ever since.")
        storyViewController.scrips.append("One night, however, our vicar woke up with a start: the clock was striking the hours!")
        storyViewController.scrips.append("Looking at his watch, he saw that it was one o’clock, but the bell struck thirteen times before it stopped.")
        storyViewController.scrips.append("Armed with a torch, the vicar went up into the clock tower to see what was going on.")
        storyViewController.scrips.append("In the torchlight, he caught sight of a figure whom he immediately recognized as Bill Wilkins, our local grocer.")
        storyViewController.scrips.append("'Whatever are you doing up here Bill ?' asked the vicar in surprise.")
        storyViewController.scrips.append("' I'm trying to repair the bell,' answered Bill.' I've been coming up here night after night for weeks now. You see, I was hoping to give you a surprise.'")
        storyViewController.scrips.append("'You certainly did give me a surprise!' said the vicar. 'You've probably woken up everyone in the village as well. Still, I'm glad the bell is working again.'")
        storyViewController.scrips.append("'That's the trouble, vicar,' answered Bill. 'It's working all right, but I'm afraid that at one o'clock it will strike thirteen times and there's nothing I can do about it.'")
        storyViewController.scrips.append("'We'll get used to that Bill,' said the vicar. 'Thirteen is not as good as one but it's better than nothing. Now let's go downstairs and have a cup of tea.'")
        storyViewController.passageName = "Thirteen Equals One"
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Story_View") as! storyViewController
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    @IBAction func tappedFour(_ sender: Any) {
        storyViewController.scrips.removeAll()
        storyViewController.scrips.append("Some time ago, an interesting discovery was made by archaeologists on the Aegean island of kea.")
        storyViewController.scrips.append("An American team explored a temple which stands in an ancient city on the promontory of Ayia Irini.")
        storyViewController.scrips.append("The city at one time must have been prosperous, for it enjoyed a high level of civilization.")
        storyViewController.scrips.append("houses--often three storeys high--were built of stone.")
        storyViewController.scrips.append("They had large rooms with beautifully decorated walls.")
        storyViewController.scrips.append("The city was even equipped with a drainage system, for a great many clay pipes were found beneath the narrow streets.")
        storyViewController.scrips.append("The temple which the archaeologists explored was used as a place of worship from the fifteenth century B.C. until Roman times.")
        storyViewController.scrips.append("In the most sacred room of the temple, clay fragments of fifteen statues were found.")
        storyViewController.scrips.append("Each of these represented a goddess and had, at one time, been painted.")
        storyViewController.scrips.append("The body of one statue was found among remains dating from the fifteenth century B.C.")
        storyViewController.scrips.append("Its missing head happened to be among remains of the fifth century B.C.")
        storyViewController.scrips.append("This head must have been found in Classical times and carefully preserved.")
        storyViewController.scrips.append("It was very old and precious even then.")
        storyViewController.scrips.append("When the archaeologists reconstructed the fragments, they were amazed to find that the goddess turned out to be a very modern-looking woman.")
        storyViewController.scrips.append("She stood three feet high and her hands rested on her hip.")
        
        storyViewController.passageName = "An Unknown Goddess"
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Story_View") as! storyViewController
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    

}

/*
 storyViewController.scrips.removeAll()
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.scrips.append("<#T##newElement: String##String#>")
 storyViewController.passageName = ""
 */

//All rights reserved.


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
        self.navigationItem.setHidesBackButton(true, animated: false)
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
        ScoreViewController.score!.dateDescriptionShort()
        
        scoresView.scoreCollection.append(ScoreViewController.score!)
    }
    
    func defaultScore() {
        timeLabel.text = "nil"
        accuracyLabelOne.text = "nil"
        accuracyLabelTwo.text = "nil"
        takenTimeLabel.text = "nil"
    }
}

//All rights reserved.



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
        return 4
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
            cell.label.text = "Account"
            cell.leftImage.image = UIImage(named: "Account")
        case 3:
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
                    controller.toAccount = true
                }
                
                
                if indexPath.section == 3 {
                    controller.enableSourceCode = true
                }
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}

//All rights reserved.

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

//All rights reserved.
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
    
    var toAccount = false {
        didSet {
            toAccountView()
        }
    }
    
    func toAccountView() {
        guard toAccount else { return }
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Account_View") as! AccountViewController
        viewController.navigationItem.title = "Account"
        self.navigationController!.pushViewController(viewController, animated: false)
    }
    
    @IBAction func studentsModeSwitch(_ sender: Any) {
        MenuViewController.studentsMode = studentsModeSwitch.isOn
        
        let studentMode = StudentsMode(isOn: MenuViewController.studentsMode, autoStop: MenuViewController.forceQuite)
        print(studentMode)
        StudentsMode.save(studentMode)
        print(StudentsMode.load()!)
        
        if studentsModeSwitch.isOn {
            let alert = UIAlertController(title: "Notice", message: "Your incompleted tasks will no longer be shown in statistics.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(confirmAction)
            self.present(alert, animated: true, completion: nil)
        }
        
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
        let studentMode = StudentsMode(isOn: studentsModeSwitch.isOn, autoStop: forceQuiteSwitch.isOn)
        print(studentMode)
        StudentsMode.save(studentMode)
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


//All rights reserved.

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
    
    static var colorArray:[UIColorß] = []
    
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
        
        if colorMixViewController.colorArray.count == 0 {
            colorMixViewController.colorArray.append(UIColorß("0.5", "0.5", "0.5", "1"))
            colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "1"))
            colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "0.2"))
            colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "0.2"))
        }
        
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
            let color = UIColorß(String(Double(red)), String(Double(yellow)), String(Double(blue)), String(Double(black)))
            colorMixViewController.colorArray[0] = color
            
        case .currentLine:
            MarryHadALittleLambController.currentLineColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
            let color = UIColorß(String(Double(red)), String(Double(yellow)), String(Double(blue)), String(Double(black)))
            colorMixViewController.colorArray[1] = color
        case .unusedLabel:
            MarryHadALittleLambController.unusedLabelColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
            let color = UIColorß(String(Double(red)), String(Double(yellow)), String(Double(blue)), String(Double(black)))
            colorMixViewController.colorArray[2] = color
        case .unusedLine:
            MarryHadALittleLambController.unusedLineColor = UIColor(red: red, green: yellow, blue: blue, alpha: black)
            let color = UIColorß(String(Double(red)), String(Double(yellow)), String(Double(blue)), String(Double(black)))
            colorMixViewController.colorArray[3] = color
            
        }
        
        UIColorß.save(colorMixViewController.colorArray)
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

//All rights reserved.


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
    
    //All rights reserved.


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
            let rowFirstCell = Score.init("0", "0", "0", true, "Mary Had A Little lamb", "Taken Date", MenuViewController.userName)
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
        
        let rowFirstCell = Score.init("0", "0", "0", true, "Mary Had A Little lamb", "Taken Date", MenuViewController.userName)
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
        cell.nameLabel.text = score.getUserName()
        
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
        let largeCellHeihgt = CGFloat(176)
        
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
        
        let sortByNameAction = UIAlertAction(title: "By Name", style: .default) { (_) in
            self.sortItems(by: .name)
        }
        alartController.addAction(sortByNameAction)
        
        alartController.popoverPresentationController?.sourceView = sender as? UIView
        present(alartController, animated: true, completion: nil)
    }
    
    enum SortItemsWays {
        case time, accuracy, date, score, name
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
        case .name:
            let sortedItems = scoresView.scoreCollection.sorted { (firstItem, secondItem) -> Bool in
                return firstItem.userName > secondItem.userName
            }
            scoresView.scoreCollection = sortedItems
        }
        
        let rowFirstCell = Score.init("0", "0", "0", true, "Mary Had A Little lamb", "Taken Date", MenuViewController.userName)
        scoresView.scoreCollection.insert(rowFirstCell, at: 0)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View") as! scoresView
        self.navigationController!.pushViewController(viewController, animated: false)
    }
    
}

//All rights reserved.

"""
    static let maryHadALittlelambViewController = """
    //
    //  MaryHadALittleLambViewController.swift
    //  test
    //
    //  Created by Vaida on 2019/5/9.
    //  Copyright © 2019 Vaida. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    class MarryHadALittleLambController:UITableViewController {
    
    var lineCount = 15
    
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
    var tempCorrectLetters = [Character]()
    var tempTappedLetter = [Character]()
    
    override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    self.navigationItem.title = "Mary Had A Little Lamb"
    
    MarryHadALittleLambController.currentLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[0].red)!), green: CGFloat(Double(colorMixViewController.colorArray[0].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[0].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[0].alpha)!))
    MarryHadALittleLambController.currentLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[1].red)!), green: CGFloat(Double(colorMixViewController.colorArray[1].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[1].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[1].alpha)!))
    MarryHadALittleLambController.unusedLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[2].red)!), green: CGFloat(Double(colorMixViewController.colorArray[2].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[2].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[2].alpha)!))
    MarryHadALittleLambController.unusedLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[3].red)!), green: CGFloat(Double(colorMixViewController.colorArray[3].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[3].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[3].alpha)!))
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
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Mary Had A Little lamb", "", MenuViewController.userName)
    
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
    
    var tempCorrectLetterCount = 0
    
    //When User changed Valve...
    func updateValue(line:Int) {
    
    guard lineArray[line-1].text != nil else { return }
    guard lineArray[line-1].text!.count < labelArray[line-1].text!.count+2 else { return }
    
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
    
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    
    for i in lineArray[line-2].text! {
    tempTappedLetter.append(i)
    }
    for i in labelArray[line-2].text! {
    tempCorrectLetters.append(i)
    }
    for i in 0...tempTappedLetter.count-2 {
    if tempCorrectLetters[i] == tempTappedLetter[i+1] {
    tempCorrectLetterCount += 1
    }
    }
    }
    }
    
    guard labelArray[line-1].text != nil else { return }
    guard lineArray[line-1].text!.count >= 2 else { return }
    tappedLetersInAll = lineArray[line-1].text!.count
    
    
    
    if lineArray[line-1].text!.count > tempCorrectLetters.count {
    tempCorrectLetters.append(labelArray[line-1].text![(labelArray[line-1].text?.index(labelArray[line-1].text!.startIndex, offsetBy: tempCorrectLetters.count))!])
    tempTappedLetter.append(lineArray[line-1].text![lineArray[line-1].text!.index(before: lineArray[line-1].text!.endIndex)])
    
    if tempTappedLetter[tempTappedLetter.count-1] == tempCorrectLetters[tempCorrectLetters.count-1] {
    tempCorrectLetterCount += 1
    } else {
    lineArray[line-1].text!.removeLast()
    lineArray[line-1].text!.append("_")
    }
    
    } else {
    if tempCorrectLetters[tempCorrectLetters.count-1] == tempTappedLetter[tempTappedLetter.count-1] {
    tempCorrectLetterCount -= 1
    }
    
    tempCorrectLetters.remove(at: tempCorrectLetters.count-1)
    tempTappedLetter.remove(at: tempTappedLetter.count-1)
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
    
    if lineArray[line-1].text!.count == labelArray[line-1].text!.count+1 {
    guard line != lineCount else {
    stopTimer()
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Mary Had A Little lamb", "", MenuViewController.userName)
    
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View_Single") as! ScoreViewController
    self.navigationController!.pushViewController(viewController, animated: true)
    return
    }
    
    lineArray[line-1].resignFirstResponder()
    lineArray[line].text = " "
    lineArray[line].becomeFirstResponder()
    
    labelArray[line-1].textColor = MarryHadALittleLambController.unusedLabelColor
    labelArray[line].textColor = MarryHadALittleLambController.currentLabelColor
    
    lineArray[line-1].textColor = MarryHadALittleLambController.unusedLineColor
    lineArray[line].textColor = MarryHadALittleLambController.currentLineColor
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    return
    }
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
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), timePassed, false, "Mary Had A Little lamb", "", MenuViewController.userName)
    }
    }
    
    //All rights reserved.

"""
    static let support = """
//
//  Support.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/23.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class Support {
    static var width:Int = 100
    static var y:Int = 100
    
    static func setup() {
        
    }
}

extension CGRect {
    struct Point {
        var x:CGFloat = 0.0, y:CGFloat = 0.0
    }
    
    init(center: Point, size: CGSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: CGPoint(x: originX, y: originY), size: size)
    }
}

extension UIView {
    struct Content {
        static var labelText = "labelText"
    }
    
    static func makeView(x:Int, y:Int, labelText:String) -> UIView {
        let view = UIView(frame: CGRect(x: x, y: Support.y+y, width: Support.width-17, height: 88))
        let label = UILabel(frame: CGRect(x: 8, y: 0, width: Support.width-25, height: 44))
        let text = UITextField(frame: CGRect(x: 0, y: 44, width: Support.width-17, height: 44))
        label.text = labelText
        text.borderStyle = .roundedRect
        SetMutiBorderRoundingCorners(view, corner: 10)
        view.addSubview(label)
        view.addSubview(text)
        view.isOpaque = true
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        gameViewController.textArray.append(labelText)
        gameViewController.showTextArray.append(text)
        
        return view
    }
}

func SetMutiBorderRoundingCorners(_ view:UIView,corner:CGFloat) {
    let maskPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: [UIRectCorner.bottomLeft, UIRectCorner.topRight, UIRectCorner.bottomRight, UIRectCorner.topLeft], cornerRadii: CGSize(width: corner, height: corner))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = view.bounds
    maskLayer.path = maskPath.cgPath
    view.layer.mask = maskLayer
}

//All rights reserved.

"""
    static let StudentsMode = """
    //
    //  studentsMode.swift
    //  Typer.proj
    //
    //  Created by Vaida on 2019/5/20.
    //  Copyright © 2019 Martin_Vaida. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    class StudentsMode:NSObject, NSCoding {
    var isOn:Bool
    var autoStop:Bool
    var isOnß:String
    var autoStopß:String
    
    init(isOn:Bool, autoStop:Bool) {
    self.isOn = isOn
    self.autoStop = autoStop
    
    self.isOnß = String(isOn)
    self.autoStopß = String(autoStop)
    }
    
    struct PropertyKey {
    static let isOn = "isOn"
    static let autoStop = "autoStop"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
    guard let isOn = aDecoder.decodeObject(forKey: PropertyKey.isOn) as? String,
    let autoStop = aDecoder.decodeObject(forKey: PropertyKey.autoStop) as?String else {
    return nil
    }
    
    self.init(isOn:Bool(isOn)!, autoStop:Bool(autoStop)!)
    }
    
    func encode(with aCoder: NSCoder) {
    aCoder.encode(isOnß, forKey: PropertyKey.isOn)
    aCoder.encode(autoStopß, forKey: PropertyKey.autoStop)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("StudentsMode")
    
    static func load() -> StudentsMode? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: StudentsMode.ArchiveURL.path) as? StudentsMode
    }
    
    static func save(_ object: StudentsMode) {
    NSKeyedArchiver.archiveRootObject(object, toFile: StudentsMode.ArchiveURL.path)
    }
    
    override var description: String {
    return "isOn:\\(isOnß), autoStop:\\(autoStopß)"
    }
    }
    
    //All rights reserved.

"""
    static let UIColorß = """
//
//  UIColor.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/19.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class UIColorß: NSObject, NSCoding {
    var red:String
    var green:String
    var blue:String
    var alpha:String
    
    init(_ red:String, _ green:String, _ blue:String, _ alpha:String) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    struct PropertyKey {
        static let red = "red"
        static let green = "green"
        static let blue = "blue"
        static let alpha = "alpha"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let red = aDecoder.decodeObject(forKey: PropertyKey.red) as? String,
        let green = aDecoder.decodeObject(forKey: PropertyKey.green) as? String,
        let blue = aDecoder.decodeObject(forKey: PropertyKey.blue) as? String,
            let alpha = aDecoder.decodeObject(forKey: PropertyKey.alpha) as? String else {
                return nil
        }
        
        self.init(red, green, blue, alpha)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(red, forKey: PropertyKey.red)
        aCoder.encode(green, forKey: PropertyKey.green)
        aCoder.encode(blue, forKey: PropertyKey.blue)
        aCoder.encode(alpha, forKey: PropertyKey.alpha)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Color")
    
    static func load() -> [UIColorß]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: UIColorß.ArchiveURL.path) as? [UIColorß]
    }
    
    static func save(_ colors: [UIColorß]) {
        NSKeyedArchiver.archiveRootObject(colors, toFile: UIColorß.ArchiveURL.path)
    }
}

//All rights reserved.

"""
    static let AccountViewController = """
    //
    //  AccountViewController.swift
    //  Typer.proj
    //
    //  Created by Vaida on 2019/5/28.
    //  Copyright © 2019 Martin_Vaida. All rights reserved.
    //

    import Foundation
    import UIKit

    class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        botton.isOn = MenuViewController.developerMode
        nameTextField.text = MenuViewController.userName
        
        nameTextField.text = MenuViewController.userName
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        MenuViewController.userName = nameTextField.text ?? "user"
        let account = Account(name: MenuViewController.userName, developer:  MenuViewController.developerMode)
        Account.save(account)
    }
    
    @IBOutlet weak var botton: UISwitch!
    @IBAction func bottonTapped(_ sender: Any) {
        var correct = false
        let alertController = UIAlertController(title: "Confirm Admin", message: nil, preferredStyle: .alert)
        let adminName = "********"
        let passcode = "********"
        alertController.addTextField { (textField) in
            textField.placeholder = "Administrator Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Passcode"
            textField.isSecureTextEntry = true
        }
        let confirmActoin = UIAlertAction(title: "Confirm", style: .cancel) { (_) in
            if alertController.textFields!.first!.text! == adminName {
                correct = true
            } else {
                correct = false
            }
            
            if alertController.textFields!.last!.text! == passcode {
                correct = true
            } else {
                correct = false
            }
            
            if correct {
                MenuViewController.developerMode = true
            } else {
                MenuViewController.developerMode = false
                self.botton.isOn = false
            }
        }
        alertController.addAction(confirmActoin)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    }

    //All rights reserved.

    """
    
    static let Account = """
//
//  Account.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/28.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class Account:NSObject, NSCoding {
    var name:String
    var developerMode:String
    
    init(name:String, developer:Bool) {
        self.name = name
        self.developerMode = String(developer)
    }
    
    struct propertyKey {
        static let name = "name"
        static let developerMode = "developerMode"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let string = aDecoder.decodeObject(forKey: propertyKey.name) as? String,
        let developerMode = aDecoder.decodeObject(forKey: propertyKey.developerMode) as? String else { return nil }
        self.init(name:string, developer: Bool(developerMode)!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: propertyKey.name)
        aCoder.encode(developerMode, forKey: propertyKey.developerMode)
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Account")
    
    static func load() -> Account? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Account.ArchiveURL.path) as? Account
    }
    
    static func save(_ account: Account) {
        NSKeyedArchiver.archiveRootObject(account, toFile: Account.ArchiveURL.path)
    }
}

//All rights reserved.

"""
    static let PassedStudentsViewController = """
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

//All rights reserved.

"""
    static let passedStudentsCell = """
//
//  PassedStudentsCell.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/30.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class PassedStudentsCell:UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

//All rights reserved.

"""
    static let KingsmanIViewContrioller = """
    //
    //  KingsmanViewController.swift
    //  Typer.proj
    //
    //  Created by Vaida on 2019/5/22.
    //  Copyright © 2019 Martin_Vaida. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    class KingsmanIViewController:UITableViewController {
    var lineCount = 0
    
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var lineArray: [UITextField]!
    
    var labelArrayß:[UILabel] = []
    var lineArrayß:[UITextField] = []
    
    @IBOutlet weak var timeLabel: UIBarButtonItem!
    @IBOutlet weak var accuracylabel: UIBarButtonItem!
    
    var currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    var currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    var unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var timer:Timer?
    var timeCounter = 0.0
    var timePassed = ""
    
    var timeTappedBool = false
    var accuracyTappedBool = false
    
    var tappedLetersInAll = -1
    var correctLettersInAll = 0
    
    var correctLettersArray = [Int](repeatElement(0, count: 15))
    var tappedLettersArray = [Int](repeatElement(0, count: 15))
    var tempCorrectLetters = [Character]()
    var tempTappedLetter = [Character]()
    
    override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    self.navigationItem.title = "Kingsman Collection I"
    
    currentLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[0].red)!), green: CGFloat(Double(colorMixViewController.colorArray[0].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[0].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[0].alpha)!))
    currentLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[1].red)!), green: CGFloat(Double(colorMixViewController.colorArray[1].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[1].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[1].alpha)!))
    unusedLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[2].red)!), green: CGFloat(Double(colorMixViewController.colorArray[2].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[2].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[2].alpha)!))
    unusedLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[3].red)!), green: CGFloat(Double(colorMixViewController.colorArray[3].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[3].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[3].alpha)!))
    }
    
    func setup() {
    for i in labelArray {
    labelArrayß.append(i)
    }
    for i in lineArray {
    lineArrayß.append(i)
    }
    
    for i in lineArrayß {
    i.autocorrectionType = .no
    i.placeholder = ""
    }
    
    for i in labelArrayß {
    i.textColor = unusedLabelColor
    i.text = ""
    }
    
    labelArrayß[0].text = "Front page news,"
    labelArrayß[1].text = "and all the occasions were celebrity nonsense,"
    labelArrayß[2].text = "because it’s the nature of kingsmen,"
    labelArrayß[3].text = "that our achievements remain secret."
    labelArrayß[4].text = "A gentleman’s name should appear in the newspaper only three times:"
    labelArrayß[5].text = "when he’s born,"
    labelArrayß[6].text = "when he marries and when he dies."
    labelArrayß[7].text = "And we are,"
    labelArrayß[8].text = "first and foremost,"
    labelArrayß[9].text = "gentleman."
    lineCount = 10
    
    lineArrayß[0].text = " "
    
    var i = -1
    for int in 0...labelArrayß.count-1 {
    i += 1
    if labelArrayß[i].text! == "" {
    labelArrayß.remove(at: i)
    lineArrayß.remove(at: i)
    i -= 1
    
    labelArray[int].isHidden = true
    lineArray[int].isHidden = true
    }
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
    self.navigationItem.title = "Kingsman Collection I"
    }
    
    if MenuViewController.forceQuite {
    if self.timeCounter >= 60.0 {
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Kingsman Collection I","", MenuViewController.userName)
    
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
    
    
    @IBAction func LineOneBegin(_ sender: Any) {
    startTimer()
    
    labelArrayß[0].textColor = currentLabelColor
    lineArrayß[0].textColor = currentLineColor
    }
    
    
    var tempCorrectLetterCount = 0
    
    //When User changed Valve...
    func updateValue(line:Int) {
    
    guard lineArrayß[line-1].text != nil else { return }
    guard lineArray[line-1].text!.count < labelArray[line-1].text!.count+2 else { return }
    
    if lineArrayß[line-1].text!.count == 0 {
    if line == 1 {
    lineArrayß[line-1].text = " "
    } else {
    lineArrayß[line-1].resignFirstResponder()
    lineArrayß[line-2].becomeFirstResponder()
    
    labelArrayß[line-1].textColor = unusedLabelColor
    labelArrayß[line-2].textColor = currentLabelColor
    
    lineArrayß[line-1].textColor = unusedLineColor
    lineArrayß[line-2].textColor = currentLineColor
    
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    
    for i in lineArrayß[line-2].text! {
    tempTappedLetter.append(i)
    }
    for i in labelArrayß[line-2].text! {
    tempCorrectLetters.append(i)
    }
    for i in 0...tempTappedLetter.count-2 {
    if tempCorrectLetters[i] == tempTappedLetter[i+1] {
    tempCorrectLetterCount += 1
    }
    }
    }
    }
    
    guard labelArrayß[line-1].text != nil else { return }
    guard lineArrayß[line-1].text!.count >= 2 else { return }
    tappedLetersInAll = lineArrayß[line-1].text!.count
    
    
    
    if lineArrayß[line-1].text!.count > tempCorrectLetters.count {
    tempCorrectLetters.append(labelArrayß[line-1].text![(labelArrayß[line-1].text?.index(labelArrayß[line-1].text!.startIndex, offsetBy: tempCorrectLetters.count))!])
    tempTappedLetter.append(lineArrayß[line-1].text![lineArrayß[line-1].text!.index(before: lineArrayß[line-1].text!.endIndex)])
    
    if tempTappedLetter[tempTappedLetter.count-1] == tempCorrectLetters[tempCorrectLetters.count-1] {
    tempCorrectLetterCount += 1
    } else {
    lineArrayß[line-1].text!.removeLast()
    lineArrayß[line-1].text!.append("_")
    }
    
    } else {
    if tempCorrectLetters[tempCorrectLetters.count-1] == tempTappedLetter[tempTappedLetter.count-1] {
    tempCorrectLetterCount -= 1
    }
    
    tempCorrectLetters.remove(at: tempCorrectLetters.count-1)
    tempTappedLetter.remove(at: tempTappedLetter.count-1)
    }
    
    correctLettersArray[line-1] = tempCorrectLetterCount
    tappedLettersArray[line-1] = lineArrayß[line-1].text!.count - 1
    
    correctLettersInAll = 0
    for i in correctLettersArray {
    correctLettersInAll += i
    }
    
    tappedLetersInAll = 0
    for i in tappedLettersArray {
    tappedLetersInAll += i
    }
    
    updateAccuracyLabel()
    
    if lineArrayß[line-1].text!.count == labelArrayß[line-1].text!.count+1 {
    guard line != lineCount else {
    stopTimer()
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Kingsman Collection I", "", MenuViewController.userName)
    
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View_Single") as! ScoreViewController
    self.navigationController!.pushViewController(viewController, animated: true)
    
    return
    }
    
    lineArrayß[line-1].resignFirstResponder()
    lineArrayß[line].text = " "
    lineArrayß[line].becomeFirstResponder()
    
    labelArrayß[line-1].textColor = unusedLabelColor
    labelArrayß[line].textColor = currentLabelColor
    
    lineArrayß[line-1].textColor = unusedLineColor
    lineArrayß[line].textColor = currentLineColor
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    return
    }
    }
    
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
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), timePassed, false, "Kingsman Collection I", "", MenuViewController.userName)
    }
    
    
    }
    
    //All rights reserved.

"""
    static let KingsmanIIViewController = """
    //
    //  KingsmanViewController.swift
    //  Typer.proj
    //
    //  Created by Vaida on 2019/5/22.
    //  Copyright © 2019 Martin_Vaida. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    class KingsmanIIViewController:UITableViewController {
    var lineCount = 0
    
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var lineArray: [UITextField]!
    
    var labelArrayß:[UILabel] = []
    var lineArrayß:[UITextField] = []
    
    @IBOutlet weak var timeLabel: UIBarButtonItem!
    @IBOutlet weak var accuracylabel: UIBarButtonItem!
    
    var currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    var currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    var unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var timer:Timer?
    var timeCounter = 0.0
    var timePassed = ""
    
    var timeTappedBool = false
    var accuracyTappedBool = false
    
    var tappedLetersInAll = -1
    var correctLettersInAll = 0
    
    var correctLettersArray = [Int](repeatElement(0, count: 15))
    var tappedLettersArray = [Int](repeatElement(0, count: 15))
    var tempCorrectLetters = [Character]()
    var tempTappedLetter = [Character]()
    
    override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    self.navigationItem.title = "Kingsman Collection II"
    
    currentLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[0].red)!), green: CGFloat(Double(colorMixViewController.colorArray[0].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[0].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[0].alpha)!))
    currentLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[1].red)!), green: CGFloat(Double(colorMixViewController.colorArray[1].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[1].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[1].alpha)!))
    unusedLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[2].red)!), green: CGFloat(Double(colorMixViewController.colorArray[2].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[2].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[2].alpha)!))
    unusedLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[3].red)!), green: CGFloat(Double(colorMixViewController.colorArray[3].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[3].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[3].alpha)!))
    }
    
    func setup() {
    for i in labelArray {
    labelArrayß.append(i)
    }
    for i in lineArray {
    lineArrayß.append(i)
    }
    
    for i in lineArrayß {
    i.autocorrectionType = .no
    i.placeholder = ""
    }
    
    for i in labelArrayß {
    i.textColor = unusedLabelColor
    i.text = ""
    }
    
    labelArrayß[0].text = "Can you guess what the last thing was that flashed through my mind?"
    labelArrayß[1].text = "It was absolutely nothing."
    labelArrayß[2].text = "I had no ties, no bittersweet memories."
    labelArrayß[3].text = "I was leaving nothing behind."
    labelArrayß[4].text = "Never experienced companionship,"
    labelArrayß[5].text = "never been in love,"
    labelArrayß[6].text = "and at that moment,"
    labelArrayß[7].text = "all I felt was loneliness,"
    labelArrayß[8].text = "and regret."
    labelArrayß[9].text = "Just knowing that having something to lose is what makes life worth living."
    lineCount = 10
    
    lineArrayß[0].text = " "
    
    var i = -1
    for int in 0...labelArrayß.count-1 {
    i += 1
    if labelArrayß[i].text! == "" {
    labelArrayß.remove(at: i)
    lineArrayß.remove(at: i)
    i -= 1
    
    labelArray[int].isHidden = true
    lineArray[int].isHidden = true
    }
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
    self.navigationItem.title = "Kingsman Collection II"
    }
    
    if MenuViewController.forceQuite {
    if self.timeCounter >= 60.0 {
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Kingsman Collection II", "", MenuViewController.userName)
    
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
    
    
    @IBAction func LineOneBegin(_ sender: Any) {
    startTimer()
    
    labelArrayß[0].textColor = currentLabelColor
    lineArrayß[0].textColor = currentLineColor
    }
    
    
    var tempCorrectLetterCount = 0
    
    //When User changed Valve...
    func updateValue(line:Int) {
    
    guard lineArrayß[line-1].text != nil else { return }
    guard lineArray[line-1].text!.count < labelArray[line-1].text!.count+2 else { return }
    
    if lineArrayß[line-1].text!.count == 0 {
    if line == 1 {
    lineArrayß[line-1].text = " "
    } else {
    lineArrayß[line-1].resignFirstResponder()
    lineArrayß[line-2].becomeFirstResponder()
    
    labelArrayß[line-1].textColor = unusedLabelColor
    labelArrayß[line-2].textColor = currentLabelColor
    
    lineArrayß[line-1].textColor = unusedLineColor
    lineArrayß[line-2].textColor = currentLineColor
    
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    
    for i in lineArrayß[line-2].text! {
    tempTappedLetter.append(i)
    }
    for i in labelArrayß[line-2].text! {
    tempCorrectLetters.append(i)
    }
    for i in 0...tempTappedLetter.count-2 {
    if tempCorrectLetters[i] == tempTappedLetter[i+1] {
    tempCorrectLetterCount += 1
    }
    }
    }
    }
    
    guard labelArrayß[line-1].text != nil else { return }
    guard lineArrayß[line-1].text!.count >= 2 else { return }
    tappedLetersInAll = lineArrayß[line-1].text!.count
    
    
    
    if lineArrayß[line-1].text!.count > tempCorrectLetters.count {
    tempCorrectLetters.append(labelArrayß[line-1].text![(labelArrayß[line-1].text?.index(labelArrayß[line-1].text!.startIndex, offsetBy: tempCorrectLetters.count))!])
    tempTappedLetter.append(lineArrayß[line-1].text![lineArrayß[line-1].text!.index(before: lineArrayß[line-1].text!.endIndex)])
    
    if tempTappedLetter[tempTappedLetter.count-1] == tempCorrectLetters[tempCorrectLetters.count-1] {
    tempCorrectLetterCount += 1
    } else {
    lineArrayß[line-1].text!.removeLast()
    lineArrayß[line-1].text!.append("_")
    }
    
    } else {
    if tempCorrectLetters[tempCorrectLetters.count-1] == tempTappedLetter[tempTappedLetter.count-1] {
    tempCorrectLetterCount -= 1
    }
    
    tempCorrectLetters.remove(at: tempCorrectLetters.count-1)
    tempTappedLetter.remove(at: tempTappedLetter.count-1)
    }
    
    correctLettersArray[line-1] = tempCorrectLetterCount
    tappedLettersArray[line-1] = lineArrayß[line-1].text!.count - 1
    
    correctLettersInAll = 0
    for i in correctLettersArray {
    correctLettersInAll += i
    }
    
    tappedLetersInAll = 0
    for i in tappedLettersArray {
    tappedLetersInAll += i
    }
    
    updateAccuracyLabel()
    
    if lineArrayß[line-1].text!.count == labelArrayß[line-1].text!.count+1 {
    guard line != lineCount else {
    stopTimer()
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Kingsman Collection II", "", MenuViewController.userName)
    
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View_Single") as! ScoreViewController
    self.navigationController!.pushViewController(viewController, animated: true)
    
    return
    }
    
    lineArrayß[line-1].resignFirstResponder()
    lineArrayß[line].text = " "
    lineArrayß[line].becomeFirstResponder()
    
    labelArrayß[line-1].textColor = unusedLabelColor
    labelArrayß[line].textColor = currentLabelColor
    
    lineArrayß[line-1].textColor = unusedLineColor
    lineArrayß[line].textColor = currentLineColor
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    return
    }
    }
    
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
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), timePassed, false, "Kingsman Collection II", "", MenuViewController.userName)
    }
    
    
    }
    
    //All rights reserved.

"""
    static let StoryViewContrioller = """
    //
    //  StoryViewController.swift
    //  Typer.proj
    //
    //  Created by Vaida on 2019/5/26.
    //  Copyright © 2019 Martin_Vaida. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    class storyViewController:UITableViewController {
    
    static var scrips:[String] = []
    static var passageName = ""
    
    var lineCount = 0
    
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var lineArray: [UITextField]!
    
    var labelArrayß:[UILabel] = []
    var lineArrayß:[UITextField] = []
    
    @IBOutlet weak var timeLabel: UIBarButtonItem!
    @IBOutlet weak var accuracylabel: UIBarButtonItem!
    
    var currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    var currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    var unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var timer:Timer?
    var timeCounter = 0.0
    var timePassed = ""
    
    var timeTappedBool = false
    var accuracyTappedBool = false
    
    var tappedLetersInAll = -1
    var correctLettersInAll = 0
    
    var correctLettersArray = [Int](repeatElement(0, count: 15))
    var tappedLettersArray = [Int](repeatElement(0, count: 15))
    var tempCorrectLetters = [Character]()
    var tempTappedLetter = [Character]()
    
    override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    self.navigationItem.title = storyViewController.passageName
    
    currentLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[0].red)!), green: CGFloat(Double(colorMixViewController.colorArray[0].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[0].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[0].alpha)!))
    currentLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[1].red)!), green: CGFloat(Double(colorMixViewController.colorArray[1].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[1].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[1].alpha)!))
    unusedLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[2].red)!), green: CGFloat(Double(colorMixViewController.colorArray[2].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[2].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[2].alpha)!))
    unusedLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[3].red)!), green: CGFloat(Double(colorMixViewController.colorArray[3].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[3].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[3].alpha)!))
    }
    
    func setup() {
    for i in labelArray {
    labelArrayß.append(i)
    }
    for i in lineArray {
    lineArrayß.append(i)
    }
    
    for i in lineArrayß {
    i.autocorrectionType = .no
    i.placeholder = ""
    }
    
    for i in labelArrayß {
    i.textColor = unusedLabelColor
    i.text = ""
    }
    
    for i in 0...storyViewController.scrips.count-1 {
    labelArrayß[i].text = storyViewController.scrips[i]
    }
    
    lineCount = storyViewController.scrips.count
    
    lineArrayß[0].text = " "
    
    var i = -1
    for int in 0...storyViewController.scrips.count-1 {
    i += 1
    if labelArrayß[i].text! == "" {
    labelArrayß.remove(at: i)
    lineArrayß.remove(at: i)
    i -= 1
    
    labelArray[int].isHidden = true
    lineArray[int].isHidden = true
    }
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
    self.navigationItem.title = storyViewController.passageName
    }
    
    if MenuViewController.forceQuite {
    if self.timeCounter >= 60.0 {
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    storyViewController.scrips.removeAll()
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, storyViewController.passageName, "", MenuViewController.userName)
    
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
    
    
    @IBAction func LineOneBegin(_ sender: Any) {
    startTimer()
    
    labelArrayß[0].textColor = currentLabelColor
    lineArrayß[0].textColor = currentLineColor
    }
    
    
    var tempCorrectLetterCount = 0
    
    //When User changed Valve...
    func updateValue(line:Int) {
    
    guard lineArrayß[line-1].text != nil else { return }
    guard lineArray[line-1].text!.count < labelArray[line-1].text!.count+2 else { return }
    
    if lineArrayß[line-1].text!.count == 0 {
    if line == 1 {
    lineArrayß[line-1].text = " "
    } else {
    lineArrayß[line-1].resignFirstResponder()
    lineArrayß[line-2].becomeFirstResponder()
    
    labelArrayß[line-1].textColor = unusedLabelColor
    labelArrayß[line-2].textColor = currentLabelColor
    
    lineArrayß[line-1].textColor = unusedLineColor
    lineArrayß[line-2].textColor = currentLineColor
    
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    
    for i in lineArrayß[line-2].text! {
    tempTappedLetter.append(i)
    }
    for i in labelArrayß[line-2].text! {
    tempCorrectLetters.append(i)
    }
    for i in 0...tempTappedLetter.count-2 {
    if tempCorrectLetters[i] == tempTappedLetter[i+1] {
    tempCorrectLetterCount += 1
    }
    }
    }
    }
    
    guard labelArrayß[line-1].text != nil else { return }
    guard lineArrayß[line-1].text!.count >= 2 else { return }
    tappedLetersInAll = lineArrayß[line-1].text!.count
    
    
    
    if lineArrayß[line-1].text!.count > tempCorrectLetters.count {
    tempCorrectLetters.append(labelArrayß[line-1].text![(labelArrayß[line-1].text?.index(labelArrayß[line-1].text!.startIndex, offsetBy: tempCorrectLetters.count))!])
    tempTappedLetter.append(lineArrayß[line-1].text![lineArrayß[line-1].text!.index(before: lineArrayß[line-1].text!.endIndex)])
    
    if tempTappedLetter[tempTappedLetter.count-1] == tempCorrectLetters[tempCorrectLetters.count-1] {
    tempCorrectLetterCount += 1
    } else {
    lineArrayß[line-1].text!.removeLast()
    lineArrayß[line-1].text!.append("_")
    }
    
    } else {
    if tempCorrectLetters[tempCorrectLetters.count-1] == tempTappedLetter[tempTappedLetter.count-1] {
    tempCorrectLetterCount -= 1
    }
    
    tempCorrectLetters.remove(at: tempCorrectLetters.count-1)
    tempTappedLetter.remove(at: tempTappedLetter.count-1)
    }
    
    correctLettersArray[line-1] = tempCorrectLetterCount
    tappedLettersArray[line-1] = lineArrayß[line-1].text!.count - 1
    
    correctLettersInAll = 0
    for i in correctLettersArray {
    correctLettersInAll += i
    }
    
    tappedLetersInAll = 0
    for i in tappedLettersArray {
    tappedLetersInAll += i
    }
    
    updateAccuracyLabel()
    
    if lineArrayß[line-1].text!.count == labelArrayß[line-1].text!.count+1 {
    guard line != lineCount else {
    stopTimer()
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    storyViewController.scrips.removeAll()
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, storyViewController.passageName, "", MenuViewController.userName)
    
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View_Single") as! ScoreViewController
    self.navigationController!.pushViewController(viewController, animated: true)
    
    return
    }
    
    lineArrayß[line-1].resignFirstResponder()
    lineArrayß[line].text = " "
    lineArrayß[line].becomeFirstResponder()
    
    labelArrayß[line-1].textColor = unusedLabelColor
    labelArrayß[line].textColor = currentLabelColor
    
    lineArrayß[line-1].textColor = unusedLineColor
    lineArrayß[line].textColor = currentLineColor
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    return
    }
    }
    
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
    storyViewController.scrips.removeAll()
    
    let correctLetters = correctLettersInAll
    let tappedLetters = tappedLetersInAll
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), timePassed, false, storyViewController.passageName, "", MenuViewController.userName)
    }
    }
    
    //All rights reserved.

"""
    
    static let RandomViewController = """
    //
    //  RandomViewController.swift
    //  Typer.proj
    //
    //  Created by Vaida on 2019/5/23.
    //  Copyright © 2019 Martin_Vaida. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    class RandomViewController:UITableViewController {
    var lineCount = 0
    
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var lineArray: [UITextField]!
    
    var labelArrayß:[UILabel] = []
    var lineArrayß:[UITextField] = []
    var labelUsed = [Bool](repeatElement(false, count: 10))
    
    @IBOutlet weak var timeLabel: UIBarButtonItem!
    @IBOutlet weak var accuracylabel: UIBarButtonItem!
    
    var currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    var currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    var unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var timer:Timer?
    var timeCounter = 0.0
    var timePassed = ""
    
    var timeTappedBool = false
    var accuracyTappedBool = false
    
    var tappedLetersInAll = -1
    var correctLettersInAll = 0
    
    var correctLettersArray = [Int](repeatElement(0, count: 15))
    var tappedLettersArray = [Int](repeatElement(0, count: 15))
    var tempCorrectLetters = [Character]()
    var tempTappedLetter = [Character]()
    
    let letters:[String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"," "," ", " ", " "]
    
    override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    self.navigationItem.title = "Random Mode"
    
    currentLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[0].red)!), green: CGFloat(Double(colorMixViewController.colorArray[0].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[0].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[0].alpha)!))
    currentLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[1].red)!), green: CGFloat(Double(colorMixViewController.colorArray[1].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[1].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[1].alpha)!))
    unusedLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[2].red)!), green: CGFloat(Double(colorMixViewController.colorArray[2].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[2].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[2].alpha)!))
    unusedLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[3].red)!), green: CGFloat(Double(colorMixViewController.colorArray[3].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[3].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[3].alpha)!))
    
    startTimerß()
    }
    
    func setup() {
    for i in labelArray {
    labelArrayß.append(i)
    }
    for i in lineArray {
    lineArrayß.append(i)
    }
    
    for i in lineArrayß {
    i.autocorrectionType = .no
    i.placeholder = ""
    }
    
    for i in labelArrayß {
    i.textColor = unusedLabelColor
    i.text = ""
    }
    lineCount = 10
    
    lineArrayß[0].text = " "
    
    let alertController = UIAlertController(title: "Notice", message: "This is a mode designed for the masters in typing. \n All the letters will be chosen randomly.", preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: "Got it!", style: .default, handler: nil)
    let cancelAction = UIAlertAction(title: "Next time maybe", style: .cancel) { (_) in
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Choose_Passage_View") as! ChoosePassageController
    self.navigationController!.pushViewController(viewController, animated: true)
    }
    alertController.addAction(confirmAction)
    alertController.addAction(cancelAction)
    self.present(alertController, animated: true, completion: nil)
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
    self.navigationItem.title = "Random Mode"
    }
    
    if MenuViewController.forceQuite {
    if self.timeCounter >= 60.0 {
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Random Mode", "", MenuViewController.userName)
    
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View_Single") as! ScoreViewController
    self.navigationController!.pushViewController(viewController, animated: true)
    }
    }
    })
    }
    
    func startTimerß() {
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
    for i in 0...self.labelArray.count-1 {
    guard !self.labelUsed[i] else { continue }
    //make text
    self.labelArrayß[i].text = ""
    for _ in 0...25 {
    let int = arc4random_uniform(28)
    self.labelArrayß[i].text! += self.letters[Int(int)]
    }
    }
    }
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
    
    
    @IBAction func LineOneBegin(_ sender: Any) {
    startTimer()
    
    //make text
    labelUsed[0] = true
    labelArrayß[0].text = ""
    for _ in 0...25 {
    let int = arc4random_uniform(28)
    labelArrayß[0].text! += letters[Int(int)]
    }
    
    labelArrayß[0].textColor = currentLabelColor
    lineArrayß[0].textColor = currentLineColor
    }
    
    
    var tempCorrectLetterCount = 0
    
    //When User changed Valve...
    func updateValue(line:Int) {
    
    guard lineArrayß[line-1].text != nil else { return }
    guard lineArray[line-1].text!.count < labelArray[line-1].text!.count+2 else { return }
    
    if lineArrayß[line-1].text!.count == 0 {
    if line == 1 {
    lineArrayß[line-1].text = " "
    } else {
    lineArrayß[line-1].resignFirstResponder()
    lineArrayß[line-2].becomeFirstResponder()
    
    labelArrayß[line-1].textColor = unusedLabelColor
    labelArrayß[line-2].textColor = currentLabelColor
    
    lineArrayß[line-1].textColor = unusedLineColor
    lineArrayß[line-2].textColor = currentLineColor
    
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    
    for i in lineArrayß[line-2].text! {
    tempTappedLetter.append(i)
    }
    for i in labelArrayß[line-2].text! {
    tempCorrectLetters.append(i)
    }
    for i in 0...tempTappedLetter.count-2 {
    if tempCorrectLetters[i] == tempTappedLetter[i+1] {
    tempCorrectLetterCount += 1
    }
    }
    }
    }
    
    guard labelArrayß[line-1].text != nil else { return }
    guard lineArrayß[line-1].text!.count >= 2 else { return }
    tappedLetersInAll = lineArrayß[line-1].text!.count
    
    
    
    if lineArrayß[line-1].text!.count > tempCorrectLetters.count {
    tempCorrectLetters.append(labelArrayß[line-1].text![(labelArrayß[line-1].text?.index(labelArrayß[line-1].text!.startIndex, offsetBy: tempCorrectLetters.count))!])
    tempTappedLetter.append(lineArrayß[line-1].text![lineArrayß[line-1].text!.index(before: lineArrayß[line-1].text!.endIndex)])
    
    if tempTappedLetter[tempTappedLetter.count-1] == tempCorrectLetters[tempCorrectLetters.count-1] {
    tempCorrectLetterCount += 1
    } else {
    lineArrayß[line-1].text!.removeLast()
    lineArrayß[line-1].text!.append("_")
    }
    
    } else {
    if tempCorrectLetters[tempCorrectLetters.count-1] == tempTappedLetter[tempTappedLetter.count-1] {
    tempCorrectLetterCount -= 1
    }
    
    tempCorrectLetters.remove(at: tempCorrectLetters.count-1)
    tempTappedLetter.remove(at: tempTappedLetter.count-1)
    }
    
    correctLettersArray[line-1] = tempCorrectLetterCount
    tappedLettersArray[line-1] = lineArrayß[line-1].text!.count - 1
    
    correctLettersInAll = 0
    for i in correctLettersArray {
    correctLettersInAll += i
    }
    
    tappedLetersInAll = 0
    for i in tappedLettersArray {
    tappedLetersInAll += i
    }
    
    updateAccuracyLabel()
    
    if lineArrayß[line-1].text!.count == labelArrayß[line-1].text!.count+1 {
    guard line != lineCount else {
    stopTimer()
    let correctLetters = self.correctLettersInAll
    let tappedLetters = self.tappedLetersInAll
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Random Mode", "", MenuViewController.userName)
    
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View_Single") as! ScoreViewController
    self.navigationController!.pushViewController(viewController, animated: true)
    
    return
    }
    
    lineArrayß[line-1].resignFirstResponder()
    lineArrayß[line].text = " "
    lineArrayß[line].becomeFirstResponder()
    
    labelUsed[line] = true
    labelArrayß[line].text = ""
    for _ in 0...25 {
    let int = arc4random_uniform(28)
    labelArrayß[line].text! += letters[Int(int)]
    }
    
    labelArrayß[line-1].textColor = unusedLabelColor
    labelArrayß[line].textColor = currentLabelColor
    
    lineArrayß[line-1].textColor = unusedLineColor
    lineArrayß[line].textColor = currentLineColor
    tempCorrectLetters = []
    tempTappedLetter = []
    tempCorrectLetterCount = 0
    return
    }
    }
    
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
    
    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), timePassed, false, "Random Mode", "", MenuViewController.userName)
    }
    
    }
    
    //All rights reserved.

"""
    
    static let gameViewController = """
//
//  gameViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/23.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class gameViewController:UIViewController {
    var viewArray:[UIView] = []
    var time = 4
    var timer:Timer?
    static var textArray:[String] = []
    static var showTextArray:[UITextField] = []
    var tempText = ""
    var currentLine = 0
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var centerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        centerLabel.text = ""
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            self.time -= 1
            self.centerLabel.text = String(self.time)
            if self.time == 0 {
                self.textField.becomeFirstResponder()
                self.stopTimer()
                self.centerLabel.text = ""
                
                self.viewArray.append(UIView.makeView(x: Support.width, y: 0, labelText: "HaHaHa"))
                self.view.addSubview(self.viewArray[0])
                
                UIView.animate(withDuration: 10) {
                    self.viewArray[0].frame = CGRect(x: 0, y:Int(self.viewArray[0].frame.origin.y), width: Support.width, height: 88)
                }
                UIView.animate(withDuration: 10, delay: 9.8, options: [], animations: {
                    self.viewArray[0].frame = CGRect(x: -Support.width, y:Int(self.viewArray[0].frame.origin.y), width: Support.width, height: 88)
                }, completion: nil)
            }
        }
        
    }
    
    func stopTimer() {
        timer!.invalidate()
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        tempText = textField.text!
        textField.text = ""
        gameViewController.showTextArray[currentLine].text! += tempText
    }
    
}

//All rights reserved.

"""
    static let ITViewController = """
//
//  ITViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/28.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class ITViewController:UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard !MenuViewController.developerMode else { return }
        let alertController = UIAlertController(title: "Notice", message: "In this mode, \n we will build apps together. \n Try to type in the code, \n and some easy apps will be built.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Got it!", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Next time maybe", style: .cancel) { (_) in
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Choose_Passage_View") as! ChoosePassageController
            self.navigationController!.pushViewController(viewController, animated: true)
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//All rights reserved.

"""
    static let LightViewController = """
    //
    //  LightViewController.swift
    //  Typer.proj
    //
    //  Created by Vaida on 2019/5/28.
    //  Copyright © 2019 Martin_Vaida. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    class LightViewController:UITableViewController {
    @IBOutlet var introductionLabel: [UILabel]!     //seven objects
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var lineArray: [UITextField]!
    
    var currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    var currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    var unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var correct = false
    var botton = UIButton(frame: CGRect(x: 23, y: 70, width: 100, height: 44))
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    }
    
    func setup() {
    for i in introductionLabel {
    i.text = "//  "
    }
    introductionLabel[1].text! += "ViewController.swift"
    introductionLabel[2].text! += "Light"
    
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "zh_CN")
    let takenDate = String(dateFormatter.string(from: Date()))
    introductionLabel[4].text! += "Created by \\(MenuViewController.userName) on \\(takenDate)."
    
    currentLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[0].red)!), green: CGFloat(Double(colorMixViewController.colorArray[0].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[0].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[0].alpha)!))
    currentLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[1].red)!), green: CGFloat(Double(colorMixViewController.colorArray[1].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[1].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[1].alpha)!))
    unusedLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[2].red)!), green: CGFloat(Double(colorMixViewController.colorArray[2].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[2].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[2].alpha)!))
    unusedLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[3].red)!), green: CGFloat(Double(colorMixViewController.colorArray[3].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[3].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[3].alpha)!))
    
    for i in lineArray {
    i.textColor = unusedLineColor
    }
    for i in labelArray {
    i.textColor = unusedLabelColor
    }
    }
    
    func check() {
    for i in 0...labelArray.count-1 {
    if labelArray[i].text! == lineArray[i].text! {
    } else {
    lineArray[i].backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.1)
    correct = false
    }
    }
    }
    
    let iPhoneFace = UIImageView(image: UIImage(named: "iPhone XR face black"))
    
    @IBAction func build(_ sender: Any) {
    check()
    if MenuViewController.developerMode {
    correct = true
    }
    
    guard correct else { return }
    
    let iPhone = UIImageView(image: UIImage(named: "iPhone XR"))
    iPhone.frame = CGRect(x: 0, y: 0, width: (view.frame.height-100)/1532*759, height: view.frame.height-100)
    self.view.addSubview(iPhone)
    
    iPhoneFace.frame = CGRect(x: 0, y: 0, width: (view.frame.height-100)/1532*759, height: view.frame.height-100)
    self.view.addSubview(iPhoneFace)
    
    botton.backgroundColor = .blue
    botton.setTitle("OFF", for: .normal)
    self.view.addSubview(botton)
    botton.addTarget(self, action: #selector(bottonPressed), for: .touchUpInside)
    
    UIView.animate(withDuration: 2) {
    self.navigationItem.rightBarButtonItems?.append(UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(self.done)))
    }
    }
    
    @objc func done() {
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Menu_View") as! MenuViewController
    self.present(viewController, animated: true, completion: nil)
    }
    
    func jumpToNextLine(line: Int) {
    lineArray[line-1].textColor = unusedLineColor
    labelArray[line-1].textColor = unusedLabelColor
    lineArray[line-1].resignFirstResponder()
    lineArray[line].becomeFirstResponder()
    lineArray[line].textColor = currentLineColor
    labelArray[line].textColor = currentLabelColor
    }
    
    var lightOn = true
    @objc func bottonPressed() {
    lightOn = !lightOn
    if lightOn {
    iPhoneFace.image = UIImage(named: "iPhone XR face black")
    botton.setTitle("OFF", for: .normal)
    }else{
    iPhoneFace.image = UIImage(named: "iPhone XR face")
    botton.setTitle("ON", for: .normal)
    }
    }
    
    @IBAction func lineOneBegin(_ sender: Any) {
    lineArray[0].textColor = currentLineColor
    labelArray[0].textColor = currentLabelColor
    }
    @IBAction func lineOne(_ sender: Any) {
    jumpToNextLine(line: 1)
    }
    @IBAction func lineTwo(_ sender: Any) {
    jumpToNextLine(line: 2)
    }
    @IBAction func lineThree(_ sender: Any) {
    jumpToNextLine(line: 3)
    }
    @IBAction func lineFour(_ sender: Any) {
    jumpToNextLine(line: 4)
    }
    @IBAction func lineFive(_ sender: Any) {
    jumpToNextLine(line: 5)
    }
    @IBAction func lineSix(_ sender: Any) {
    jumpToNextLine(line: 6)
    }
    @IBAction func lineSeven(_ sender: Any) {
    jumpToNextLine(line: 7)
    }
    @IBAction func lineEight(_ sender: Any) {
    jumpToNextLine(line: 8)
    }
    @IBAction func lineNine(_ sender: Any) {
    jumpToNextLine(line: 9)
    }
    @IBAction func lineTen(_ sender: Any) {
    jumpToNextLine(line: 10)
    }
    @IBAction func lineEleven(_ sender: Any) {
    jumpToNextLine(line: 11)
    }
    @IBAction func lineTwelve(_ sender: Any) {
    jumpToNextLine(line: 12)
    }
    @IBAction func lineThirtee(_ sender: Any) {
    jumpToNextLine(line: 13)
    }
    
    
    }
    
    //All rights reserved.

"""
    static let LightController = """
//
//  LightController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/28.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class LightController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        botton.setTitle("OFF", for: .normal)
        self.view.addSubview(botton)
        botton.addTarget(self, action: #selector(bottonPressed), for: .touchUpInside)
    }
    
    var lightOn = true
    let botton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
    
    @objc func bottonPressed() {
        lightOn = !lightOn
        if lightOn {
            view.backgroundColor = .white
            botton.setTitle("OFF", for: .normal)
        }else{
            view.backgroundColor = .black
            botton.setTitle("ON", for: .normal)
        }
    }
}

//All rights reserved.

"""
    
    
    
}
//All rights reserved.
