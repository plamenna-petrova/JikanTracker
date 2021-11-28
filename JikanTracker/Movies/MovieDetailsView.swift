//
//  MovieDetailsView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import CoreData

struct MovieDetailsView: View {
    @ObservedObject var movie: Movie
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var rating: Int16 = 0
    @State private var review = ""
    
    var body: some View {
        VStack{
            Form{
                Section{
                    Stepper(value: $rating, in: 0...10, step: 1) {
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(rating)")
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
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let movie = Movie(context: moc)
        movie.name = "Movie"
        movie.rating = 0
        movie.review = "ok"
        
        return NavigationView {
            MovieDetailsView(movie: movie)
        }
    }
}
