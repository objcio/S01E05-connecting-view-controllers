//
//  AppDelegate.swift
//  Example
//
//  Created by Chris Eidhof on 17/05/16.
//  Copyright © 2016 objc.io. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var person: String = ""
}

class ItemsViewController: UITableViewController {
    let items = ["one", "two", "three"]
    var didSelect: String -> () = { _ in }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelect(items[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DetailViewController {
            vc.item = items[tableView.indexPathForSelectedRow!.row]
        } else if let nc = segue.destinationViewController as? UINavigationController,
            pvc = nc.viewControllers.first as? ProfileViewController {
            pvc.person = "My Name"
        } else {
            fatalError()
        }
    }
    
    @IBAction func unwindToHere(segue: UIStoryboardSegue) {
        
    }
}

class DetailViewController: UIViewController {
    @IBOutlet weak var label: UILabel? {
        didSet {
            label?.text = item
        }
    }
    var item: String?
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}

