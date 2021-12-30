//
//  AnimeDetailsView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import CoreData

struct AnimeDetailsView: View {
    
    @ObservedObject var anime: Anime
    
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var episodes: Int16 = 0
    @State private var rating: Int16 = 0
    @State private var review = ""
    @State private var type = ""
    
    @State private var image : Data? = .init(count: 0)
    
    @State private var showImage = false
    
    let types = ["Watching", "On hold", "Dropped", "Completed", "ReWatching", "Plan to Watch"]
    
    var body: some View {
        
        let jikanImage = UIImage(named: "logo")
        let jikanImagePngData = jikanImage?.pngData()
        
        VStack{
            Form{
                Section {
                    if self.image?.count != 0 {
                        Button(action: {
                            self.showImage.toggle()
                        }) {
                            Image(uiImage: UIImage(data: self.image!)!)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 75, height: 75)
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
                Stepper(value: $episodes, step: 1) {
                    Text("\(episodes) Episodes")
                }
                Section{
                    Stepper(value: $rating, in: 0...10, step: 1) {
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
            .sheet(isPresented: self.$showImage, content: {
                ImagePicker(show: self.$showImage, image: self.$image)
            })
        }
        .onAppear{
            self.episodes = self.anime.episodes
            self.rating = self.anime.rating
            self.type = self.anime.type ?? "-"
            self.review = self.anime.review ?? "-"
            self.image = self.anime.image ?? jikanImagePngData!
        }
        .onDisappear(perform: saveChanges)
        .navigationBarTitle("\(anime.name ?? "-")", displayMode: .inline)
    }
    
    func saveChanges() {
        anime.episodes = episodes
        anime.rating = rating
        anime.review = review
        anime.type = type
        anime.image = image
        try? self.moc.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct AnimeDetailsView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let anime = Anime(context: moc)
        anime.name = "Anime"
        anime.episodes = 0
        anime.rating = 0
        anime.type = "Watching"
        anime.review = "ok"
        
        return NavigationView {
            AnimeDetailsView(anime: anime)
        }
    }
}
