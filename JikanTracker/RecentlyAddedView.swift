//
//  RecentlyAddedView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//
import SwiftUI
import FirebaseAuth

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
        
        let currentUserUID = Auth.auth().currentUser?.uid
        
        let filteredManga = manga.filter({ $0.userUID == currentUserUID })
        let filteredAnime = anime.filter({ $0.userUID == currentUserUID })
        let filteredTVShows = tvShows.filter({ $0.userUID == currentUserUID })
        let filteredMovies = movies.filter({ $0.userUID == currentUserUID })
        
        List{
            Section(header:Text("Manga")){
                if filteredManga.count > 3 {
                    ForEach(filteredManga[0..<3],id: \.self){manga in
                            NavigationLink(destination: MangaDetailsView(manga: manga)) {
                                VStack(alignment: .leading) {
                                    HStack{
                                        Image(uiImage: UIImage(data: manga.image ?? Data())!)
                                            .resizable()
                                            .frame(width: 50, alignment: .center)
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
                    ForEach(filteredManga, id: \.self){manga in
                            NavigationLink(destination: MangaDetailsView(manga: manga)) {
                                VStack(alignment: .leading) {
                                    HStack{
                                        Image(uiImage: UIImage(data: manga.image ?? Data())!)
                                            .resizable()
                                            .frame(width: 50, alignment: .center)
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
                if filteredAnime.count > 3 {
                    ForEach(filteredAnime[0..<3],id: \.self){anime in
                            NavigationLink(destination: AnimeDetailsView(anime: anime)) {
                                VStack(alignment: .leading){
                                    HStack{
                                        Image(uiImage: UIImage(data: anime.image ?? Data())!)
                                            .resizable()
                                            .frame(width: 50, alignment: .center)
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
                    ForEach(filteredAnime, id: \.self){anime in
                            NavigationLink(destination: AnimeDetailsView(anime: anime)){
                                VStack(alignment: .leading){
                                    HStack{
                                        Image(uiImage: UIImage(data: anime.image ?? Data())!)
                                            .resizable()
                                            .frame(width: 50, alignment: .center)
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
                if filteredTVShows.count > 3 {
                    ForEach(filteredTVShows[0..<3],id: \.self){tvShow in
                            NavigationLink(destination: TVShowDetailsView(tvShow: tvShow)){
                                VStack(alignment: .leading){
                                    HStack{
                                        Image(uiImage: UIImage(data: tvShow.image ?? Data())!)
                                            .resizable()
                                            .frame(width: 50, alignment: .center)
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
                    ForEach(filteredTVShows, id: \.self){tvShow in
                            NavigationLink(destination: TVShowDetailsView(tvShow: tvShow)){
                                VStack(alignment: .leading){
                                    HStack{
                                        Image(uiImage: UIImage(data: tvShow.image ?? Data())!)
                                            .resizable()
                                            .frame(width: 50, alignment: .center)
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
                if filteredMovies.count > 3 {
                    ForEach(filteredMovies[0..<3],id: \.self){movie in
                            NavigationLink(destination: MovieDetailsView(movie: movie)){
                                VStack(alignment: .leading){
                                    HStack {
                                        Image(uiImage: UIImage(data: movie.image ?? Data())!)
                                            .resizable()
                                            .frame(width: 50, alignment: .center)
                                        Text(movie.name ?? "Unknown")
                                            .font(.title2)
                                        Spacer()
                                        VStack {
                                            Text("\(movie.rating)/10")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                            HStack(alignment: .center){
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.yellow)
                                                
                                            }
                                        }
                                    }
                                }
                                .frame(height: 50)
                            }
                    }
                }
                else{
                    ForEach(filteredMovies,id: \.self){movie in
                            NavigationLink(destination: MovieDetailsView(movie: movie)){
                                VStack(alignment: .leading){
                                    HStack {
                                        Image(uiImage: UIImage(data: movie.image ?? Data())!)
                                            .resizable()
                                            .frame(width: 50, alignment: .center)
                                        Text(movie.name ?? "Unknown")
                                            .font(.title2)
                                        Spacer()
                                        VStack {
                                            Text("\(movie.rating)/10")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                            HStack(alignment: .center){
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.yellow)
                                                
                                            }
                                        }
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
