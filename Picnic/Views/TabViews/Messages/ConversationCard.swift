//
//  ConversationCard.swift
//  Picnic
//
//  Created by Hunter Krasa on 5/1/22.
//

import SwiftUI
import Firebase

struct ConversationCard: View {
//    @State var email: String
//    @State var lastMsg: [String]
    @State var prof: PicnicProfile
//    @State var image: Data = Data()
//    @State var name = "Blank"
//    @State var fetching = true
    var body: some View {
            HStack {
                Image(uiImage: UIImage(data: prof.picture) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 4)
                VStack {
                    HStack {
                        Text(prof.name)
                            .bold()
                        Spacer()
                    }
//                    HStack {
//                        Text(lastMsg.last ?? "")
//                        Spacer()
//                    }
                }
            }
            .task {
//                fetching = true
//                let db = Firestore.firestore()
//                print("fuck     \(email)")
//                let docRef = db.collection("Profiles").document(email)
//
//                docRef.getDocument { (document, error) in
//                    if let document = document, document.exists {
//                        image = document.get("picture") as? Data ?? Data()
//                        name = document.get("name") as? String ?? ""
//                        fetching = false
//                    } else {
//                        print("Document does not exist")
//                        fetching = false
//                    }
//                }
            
        }
    }
}

//struct ConversationCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationCard(email: "", lastMsg: ["Last message"])
//    }
//}
