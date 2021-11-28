//
//  TVShowsListView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI

struct TVShowsListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: TVShow.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \TVShow.name, ascending: true),
        NSSortDescriptor(keyPath: \TVShow.episodes, ascending: true)
    ]) var tvShow: FetchedResults<TVShow>
    
    @State private var showingAddScreen = false
    
    var body: some View{
        List{
            ForEach(tvShow,id: \.self){tvShow in
                NavigationLink(destination: TVShowDetailsView(tvShow: tvShow)){
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text(tvShow.name ?? "Unknown")
                                .font(.title)
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
                    .frame(height: 50)
                }
            }
            .onDelete(perform: removeTVShows)
        }
        .navigationBarTitle("TV Shows")
        .listStyle(PlainListStyle())
        .navigationBarItems(trailing: HStack{
            EditButton().accentColor(.red);
            Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            }})
        .sheet(isPresented: $showingAddScreen) {
            AddTVShowView().environment(\.managedObjectContext, self.moc)
        }
    }
    func removeTVShows(at offsets: IndexSet) {
        for offset in offsets{
            let singleTVShow = tvShow[offset]
            moc.delete(singleTVShow)
        }
        try? moc.save()
    }
}

struct TVShowsListView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowsListView()
    }
}
