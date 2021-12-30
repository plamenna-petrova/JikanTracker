//
//  AddTVShowView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import FirebaseAuth

struct AddTVShowView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var episodes = 0
    @State private var rating = 0
    @State private var review = ""
    @State private var type = ""
    
    let types = ["Watching", "On hold", "Dropped", "Completed", "ReWatching", "Plan to Watch"]
    
    let currentUserUID : String = (Auth.auth().currentUser?.uid)!
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name of TV Show", text: $name)
                    .disableAutocorrection(true)
                Section{
                    Picker("Select", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section{
                    HStack{
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
            .navigationBarItems(trailing: Button("Save") {
                let newTVShow = TVShow(context: self.moc)
                newTVShow.name = self.name
                newTVShow.episodes = Int16(self.episodes)
                newTVShow.rating = Int16(self.rating)
                newTVShow.review = self.review
                newTVShow.type = self.type
                newTVShow.date = Date()
                newTVShow.userUID = currentUserUID
                
                try? self.moc.save()
                
                self.presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddTVShowView_Previews: PreviewProvider {
    static var previews: some View {
        AddTVShowView()
    }
}
