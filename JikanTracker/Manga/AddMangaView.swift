//
//  AddMangaView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import FirebaseAuth

struct AddMangaView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var chapters = 0
    @State private var rating = 0
    @State private var review = ""
    @State private var type = ""
    
    @State private var image : Data? = .init(count: 0)
    
    @State private var showImage = false
    
    let types = ["Reading", "On hold", "Dropped", "Completed", "Rereading", "Plan to read"]
    
    let currentUserUID : String = (Auth.auth().currentUser?.uid)!
    
    var body: some View {
        
        let jikanImage = UIImage(named: "logo")
        let jikanImagePngData = jikanImage?.pngData()
        
        NavigationView {
            Form {
                TextField("Manga Name", text: $name)
                    .disableAutocorrection(true)
                Section {
                    if self.image?.count != 0 {
                        Button(action: {
                            self.showImage.toggle()
                        }) {
                            Image(uiImage: UIImage(data: self.image!)!)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .leading)
                        }
                    } else {
                        Button(action: {
                            self.showImage.toggle()
                        }) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                        }
                    }
                }
                Section {
                    Picker("Select", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section{
                    HStack{
                        Text("Chapters")
                            .font(.headline)
                        Spacer()
                        Picker("Chapters", selection: $chapters) {
                            ForEach(0..<2000) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 40, alignment: .center)
                        .clipped()
                        .compositingGroup()
                    }
                }
                Section{
                    Picker("Rating", selection: $rating){
                        ForEach(0..<11){i in
                            HStack{
                                Image(systemName: "star.fill").foregroundColor(.yellow)
                                Text(" \(i)")
                            }
                        }
                    }
                }
                Section{
                    Text("Review")
                    TextEditor(text: $review)
                        .frame(height: 170)
                        .disableAutocorrection(true)
                }
            }
            .navigationBarItems(trailing:
                Button("Save") {
                let newManga = Manga(context: self.moc)
                newManga.name = self.name
                newManga.image = self.image ?? jikanImagePngData
                newManga.chapters = Int16(self.chapters)
                newManga.rating = Int16(self.rating)
                newManga.review = self.review
                newManga.type = self.type
                newManga.date = Date()
                newManga.userUID = currentUserUID
                
                try? self.moc.save()
                
                self.presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: self.$showImage, content: {
                ImagePicker(show: self.$showImage, image: self.$image)
            })
        }
    }
}

struct AddMangaView_Previews: PreviewProvider {
    static var previews: some View {
        AddMangaView()
    }
}
