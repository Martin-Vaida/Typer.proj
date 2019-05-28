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

