//
//  AddMovieView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import FirebaseAuth

struct AddMovieView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var rating = 0
    @State private var review = ""
    
    let currentUserUID : String = (Auth.auth().currentUser?.uid)!
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Movie Name", text: $name)
                    .disableAutocorrection(true)
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
                let newMovie = Movie(context: self.moc)
                newMovie.name = self.name
                newMovie.date = Date()
                newMovie.rating = Int16(self.rating)
                newMovie.review = self.review
                newMovie.userUID = currentUserUID
                
                try? self.moc.save()
                
                self.presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieView()
    }
}
