//
//  SwipeCard.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/25/22.
//

import SwiftUI

struct SwipeCard: View {
    
    var profile: PicnicProfile
    
    var body: some View {
        let image = UIImage(data: profile.picture)
        ZStack {
            Image(uiImage: image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 600)
            .shadow(radius: 10)
            VStack {
                Spacer()
                HStack {
                    Text(profile.name)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 5) .padding(.leading, 30)
                        .font(.system(size: 28))
                        .shadow(radius: 4)
                    Spacer()
                }
                HStack {
                    Text(profile.bio)
                        .foregroundColor(.white)
                        .padding(.leading, 30)
                        .padding(.bottom)
                        .shadow(radius: 4)
                    Spacer()
                } .padding([.bottom], 80)

                
            }
        }
    }
}

//struct SwipeCard_Previews: PreviewProvider {
////    @EnvironmentObject var guh: PicnicSurveyprofile:
////    static var previews: some View {
////        SwipeCard(profile: guh.userInfo!)
////             .environmentObject(PicnicSurvey())
////    }
//}
