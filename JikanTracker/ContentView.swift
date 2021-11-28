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
    @FetchRequest(entity: Anime.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Anime.name, ascending: true),
        NSSortDescriptor(keyPath: \Anime.episodes, ascending: true)
    ]) var anime : FetchedResults<Anime>

    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    LazyVGrid(columns: [.init(), .init()]){
                        NavigationLink(destination: AnimeListView()){
                            CustomGroup(img: "tv", count: "\(anime.count)", color: Color.red, label: "Anime")
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
        ContentView().preferredColorScheme(.dark)
    }
}
