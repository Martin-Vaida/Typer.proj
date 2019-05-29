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
