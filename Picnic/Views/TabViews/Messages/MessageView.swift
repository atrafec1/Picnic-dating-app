//
//  MessageView.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/23/22.
//

import SwiftUI

struct MessageView: View {
    @EnvironmentObject var profile: PicnicSurvey
    @State var profileList: [PicnicProfile]
    @State var convoList: [PicnicProfile]
    @State var error: Error?
    @State var fetching = false
    @State var first = false
    @State var convos: [String: Any] = [:]
    @State var refresh = false
    var body: some View {
        NavigationView {
            ScrollView {
                if fetching {
                    ProgressView()
                } else if (first) {
                    VStack {
                        Text("Swipe more to see matches here!")
                        Button {
                            first = false
                            refresh.toggle()
            
                        } label: {
                            Text("Refresh")
                        } .padding()
                    }
                } else {
                    VStack {
                        HStack {
                            Text("New Matches")
                                .bold()
                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(profileList) { prof in
                                    NavigationLink {
                                        ConversationView(match: prof)
                                    } label: {
                                        MatchCard(match: prof)
                                    }
                                }
                            }
                            
                        } .padding(.bottom)
                        HStack {
                            Text("Messages")
                                .bold()
                            Spacer()
//                            Button {
//                                refresh.toggle()
//                            } label: {
//                                Image(systemName: "arrow.clockwise")
//                            }
                        }
                        VStack {
                            ForEach(convoList) { prof in
                                NavigationLink {
                                    ConversationView(match: prof)
                                } label: {
                                    ConversationCard(prof: prof)
                                }
                            }
                        } .padding()
                        Spacer()
                    }.navigationBarTitle("")
                    .navigationBarHidden(true)
                    .padding()
                }
            } .task(id: refresh) {
                do {
                    print("i clicked refresh \(first)")
                    for i in 1...2 {
                        if !first {
                            fetching = true
                            profileList = try await profile.fetchProfiles()
                            convoList = try await profile.fetchProfiles()
                            let likesList = profile.userInfo?.likes ?? []
                            let likedList = profile.userInfo?.likedBy ?? []
                            for prof in profileList {
                                if (!likesList.contains(prof.email) || !likedList.contains(prof.email)) {
                                    let index = profileList.firstIndex(of: prof)
                                    profileList.remove(at: index!)
                                }
                            }
                            if profileList.isEmpty && i == 2 {
                                first = true
                            }
                            profile.profileRefresh(email: profile.userInfo?.email ?? "")
                            convos = profile.userInfo?.conversations ?? [:]
                            print(convos)
                            for prof in convoList {
                                let fix = prof.email.replacingOccurrences(of: ".", with: ",")
                                if convos[fix] == nil {
                                    let index = convoList.firstIndex(of: prof)
                                    convoList.remove(at: index!)
                                }
                            }
                        }
                    }
                    fetching = false
                } catch {
                    self.error = error
                    fetching = false
                }
            }
        }
    }
}

//struct MessageView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        MessageView(profileList: [], convoList: [], refresh: <#T##Binding<Bool>#>)
//    }
//}
