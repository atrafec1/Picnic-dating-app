//
//  Startup.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/24/22.
//

import SwiftUI

struct Startup: View {
    @EnvironmentObject var auth: PicnicAuth
    @EnvironmentObject var survey: PicnicSurvey
    @Binding var requestLogin: Bool
    @State var profiles: [PicnicProfile]
    var body: some View {
        VStack {
            if auth.user == nil {
                VStack {
                    HStack {
                        Text("Welcome to Picnic")
                            .font(.title)
                        Image(systemName: "leaf")
                            .imageScale(.large)
                    }
                    Button("Sign In") {
                        requestLogin = true
                    } .padding()
                }.sheet(isPresented: $requestLogin) {
                    Login()
                }
            } else {
                if survey.loading {
                    ProgressView()
                } else {
                    if survey.userInfo != nil {
                        PicnicTabs()
                    } else {
                        SurveyView(profiles: $profiles)
                    }
                }
            }
        } .task(id: auth.submitted) {
            survey.loading = true
            survey.checkProfiles(email: auth.user?.email ?? "blank")
        }
    }  
}

struct Startup_Previews: PreviewProvider {
    @State static var requestLogin = false
    static var previews: some View {
        Startup(requestLogin: $requestLogin, profiles: [])
            .environmentObject(PicnicAuth())
    }
}
