//
//  ImageView.swift
//  Picnic
//
//  Created by Hunter Krasa on 4/25/22.
//

import SwiftUI

struct ImageView: View {
    @Binding var image: Image?
    @Binding var uiImage: UIImage?
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    var body: some View {
        // WARNING: Force wrapped image for demo purpose
        image?
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .onTapGesture { self.shouldPresentActionScheet = true }
            .sheet(isPresented: $shouldPresentImagePicker) {
                SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, uiImage: $uiImage, isPresented: self.$shouldPresentImagePicker)
        }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
            ActionSheet(title: Text("Set your profile image"), buttons: [ActionSheet.Button.default(Text("Take photo"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = true
            }), ActionSheet.Button.default(Text("Choose from library"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = false
            }), ActionSheet.Button.cancel()])
        }
    }
}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var image: Image? = Image("karthick")
//        ImageView(image: $image)
//    }
//}
