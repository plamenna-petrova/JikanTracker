//
//  AnimeList.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import Firebase

struct AnimeListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Anime.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Anime.name, ascending: true),
        NSSortDescriptor(keyPath: \Anime.episodes, ascending: true)
    ]) var anime: FetchedResults<Anime>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        List{
            ForEach(anime,id: \.self){anime in
                if (Auth.auth().currentUser?.uid == anime.userUID) {
                    NavigationLink(destination:
                                    AnimeDetailsView(anime: anime)) {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Text(anime.name ?? "Unknown")
                                    .font(.title)
                                Spacer()
                                VStack{
                                    Text("Ep \(anime.episodes)")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.secondary)
                                    HStack{
                                        Image(systemName: "star.fill").foregroundColor(.yellow)
                                        Text("\(anime.rating)/10")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        .frame(height: 50)
                    }                }
            }
            .onDelete(perform: removeAnime)
        }
        .navigationBarTitle("Anime")
        .listStyle(PlainListStyle())
        .navigationBarItems(trailing: HStack{
            EditButton().accentColor(.red); Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            }
        })
        .sheet(isPresented: $showingAddScreen) {
            AddAnimeView().environment(\.managedObjectContext, self.moc)
        }
    }
    
    func removeAnime(at offsets: IndexSet) {
        for offset in offsets{
            let singleAnime = anime[offset]
            moc.delete(singleAnime)
        }
        try? moc.save()
    }
}

struct AnimeListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeListView()
    }
}
