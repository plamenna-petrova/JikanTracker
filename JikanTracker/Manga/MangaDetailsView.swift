//
//  MangaDetailsView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import CoreData

struct MangaDetailsView: View {
    @ObservedObject var manga: Manga
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var chapters: Int16 = 0
    @State private var rating: Int16 = 0
    @State private var review = ""
    @State private var type = ""
    
    @State private var image : Data? = .init(count: 0)
        
    @State private var showImage = false
    
    let types = ["Reading", "On hold", "Dropped", "Completed", "Rereading", "Plan to read"]
    
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
                Stepper(value: $chapters, step: 1) {
                    Text("\(chapters) Chapters")
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
                Picker("Select", selection: $type){
                    ForEach(types, id: \.self){
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
            self.chapters = self.manga.chapters
            self.rating = self.manga.rating
            self.type = self.manga.type ?? "-"
            self.review = self.manga.review ?? "-"
            self.image = self.manga.image ?? jikanImagePngData!
        }
        .onDisappear(perform: saveChanges)
        .navigationBarTitle("\(manga.name ?? "-")", displayMode: .inline)
    }
    func saveChanges() {
        manga.chapters = chapters
        manga.rating = rating
        manga.review = review
        manga.type = type
        manga.image = image
        try? self.moc.save()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.presentationMode.wrappedValue.dismiss()
        }
    }
 }

struct MangaDetailsView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let manga = Manga(context: moc)
        manga.name = "Manga"
        manga.chapters = 0
        manga.rating = 0
        manga.type = "reading"
        manga.review = "ok"
        
        return NavigationView {
            MangaDetailsView(manga: manga)
        }
    }
}
