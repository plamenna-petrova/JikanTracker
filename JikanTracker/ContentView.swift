//
//  ContentView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI
import FirebaseAuth
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

struct JikanTrackerView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
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
    
    let userEmail : String = (Auth.auth().currentUser?.email)!
    
    var body: some View {
            
        let filteredAnime = anime.filter({ $0.userUID == Auth.auth().currentUser?.uid})
        
            ScrollView{
                VStack{
                    Text("Hi, \(userEmail)")
                    LazyVGrid(columns: [.init(), .init()]){
                        NavigationLink(destination: MangaListView()){
                            CustomGroup(img: "books.vertical", count: "\(manga.count)", color: Color.green, label: "Mangas")
                        }
                        NavigationLink(destination: AnimeListView()){
                            CustomGroup(img: "tv", count: "\(filteredAnime.count)", color: Color.red, label: "Anime")
                        }
                        NavigationLink(destination: TVShowsListView()){
                            CustomGroup(img: "play.tv", count: "\(tvShows.count)", color: Color.orange, label: "TV Shows")
                        }
                        NavigationLink(destination:
                            MoviesListView()) {
                            CustomGroup(img: "film", count: "\(movies.count)", color: Color.blue, label: "Movies")
                        }
                    }.padding()
                    Form{
                        HStack{
                            NavigationLink(destination: RecentlyAddedView()){
                                Label(
                                    title: {
                                        Text("Recently Added")
                                            .font(.title2)
                                    },
                                    icon: {
                                        Image(systemName: "list.bullet")
                                            .padding(9)
                                            .font(.title2)
                                            .background(Color.orange)
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                    }
                                )
                            }
                        }.padding(5)
                    }.frame(height: 125)
                    VStack{
                        LazyVGrid(columns: [.init(), .init()]) {
                            NavigationLink(destination: TopMangaListView()) {
                                CustomGroup(img: "book", color: Color.green, label: "Top Manga")
                            }
                            NavigationLink(destination: TopAnimeListView()) {
                                CustomGroup(img: "play", color: Color.yellow, label: "Top anime")
                            }
                        }.padding()
                    }
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sign Out")
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .padding()
                    })                }
                .navigationTitle("Jikan Tracker Lists")
            }
        }
}

class AppViewModel : ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
           
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
    
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                JikanTrackerView()
            } else {
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack {
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        viewModel.signIn(email: email, password: password)
                        
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    .padding()
                    
                    NavigationLink("Create Account", destination: SignUpView())
                        .padding()
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Sign In")
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack {
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        viewModel.signUp(email: email, password: password)
                        
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    .padding()
                    
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Create Account")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(ColorScheme.dark)
    }
}
