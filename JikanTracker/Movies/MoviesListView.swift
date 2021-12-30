//
//  MoviesListView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import FirebaseAuth

struct MoviesListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Movie.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Movie.name, ascending: true),
        NSSortDescriptor(keyPath: \Movie.rating, ascending: true)
    ]) var movie: FetchedResults<Movie>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        
        let jikanImage = UIImage(named: "logo")
        let jikanImagePngData = jikanImage?.pngData()
        
        List{
            ForEach(movie,id: \.self){movie in
                if (Auth.auth().currentUser?.uid == movie.userUID) {
                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Image(uiImage: UIImage(data: movie.image ?? jikanImagePngData!)!)
                                    .resizable()
                                    .frame(width: 50, alignment: .center)
                                Text(movie.name ?? "Unknown")
                                    .font(.title)
                                Spacer()
                                VStack {
                                    Text("\(movie.rating)/10")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                            }
                        }
                        .frame(height: 50)
                    }                }
            }
            .onDelete(perform: removeMovies)
        }
        .navigationBarTitle("Movies")
        .listStyle(PlainListStyle())
        .navigationBarItems(trailing: HStack{
            EditButton().accentColor(.red);
            Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            }})
        .sheet(isPresented: $showingAddScreen) {
            AddMovieView().environment(\.managedObjectContext, self.moc)
        }
    }
    func removeMovies(at offsets: IndexSet) {
        for offset in offsets {
            let singleMovie = movie[offset]
            moc.delete(singleMovie)
        }
        try? moc.save()
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
