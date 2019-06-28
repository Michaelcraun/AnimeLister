//
//  AppDelegate.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        getTheme()
        updateTitleBarAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {  }

    func applicationDidEnterBackground(_ application: UIApplication) {  }

    func applicationWillEnterForeground(_ application: UIApplication) {  }

    func applicationDidBecomeActive(_ application: UIApplication) {  }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    private func getTheme() {
        // MARK: TEMPORARY
        LocalStorage.store.set("dark", for: .theme)
        
        let themeName = LocalStorage.store.get(for: .theme)
        Settings.instance.theme = Theme(themeName)
    }
    
    private func updateTitleBarAppearance() {
        let barAppearance = UINavigationBar.appearance()
        barAppearance.barTintColor = Settings.instance.theme.titleBarColor
        barAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : Settings.instance.theme.textColor,
            NSAttributedString.Key.font : Settings.instance.theme.titleBarFont as Any]
        barAppearance.isTranslucent = false
        
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.tintColor = Settings.instance.theme.titleBarTintColor
        barButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AnimeLister")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
