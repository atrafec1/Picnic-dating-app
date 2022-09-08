//
//  Homepage.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/24/22.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var auth: PicnicAuth
    @State var requestLogin = false

    var body: some View {
        if let authUI = auth.authUI {
            AuthenticationViewController(authUI: authUI)
        } else {
            VStack {
                Text("Sorry, looks like we aren’t set up right!")
                    .padding()

                Text("Please contact this app’s developer for assistance.")
                    .padding()
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
