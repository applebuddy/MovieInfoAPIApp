//
//  AppDelegate.swift
//  MovieInfoApp
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//  * Now Processing Branch : Feature/Refactoring

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITextViewWorkaround.executeWorkaround()
        return true
    }
}
