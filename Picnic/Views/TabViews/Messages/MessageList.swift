//
//  MessageList.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/29/22.
//

import SwiftUI

struct MessageList: View {
    @EnvironmentObject var profile: PicnicSurvey
    var messages: [String]
    //var user: String
    var body: some View {
        ScrollView {
            
            if messages != [] {
                VStack {
                    ForEach(messages, id: \.self) { msg in
                        let range = msg.index(after: msg.startIndex)..<msg.endIndex
                        if msg.prefix(1) == "0" {
                            HStack {
                                Spacer()
                                    
                                Text(msg[range])
                                    .foregroundColor(Color.white)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                    .padding(.vertical, 3.0)
                                    .padding(.horizontal, 6.0)
                                    .background(Rectangle().fill(Color.gray).shadow(radius: 3).cornerRadius(4.0))
                            }
                        }
                        else {
                            HStack {
                                Text(msg[range])
                                    .foregroundColor(Color.white)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                    .padding(.vertical, 3.0)
                                    .padding(.horizontal, 6.0)
                                    .background(Rectangle().fill(Color.green).shadow(radius: 3).cornerRadius(4.0))
                                Spacer()
                                    
                            }
                        }
                    }
                }
            }
        } .frame(width: 300, height: 400)
            .task {
                for _ in 1...2 {
                    profile.profileRefresh(email: profile.userInfo?.email ?? "")
                }
            }
    }
}

//struct MessageList_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageList(messages: <#T##[Messages]#>)
//    }
//}
