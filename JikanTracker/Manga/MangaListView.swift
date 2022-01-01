//
//  MangaListView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import FirebaseAuth

struct MangaListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Manga.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Manga.name, ascending: true),
        NSSortDescriptor(keyPath: \Manga.chapters, ascending: true)
    ]) var manga: FetchedResults<Manga>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        
        let jikanImage = UIImage(named: "logo")
        let jikanImagePngData = jikanImage?.pngData()
        
        List{
            ForEach(manga,id: \.self){manga in
                if (Auth.auth().currentUser?.uid == manga.userUID) {
                    NavigationLink(destination: MangaDetailsView(manga: manga)) {
                        VStack(alignment: .leading){
                            HStack(alignment: .top) {
                                Image(uiImage: UIImage(data: manga.image ?? jikanImagePngData!)!)
                                        .resizable()
                                        .frame(width: 50)
                                Text(manga.name ?? "Unknown")
                                    .font(.title2)
                                Spacer()
                                VStack{
                                    Text("Ch \(manga.chapters)")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.secondary)
                                    HStack{
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Text("\(manga.rating)/10").font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        .frame(height: 50)
                    }                }
            }
            .onDelete(perform: removeManga)
        }
        .navigationBarTitle("Manga")
        .listStyle(PlainListStyle())
        .navigationBarItems(trailing: HStack{
            EditButton()
                .accentColor(.red)
            Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
                    .renderingMode(.template)
            }})
        .sheet(isPresented: $showingAddScreen) {
            AddMangaView().environment(\.managedObjectContext, self.moc)
        }
    }
    
    func removeManga(at offsets: IndexSet) {
        for offset in offsets{
            let singleManga = manga[offset]
            moc.delete(singleManga)
        }
        try? moc.save()
    }
}

struct MangaListView_Previews: PreviewProvider {
    static var previews: some View {
        MangaListView()
    }
}
