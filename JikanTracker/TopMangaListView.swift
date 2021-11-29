//
//  TopMangaListView.swift
//  JikanTracker
//
//  Created by Plamenna Petrova on 11/28/21.
//

import SwiftUI

struct TopMangaData: Codable {
    
    var top: [TopManga]
    
}
struct TopManga: Codable {
    var title: String
    var rank: Int

    var score: Double
    var startDate: String
}

struct TopMangaListView: View {
    @State var isNavigationBarHidden: Bool = true
    @State private var results = [TopManga]()
    var body: some View {
        
        List(results, id: \.rank) { item in
            VStack(alignment: .leading){
                
                HStack {
                    Text("\(item.rank).")
                    Text("\(item.title)")
                        .font(.title2)
                        .foregroundColor(.orange)
                }
                Text("     Aired \(item.startDate)")
                Text("     Rating \(String(item.score))")
                    .foregroundColor(.secondary)
                
                
            }.navigationBarTitle("Top Manga",displayMode: .inline)
        }
        .onAppear(perform: topManga)
    }
    func topManga(){
        guard let url = URL(string: "https://api.jikan.moe/v3/top/manga/1") else {
            print("error")
            return
        }
       
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                if let decodedResponse = try? JSONDecoder().decode(TopMangaData.self, from: data){
                    DispatchQueue.main.async {
                        self.results = decodedResponse.top
                        
                    }
                }
                return
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
}

struct TopMangaListView_Previews: PreviewProvider {
    static var previews: some View {
        TopMangaListView()
    }
}
