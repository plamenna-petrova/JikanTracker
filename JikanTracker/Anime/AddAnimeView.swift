//
//  AddAnime.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI

struct AddAnimeView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var episodes = 0
    @State private var rating = 0
    @State private var review = ""
    @State private var type = ""
    
    let types = ["Watching", "On hold", "Dropped", "Completed", "ReWatching", "Plan to Watch"]
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Name of Anime", text: $name)
                    .disableAutocorrection(true)
                // Watching status
                Section {
                    Picker("Select", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                }
                // Episodes
                Section {
                    HStack {
                        Text("Episodes")
                            .font(.headline)
                        Spacer()
                        Picker("Episodes", selection: $episodes) {
                            ForEach(0..<2000){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 40, alignment: .center)
                        .clipped()
                        .compositingGroup()
                    }
                }
                // Rating
                Section {
                    Picker("Rating", selection: $rating) {
                        ForEach(0..<11) {i in
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(" \(i)")
                            }
                        }
                    }
                }
                // Review
                Section {
                    Text("Review")
                    TextEditor(text: $review)
                        .frame(height: 170)
                        .disableAutocorrection(true)
                }
            }
            .navigationBarItems(trailing:
              Button("Save") {
                let newAnime = Anime(context: self.moc)
                newAnime.name = self.name
                newAnime.type = self.type
                newAnime.episodes = Int16(self.episodes)
                newAnime.rating = Int16(self.rating)
                newAnime.review = self.review
                newAnime.date = Date()
                try? self.moc.save()
                
                self.presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddAnimeView_Previews: PreviewProvider {
    static var previews: some View {
        AddAnimeView()
    }
}
