//
//  AppDelegate.swift
//  Example
//
//  Created by Chris Eidhof on 17/05/16.
//  Copyright © 2016 objc.io. All rights reserved.
//

import UIKit

struct Episode {
    var title: String
}

class ProfileViewController: UIViewController {
    var person: String = ""
    var didTapClose: () -> () = {}

    @IBAction func close(sender: AnyObject) {
        didTapClose()
    }
}

class DetailViewController: UIViewController {
    @IBOutlet weak var label: UILabel? {
        didSet {
            label?.text = episode?.title
        }
    }
    var episode: Episode?
}

class EpisodesViewController: UITableViewController {
    let episodes = [Episode(title: "Episode One"), Episode(title: "Episode Two"), Episode(title: "Episode Three")]
    var didSelect: (Episode) -> () = { _ in }
    var didTapProfile: () -> () = {}
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let episode = episodes[indexPath.row]
        didSelect(episode)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode.title
        return cell
    }
    
    @IBAction func showProfile(sender: AnyObject) {
        didTapProfile()
    }
}

final class App {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let navigationController: UINavigationController

    init(window: UIWindow) {
        navigationController = window.rootViewController as! UINavigationController
        let episodesVC = navigationController.viewControllers[0] as! EpisodesViewController
        episodesVC.didSelect = { _ in self.showProfile() }
        episodesVC.didTapProfile = showProfile
    }
    
    func showEpisode(episode: Episode) {
        let detailVC = storyboard.instantiateViewControllerWithIdentifier("Detail") as! DetailViewController
        detailVC.episode = episode
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func showProfile() {
        let profileNC = self.storyboard.instantiateViewControllerWithIdentifier("Profile") as! UINavigationController
        let profileVC = profileNC.viewControllers[0] as! ProfileViewController
        profileVC.didTapClose = {
            self.navigationController.dismissViewControllerAnimated(true, completion: nil)
        }
        navigationController.presentViewController(profileNC, animated: true, completion: nil)
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var app: App?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if let window = window {
            app = App(window: window)
        }
        return true
    }

}

