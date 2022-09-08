//
//  SwipeView.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/23/22.
//

import SwiftUI

struct SwipeView: View {
    @EnvironmentObject var profile: PicnicSurvey
    @State var profiles: [PicnicProfile]
    @State var error: Error?
    @State var fetching = false
    @State var count = 0
    @State var liked = false
    @State var disliked = false
    //@State var likes = [""]
    
    var body: some View {
        VStack {
            if fetching {
                ProgressView()
            } else if error != nil {
                Text("Something went wrong…we wish we can say more 🤷🏽")
            } else if profiles.count == 0 {
                VStack {
                    Spacer()
                    Text("Sorry, no other users are available!")
                    Spacer()
                }
            } else {
                VStack {
                    if count < profiles.count {
                        SwipeCard(profile: profiles[count])
                            .transition(.move(edge: .leading))
                        HStack {
                            Button {
                                if count < profiles.count {
                                    count += 1
                                }
                                self.disliked = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.disliked = false
                                }
                            } label: {
                                Image(systemName: self.disliked ? "heart.slash.fill" : "heart.slash")
                                    .resizable()
                                    .frame(width: 28.0, height: 28.0)
                                    .foregroundColor(self.disliked ? .blue : .gray)
                                    .scaleEffect(self.disliked ? 0.70 : 1)
                                    .animation(.easeInOut, value: self.disliked)
                            } .padding(.leading, 30)
                            Spacer()
                            Button {
                                profile.likeUser(user: profiles[count].email)
                                if count < profiles.count {
                                    count += 1
                                }
                                profile.profileRefresh(email: profile.userInfo?.email ?? "")
                                self.liked = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.liked = false
                                }
                            } label: {
                                Image(systemName: self.liked ? "heart.fill" : "heart")
                                    .resizable()
                                    .frame(width: 28.0, height: 28.0)
                                    .foregroundColor(self.liked ? .red : .gray)
                                    .scaleEffect(self.liked ? 1.5 : 1)
                                    .animation(.easeInOut, value: self.liked)
                            } .padding(.trailing, 30)
                        } .padding()
                    } else {
                        Text("Sorry, no other users are available!")
                    }
                }
            }
        } .task {
            fetching = true
            do {
                if profiles.isEmpty {
                    profiles = try await profile.fetchProfiles()
                    let likes = profile.userInfo?.likes ?? [""]
                    for like in likes {
                        for prof in profiles {
                            if prof.email == like {
                                let index = profiles.firstIndex(of: prof)
                                profiles.remove(at: index!)
                            } else if prof.email == profile.userInfo?.email {
                                let index = profiles.firstIndex(of: prof)
                                profiles.remove(at: index!)
                            }
                        }
                    }
                }
                profile.profileRefresh(email: profile.userInfo?.email ?? "")
                fetching = false
            } catch {
                self.error = error
                fetching = false
            }
        }
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView(profiles: [])
    }
}
