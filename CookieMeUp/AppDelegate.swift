//
//  AppDelegate.swift
//  CookieMeUp
//
//  Created by Raquel Figueroa-Opperman on 2/26/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import UIKit
import Parse
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let googleApiKey = "AIzaSyCsHPlIsQPOafLkdtQ3aQJTmB8RmnooApI"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSPlacesClient.provideAPIKey(googleApiKey)
        GMSServices.provideAPIKey(googleApiKey)
        
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "cookie-me-up"
                configuration.clientKey = "123"  // set to nil assuming you have not set clientKey
                configuration.server = "https://cookie-me-up.herokuapp.com/parse"
            }))
        
        if let currentUser = PFUser.current() {
            print("Welcome back \(currentUser.username!) 😀")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
  
            let tabBarViewController = storyboard.instantiateViewController(withIdentifier: "tabBarViewController")
            window?.rootViewController = tabBarViewController
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("didLogout"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Logout notification received")
            self.logOut()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginScreen")
            self.window?.rootViewController = loginViewController
        }
        
        return true
    }
    
    // Logout function:
    func logOut() {
        PFUser.logOutInBackground { (error) in
            if let error = error {
                print (error.localizedDescription)
            } else {
                print ("Successfully logged out")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginScreen")
                self.window?.rootViewController = loginViewController
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

