//
//  ContentView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import CoreData
import UIKit

struct CustomGroup:View {
    var img = ""
    var count = ""
    var color:Color
    var label = ""
    
    var body: some View{
        VStack{
            GroupBox(label:
            HStack{
                Text("\(Image(systemName: img))")
                    .foregroundColor(color)
                    .font(.title)
                Spacer()
                Text(count)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)
            }){
                VStack{
                    Text("")
                    HStack{
                        Text(label)
                            .font(.title2)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
            }.cornerRadius(15)
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Manga.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Manga.name, ascending: true),
        NSSortDescriptor(keyPath: \Manga.chapters, ascending: true)
    ]) var manga: FetchedResults<Manga>
    @FetchRequest(entity: Anime.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Anime.name, ascending: true),
        NSSortDescriptor(keyPath: \Anime.episodes, ascending: true)
    ]) var anime : FetchedResults<Anime>
    @FetchRequest(entity: TVShow.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \TVShow.name, ascending: true),
        NSSortDescriptor(keyPath: \TVShow.episodes, ascending: true)
    ]) var tvShows: FetchedResults<TVShow>
    @FetchRequest(entity: Movie.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Movie.name, ascending: true),
        NSSortDescriptor(keyPath: \Movie.rating, ascending: true)
    ]) var movies : FetchedResults<Movie>

    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    LazyVGrid(columns: [.init(), .init()]){
                        NavigationLink(destination: MangaListView()){
                            CustomGroup(img: "books.vertical", count: "\(manga.count)", color: Color.green, label: "Mangas")
                        }
                        NavigationLink(destination: AnimeListView()){
                            CustomGroup(img: "tv", count: "\(anime.count)", color: Color.red, label: "Anime")
                        }
                        NavigationLink(destination: TVShowsListView()){
                            CustomGroup(img: "play.tv", count: "\(tvShows.count)", color: Color.orange, label: "TV Shows")
                        }
                        NavigationLink(destination:
                            MoviesListView()) {
                            CustomGroup(img: "film", count: "\(movies.count)", color: Color.blue, label: "Movies")
                        }
                    }.padding()
                }
                .navigationTitle("Jikan Tracker Lists")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(ColorScheme.dark)
    }
}
