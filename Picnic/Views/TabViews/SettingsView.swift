//
//  SettingsView.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/23/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var profile: PicnicSurvey
    @EnvironmentObject var auth: PicnicAuth
    @State var bio = ""
    @State var edit = false
    var body: some View {
        VStack {
            let image = UIImage(data: profile.userInfo?.picture ?? Data())
            Image(uiImage: image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            Text(profile.userInfo?.name ?? "John Doe")
                .font(.system(size: 30))
            Text(profile.userInfo?.email ?? "No email found")
            if edit {
                TextField(bio, text: $bio)
                    .border(.secondary)
                    .padding()
                    .onSubmit {
                        profile.setBio(user: profile.userInfo?.email ?? "Blank", text: bio)
                        edit = false
                        profile.profileRefresh(email: profile.userInfo?.email ?? "")
                }
            } else {
                HStack {
                    Text(profile.userInfo?.bio ?? "No bio found")
                        .font(.system(size: 14))
                        .padding()
                    Button {
                        edit = true
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
            
            
            
            Button("Sign out") {
                do {
                    try auth.signOut()
                } catch {
                    
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(PicnicSurvey())
    }
}
