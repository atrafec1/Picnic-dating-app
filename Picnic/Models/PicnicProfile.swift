//
//  PicnicProfile.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/24/22.
//

import Foundation
import SwiftUI

struct PicnicProfile: Equatable, Identifiable {
    static func == (lhs: PicnicProfile, rhs: PicnicProfile) -> Bool {
        lhs.email == rhs.email
    }
    
    var id: String
    var name: String
    var email: String
    var favDate: String
    var favTrait: String
    var picture: Data
    var bio: String
    var likes: [String]
    var likedBy: [String]
    var conversations: [String: Any]
}

struct Conversation: Hashable, Codable {
    var messages: [Messages]
    var name: String
}

struct Messages: Hashable, Codable {
    var body: String
    var name: String
}

struct Message {
    var com: [String]
}
