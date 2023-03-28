//
//  ContentView.swift
//  giphytest
//
//  Created by Blake Smith on 3/28/23.
//

import SwiftUI

struct ContentView: View {
    @State var movieID = Int()
    @State var gifURL = String()
    @State var overview = String()
    @State var searchString = String()
    // @State var searchResults = [dataStructure]
    
    var body: some View {
        
//        List(searchResults) { movie in
//
//        }
        VStack {
            TextField("Search Movies", text: $searchString)
            Button("Search"){fetchAPI()}
            Text("\(gifURL)")
                .onTapGesture {
                    let url = URL(string: gifURL)
                    guard let GIPHYUrl = url, UIApplication.shared.canOpenURL(GIPHYUrl) else {
                        return
                    }
                    UIApplication.shared.open(GIPHYUrl)
                }
            Text("\(overview)")
            
        }
        .padding()
    }
    
    func fetchAPI(){

       
        let searchStringEncoded = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(searchStringEncoded)&page=1&include_adult=false")
        
        URLSession.shared.dataTask(with: url!){ data, response, error in
            if let data = data {
                if let decodedGiphy = try? JSONDecoder().decode(GIPHYStructure.self , from: data){
                    self.gifURL = decodedGiphy.results[0].title
                    self.overview = decodedGiphy.results[0].overview
                    self.movieID = decodedGiphy.results[0].id
                }
            }
        }.resume()
    }
}


struct GIPHYStructure: Codable {
    let results: [dataStructure]
}

struct dataStructure: Codable {
    let id: Int
    let title: String
    let overview: String
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
