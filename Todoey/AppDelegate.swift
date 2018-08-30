//
//  AppDelegate.swift
//  Todoey
//
//  Created by Gourav Nayyar on 09/08/18.
//  Copyright © 2018 Gourav Nayyar. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {



//        print(Realm.Configuration.defaultConfiguration.fileURL)

        // CRUD
        do {
             _ = try Realm()
        } catch {
            print("Error installing new realm, \(error)")
        }

        return true
    }


}

