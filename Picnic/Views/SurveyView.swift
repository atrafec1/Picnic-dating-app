//
//  SurveyView.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/24/22.
//

import SwiftUI

struct SurveyView: View {
    @EnvironmentObject var auth: PicnicAuth
    @EnvironmentObject var profile: PicnicSurvey
    @Binding var profiles: [PicnicProfile]
    @State private var selectedDate = "Movie"
    @State private var selectedFeature = "Looks"
    @State var image: Image? = Image("karthick")
    @State var uiImage: UIImage?
    @State private var bio: String = ""
    let idealDates = ["Movie", "Dinner", "Coffee"]
    let favoriteFeatures = ["Looks", "Smarts", "Strength"]
    
    func submitSurvey() {
        let id = UUID().uuidString
        profile.createProfile(profile: PicnicProfile(
            id: id,
            name: auth.user?.displayName ?? "",
            email: auth.user?.email ?? "",
            favDate: selectedDate,
            favTrait: selectedFeature,
            picture: uiImage?.jpegData(compressionQuality: 0.25) ?? Data(),
            bio: bio,
            likes: [""],
            likedBy: [""],
            conversations: [:]
        ))
        
        profiles.append(PicnicProfile(
            id: id,
            name: auth.user?.displayName ?? "",
            email: auth.user?.email ?? "",
            favDate: selectedDate,
            favTrait: selectedFeature,
            picture: uiImage?.jpegData(compressionQuality: 0.25) ?? Data(),
            bio: bio,
            likes: [""],
            likedBy: [""],
            conversations: [:]
        ))
    }
    var body: some View {
        VStack {
            Text("Welcome to Picnic!")
                .font(.system(size: 40))
                .bold()
                .padding(.top)
            Text("Tell us a little more about yourself")
                .padding(.bottom)
            
            NavigationView {
                Form {
                    Section(header: Text("What do you want others to know about you?")) {
                        TextField("Type here...", text: $bio)
                    }
                    Section(header: Text("What's your ideal date?")) {
                        Picker("Favorite Date", selection: $selectedDate) {
                            ForEach(idealDates, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    Section(header: Text("What do you look for in a partner?")) {
                        Picker("What do you look for?", selection: $selectedFeature) {
                            ForEach(favoriteFeatures, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    Section(header: Text("Select your profile picture!")) {
                        ImageView(image: $image, uiImage: $uiImage)
                    }
                }
                .navigationTitle("About you...")
            
            }
            Button("Find your perfect partner") {
                submitSurvey()
                
            }
            Spacer()
        }
    }
}

//struct SurveyView_Previews: PreviewProvider {
//    static var previews: some View {
//        SurveyView(profiles: [])
//    }
//}
