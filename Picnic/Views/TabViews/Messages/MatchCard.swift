//
//  MatchCard.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/27/22.
//

import SwiftUI

struct MatchCard: View {
    @EnvironmentObject var profile: PicnicSurvey
    @State var match: PicnicProfile
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
        }
    }
}

//struct MatchCard_Previews: PreviewProvider {
//    @EnvironmentObject var profile: PicnicSurvey
//    static var previews: some View {
//        MatchCard(match: profile.userInfo!)
//            .environmentObject(PicnicSurvey())
//    }
//}
