//
//  PicnicSurvey.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/24/22.
//

import Foundation
import Firebase

let COLLECTION_NAME = "Profiles"
let PAGE_LIMIT = 20


enum SurveyError: Error {
    case mismatchedDocumentError
    case unexpectedError
}

class PicnicSurvey: ObservableObject {
    private let db = Firestore.firestore()

    // Some of the iOS Firebase library’s methods are currently a little…odd.
    // They execute synchronously to return an initial result, but will then
    // attempt to write to the database across the network asynchronously but
    // not in a way that can be checked via try async/await. Instead, a
    // callback function is invoked containing an error _if it happened_.
    // They are almost like functions that return two results, one synchronously
    // and another asynchronously.
    //
    // To deal with this, we have a published variable called `error` which gets
    // set if a callback function comes back with an error. SwiftUI views can
    // access this error and it will update if things change.
    @Published var error: Error?
    @Published var userInfo: PicnicProfile?
    @Published var loading = true
    @Published var likes: [String]?
  //  @Published var profileList: [PicnicProfile]
    func createProfile(profile: PicnicProfile) {
        userInfo = profile
        // addDocument is one of those “odd” methods.
        db.collection(COLLECTION_NAME).document(profile.email).setData([
            "id": profile.id,
            "name": profile.name,
            "email": profile.email,
            "favDate": profile.favDate,
            "favTrait": profile.favTrait,
            "picture": profile.picture,
            "bio": profile.bio,
            "likes": profile.likes,
            "likedBy": profile.likedBy,
            "conversations": profile.conversations
            
        ]) { possibleError in
            if let actualError = possibleError {
                self.error = actualError
            }
        }
    }
    
    func checkProfiles(email: String) {
        loading = true
        let docRef = db.collection(COLLECTION_NAME).document(email)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                self.userInfo = PicnicProfile(
                    id: document.get("id") as? String ?? "",
                    name: document.get("name") as? String ?? "",
                    email: document.get("email") as? String ?? "",
                    favDate: document.get("favDate") as? String ?? "",
                    favTrait: document.get("favDate") as? String ?? "",
                    picture: document.get("picture") as? Data ?? Data(),
                    bio: document.get("bio") as? String ?? "",
                    likes: document.get("likes") as? [String] ?? [""],
                    likedBy: document.get("likedBy") as? [String] ?? [""],
                    conversations: document.get("conversations") as? [String: Any] ?? [:]
                    //conversations: [:]
                )
                print("Document data: \(dataDescription)")
                self.loading = false
            } else {
                print("Document does not exist")
                if email != "blank" {
                    self.loading = false
                }
            }
        }
    }
    
    func profileRefresh(email: String) {
        let docRef = db.collection(COLLECTION_NAME).document(email)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                self.userInfo = PicnicProfile(
                    id: document.get("id") as? String ?? "",
                    name: document.get("name") as? String ?? "",
                    email: document.get("email") as? String ?? "",
                    favDate: document.get("favDate") as? String ?? "",
                    favTrait: document.get("favDate") as? String ?? "",
                    picture: document.get("picture") as? Data ?? Data(),
                    bio: document.get("bio") as? String ?? "",
                    likes: document.get("likes") as? [String] ?? [""],
                    likedBy: document.get("likedBy") as? [String] ?? [""],
                    conversations: document.get("conversations") as? [String: Any] ?? [:]
                )
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func fetchProfiles() async throws -> [PicnicProfile] {
        let articleQuery = db.collection(COLLECTION_NAME)
        
        // Fortunately, getDocuments does have an async version.
        //
        // Firestore calls query results “snapshots” because they represent a…wait for it…
        // _snapshot_ of the data at the time that the query was made. (i.e., the content
        // of the database may change after the query but you won’t see those changes here)
        let querySnapshot = try await articleQuery.getDocuments()

        return try querySnapshot.documents.map {
            // This is likely new Swift for you: type conversion is conditional, so they
            // must be guarded in case they fail.
            guard let id = $0.get("id") as? String,
                  let name = $0.get("name") as? String,
                  let email = $0.get("email") as? String,
                  let favDate = $0.get("favDate") as? String,
                  let favTrait = $0.get("favTrait") as? String,
                  let bio = $0.get("bio") as? String,
                  let picture = $0.get("picture") as? Data,
                  let likes = $0.get("likes") as? [String],
                  let likedBy = $0.get("likedBy") as? [String],
                  let conversations = $0.get("conversations") as? [String: Any]
            
            else {
            throw SurveyError.mismatchedDocumentError
            }

            return PicnicProfile(
                id: id,
                name: name,
                email: email,
                favDate: favDate,
                favTrait: favTrait,
                picture: picture,
                bio: bio,
                likes: likes,
                likedBy: likedBy,
                conversations: conversations
            )
        }
    }
    
    func getLikes() {
        let personalRef = db.collection(COLLECTION_NAME).document(userInfo?.email ?? "blank")
        personalRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.likes = document.get("likes") as? [String] ?? [""]
            }
        }
    }
    
    func likeUser(user: String) {
        let userRef = db.collection(COLLECTION_NAME).document(user)
        var likedBy = [String]()
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                likedBy = document.get("likedBy") as? [String] ?? ["blank"]
                likedBy.append(self.userInfo?.email ?? "")
                userRef.updateData([
                    "likedBy": likedBy
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        }
        let personalRef = db.collection(COLLECTION_NAME).document(userInfo?.email ?? "blank")
        var likes = [String]()
        personalRef.getDocument { (document, error) in
            if let document = document, document.exists {
                likes = document.get("likes") as? [String] ?? [""]
                likes.append(user)
                personalRef.updateData([
                    "likes": likes
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        }
    }
    
    func updateConversation(user: String, msg: String) {
        let conversats = userInfo?.conversations
        let personalRef = db.collection(COLLECTION_NAME).document(userInfo?.email ?? "")
        let userRef = db.collection(COLLECTION_NAME).document(user)
        let dictRef = user.replacingOccurrences(of: ".", with: ",")
        let selfRef = self.userInfo?.email.replacingOccurrences(of: ".", with: ",")
//        if conversats?[dictRef] == nil {
//            personalRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    var conv = document.get("conversations") as? [String: Any] ?? [:]
//                    conv[dictRef] = []
//                    personalRef.updateData([
//                        "conversations": conv
//                    ]) { err in
//                        if let err = err {
//                            print("Error updating document: \(err)")
//                        } else {
//                            print("Document successfully updated")
//                        }
//                    }
//                }
//            }
//        }
        
        var convo = "conversations.\(dictRef)"
        print(convo)
        personalRef.updateData([
            convo: FieldValue.arrayUnion(["0\(msg)"])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                convo = "conversations.\(selfRef ?? "")"
                userRef.updateData([
                    convo: FieldValue.arrayUnion(["1\(msg)"])
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        self.profileRefresh(email: self.userInfo?.email ?? "")
                    }
                }
            }
        }
    }
    func setBio(user: String, text: String) {
        db.collection(COLLECTION_NAME).document(user).updateData([
            "bio": text
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
