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
    
    @State private var image : Data? = .init(count: 0)
        
    @State private var showImage = false
    
    var body: some View {
        
        let jikanImage = UIImage(named: "logo")
        let jikanImagePngData = jikanImage?.pngData()
        
        VStack{
            Form{
                Section {
                    HStack {
                        Text("Upload image")
                        Spacer()
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
            self.rating = self.movie.rating
            self.review = self.movie.review ?? "-"
            self.image = self.movie.image ?? jikanImagePngData!
        }
        .onDisappear(perform: saveChanges)
        .navigationBarTitle("\(movie.name ?? "-")", displayMode: .inline)
    }
    func saveChanges() {
        movie.rating = rating
        movie.review = review
        movie.image = image
        
        try? self.moc.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.presentationMode.wrappedValue.dismiss()
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
