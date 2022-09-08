//
//  PicnicTabs.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/23/22.
//

import SwiftUI
import AudioToolbox

struct PicnicTabs: View {
    @EnvironmentObject var auth: PicnicAuth
    @State var requestLogin = false
//    @State var refresh = false
    var body: some View {
        if auth.user == nil {
            Startup(requestLogin: $requestLogin, profiles: [])
        } else {
            VStack {
                HStack {
                    Text("Picnic")
                        .fontWeight(.bold)
                        .font(.title)
                    Image(systemName: "leaf")
                        .imageScale(.large)
//                    Button {
//                        refresh.toggle()
//                    } label: {
//                        Image(systemName: "arrow.clockwise")
//                    } .padding(.leading, 30)
                    
                }
                TabView {
                    SwipeView(profiles: [])
                        .tabItem {
                            Label("", systemImage: "leaf")
                        }

                    MessageView(profileList: [], convoList: [])
                        .tabItem {
                            Label("", systemImage: "message")
                        }

                    SettingsView()
                        .tabItem {
                            Label("", systemImage: "gearshape.2")
                        }
                }
            }
        }
    }
}

struct PicnicTabs_Previews: PreviewProvider {
    static var previews: some View {
        PicnicTabs()
    }
}
