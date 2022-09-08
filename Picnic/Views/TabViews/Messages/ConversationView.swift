//
//  ConversationView.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/27/22.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var profile: PicnicSurvey
    var match: PicnicProfile
    @State var pickupLine: PickupLine?
    @State var line = ""
    @State var messageList: [String]?
    @State var currentMsg = ""
    @State var messageSent = false
    
    var body: some View {
        VStack {
            let image = UIImage(data: match.picture)
            Image(uiImage: image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 4)
            Text(match.name)
                .font(.system(size: 14))
            MessageList(messages: messageList ?? [])
           Button ("Generate Pickup Line") {
                Task {
                await getLine()
                    currentMsg = line
                }
            }
            HStack {
                TextField("Type here...", text: $currentMsg)
                Button {
                    profile.updateConversation(user: match.email, msg: currentMsg)
                    messageList?.append("0\(currentMsg)")
                    currentMsg = ""
                    messageSent.toggle()
                } label: {
                    Image(systemName: "return")
                }
            }
        } .task(id: messageSent) {
            for _ in 1...4 {
                let newRef = match.email.replacingOccurrences(of: ".", with: ",")
                if messageList == nil {
                    messageList = profile.userInfo?.conversations[newRef] as? [String]
                }
                profile.profileRefresh(email: profile.userInfo?.email ?? "")
                print("messagelast\(messageList?.last)")
            }
        }
    }
    func getLine() async {
        do {
            let loadedLine = try await getPickupLine()
            pickupLine = loadedLine
            line = pickupLine?.line ?? ""
        }
        catch {
            
        }
    }
}

//struct ConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationView(match: <#T##PicnicProfile#>)
//    }
//}
