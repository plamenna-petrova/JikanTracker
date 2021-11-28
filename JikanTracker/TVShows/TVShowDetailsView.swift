//
//  TVShowDetails.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import CoreData

struct TVShowDetailsView: View {
    @ObservedObject var tvShow: TVShow
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var episodes: Int16 = 0
    @State private var rating: Int16 = 0
    @State private var review = ""
    @State private var type = ""
    
    let types = ["Watching", "On hold", "Dropped", "Completed", "ReWatching", "Plan to Watch"]
    
    var body: some View {
        VStack{
            Form{
                Stepper(value: $episodes, step: 1){
                    Text("\(episodes) Episodes")
                }
                Section{
                    Stepper(value: $rating, in: 0...10, step: 1){
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(rating)")
                        }
                    }
                }
                Picker("Select", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 50, alignment: .center)
                Section{
                    Text("Review")
                    TextEditor(text: $review)
                        .frame(height: 170)
                        .disableAutocorrection(true)
                }
            }
        }
        .onAppear{
            self.episodes = self.tvShow.episodes
            self.rating = self.tvShow.rating
            self.type = self.tvShow.type ?? "-"
            self.review = self.tvShow.review ?? "-"
        }
        .onDisappear(perform: saveChanges)
        .navigationBarTitle("\(tvShow.name ?? "-")", displayMode: .inline)
    }
    func saveChanges() {
        tvShow.episodes = episodes
        tvShow.rating = rating
        tvShow.review = review
        tvShow.type = type
        try? self.moc.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct TVShowDetailsView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let tvShow = TVShow(context: moc)
        tvShow.name = "TV Show"
        tvShow.episodes = 0
        tvShow.rating = 0
        tvShow.type = "Watching"
        tvShow.review = "ok"
        
        return NavigationView{
            TVShowDetailsView(tvShow: tvShow)
        }
    }
}
