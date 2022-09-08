//
//  PicnicApp.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/21/22.
//

import SwiftUI

@main
struct PicnicApp: App {
    
    @UIApplicationDelegateAdaptor(PicnicAppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PicnicAuth())
                .environmentObject(PicnicSurvey())
        }
    }
}
