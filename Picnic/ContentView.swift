//
//  ContentView.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/21/22.
//

import SwiftUI

struct ContentView: View {
    @State var requestLogin = false
    var body: some View {
        Startup(requestLogin: $requestLogin, profiles: [])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PicnicAuth())
            .environmentObject(PicnicSurvey())
    }
}
