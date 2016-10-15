//
//  AppDelegate.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/15/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let viewControllerStoryboardId = "NavigationMoviesViewController"
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        
        // Most Recent
        let vc1 = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        let movieVC1 = vc1.childViewControllers[0] as! MoviesViewController
        movieVC1.movieSource = .nowPlaying
        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        
        // Top Rated
        let vc2 = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        let movieVC2 = vc2.childViewControllers[0] as! MoviesViewController
        movieVC2.movieSource = .topRated
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        
        // Tab Bar
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [vc1, vc2]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBarController.tabBar.bounds
        tabBarController.tabBar.insertSubview(blurView, at: 0)
        
        let tabBar = UITabBar.appearance()
        tabBar.barStyle = .blackOpaque
        tabBar.tintColor = Colors.main
        tabBar.barTintColor = Colors.main
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        return true
    }
}

