//
//  RecentlyAddedView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI

struct RecentlyAddedView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Manga.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Manga.date, ascending: false)
    ]) var manga: FetchedResults<Manga>
    @FetchRequest(entity: Anime.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Anime.date, ascending: false)
    ]) var anime: FetchedResults<Anime>
    @FetchRequest(entity: TVShow.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \TVShow.date, ascending: false)
    ]) var tvShows: FetchedResults<TVShow>
    @FetchRequest(entity: Movie.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Movie.date, ascending: false)
    ]) var movies: FetchedResults<Movie>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        List{
            Section(header:Text("Manga")){
                if manga.count > 3 {
                    ForEach(manga[0..<3],id: \.self){manga in
                        NavigationLink(destination: MangaDetailsView(manga: manga)) {
                            VStack(alignment: .leading) {
                                HStack{
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
                                            Text("\(manga.rating)/10")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .frame(height: 40)
                        }
                    }
                }
                else {
                    ForEach(manga, id: \.self){manga in
                        NavigationLink(destination: MangaDetailsView(manga: manga)) {
                            VStack(alignment: .leading) {
                                HStack{
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
                                            Text("\(manga.rating)/10")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .frame(height: 40)
                        }
                    }
                }
            }
            Section(header:Text("Anime")){
                if anime.count > 3 {
                    ForEach(anime[0..<3],id: \.self){anime in
                        NavigationLink(destination: AnimeDetailsView(anime: anime)) {
                            VStack(alignment: .leading){
                                HStack{
                                    Text(anime.name ?? "Unknown")
                                        .font(.title2)
                                    Spacer()
                                    VStack{
                                        Text("Ep \(anime.episodes)")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.secondary)
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\(anime.rating)/10")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .frame(height: 40)
                        }
                    }
                }
                else{
                    ForEach(anime, id: \.self){anime in
                        NavigationLink(destination: AnimeDetailsView(anime: anime)){
                            VStack(alignment: .leading){
                                HStack{
                                    Text(anime.name ?? "Unknown")
                                        .font(.title2)
                                    Spacer()
                                    VStack{
                                        Text("Ep \(anime.episodes)")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.secondary)
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\(anime.rating)/10")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .frame(height: 40)
                        }
                    }
                }
            }
            Section(header:Text("TV Shows")){
                if tvShows.count > 3 {
                    ForEach(tvShows[0..<3],id: \.self){tvShow in
                        NavigationLink(destination: TVShowDetailsView(tvShow: tvShow)){
                            VStack(alignment: .leading){
                                HStack{
                                    Text(tvShow.name ?? "Unknown")
                                        .font(.title2)
                                    Spacer()
                                    VStack{
                                        Text("Ep \(tvShow.episodes)")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.secondary)
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\(tvShow.rating)/10")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .frame(height: 40)
                        }
                    }
                }
                else {
                    ForEach(tvShows,id: \.self){tvShow in
                        NavigationLink(destination: TVShowDetailsView(tvShow: tvShow)){
                            VStack(alignment: .leading){
                                HStack{
                                    Text(tvShow.name ?? "Unknown")
                                        .font(.title2)
                                    Spacer()
                                    VStack{
                                        Text("Ep \(tvShow.episodes)")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.secondary)
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\(tvShow.rating)/10")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .frame(height: 40)
                        }
                    }
                }
            }
            Section(header:Text("Movies")){
                if movies.count > 3 {
                    ForEach(movies[0..<3],id: \.self){movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie)){
                            VStack(alignment: .leading){
                                Text(movie.name ?? "Unknown")
                                    .font(.title2)
                                Spacer()
                                HStack(alignment: .center){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text("\(movie.rating)/10")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .frame(height: 50)
                        }
                    }
                }
                else{
                    ForEach(movies,id: \.self){movie in
                        NavigationLink(destination: MovieDetailsView(movie: movie)){
                            VStack(alignment: .leading){
                                Text(movie.name ?? "Unknown")
                                    .font(.title2)
                                Spacer()
                                HStack(alignment: .center){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text("\(movie.rating)/10")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .frame(height: 50)
                        }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Recently Added")
    }
}

struct RecentlyAddedView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyAddedView()
    }
}
