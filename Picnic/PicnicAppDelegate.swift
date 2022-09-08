//
//  PicnicAppDelegate.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/23/22.
//

import Foundation
import UIKit

import Firebase

class PicnicAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
