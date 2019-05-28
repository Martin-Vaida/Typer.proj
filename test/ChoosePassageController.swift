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
    
    
    
}
