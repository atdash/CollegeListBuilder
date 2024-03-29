//
//  AppDelegate.swift
//  RealmTasks
//
//  Created by Hossam Ghareeb on 10/12/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

import UIKit
import RealmSwift



//let uiRealm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let uiRealm = try! Realm()

    // This will be useful to test a compressed realm image in the bundle. Current path is a placeholder...
    func setDefaultRealmForThisApp() {
        
        var config = Realm.Configuration()
        let currentRealm = "/Users/Nicholas/Documents/Working/Swift/Realms"
        config.path = currentRealm
        Realm.Configuration.defaultConfiguration = config
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        

//        setDefaultRealmForThisApp()
        let uiRealm = try! Realm()
        print(uiRealm.path)

//        print(Realm.Configuration.defaultConfiguration.path!)
//      dataTaskFinishedWithData(readjson("/Users/Nicholas/Documents/Working/Swift/Playgrounds/ToDoListATDash/colleges-two.json"))
        
        // use this to import an updated colleges.json
//        TryThisJSONRequest()
        
        // use this to import test data for likelihood... (not current working)
//        TryThisJSONRequestUpdate()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

