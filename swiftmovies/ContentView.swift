//
//  ContentView.swift
//  giphytest
//
//  Created by Blake Smith on 3/28/23.
//

import SwiftUI



// the template for how data is being decoded
struct Movie: Hashable, Codable {
    let id: Int
    let title: String
    let overview: String
    let image: String
}

// variables that need to be removed
let apiKey = 
let search = "us"

// GET request to API


class ViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    func fetchMovies(){
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(search)&page=1&include_adult=false")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // CONVERT TO JSON
            do {
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                DispatchQueue.main.async{
                    self?.movies = movies
                }
            }
            catch {
                print(error)
            }
            
        }
        task.resume()

    }
}


struct ContentView: View {
    @State var movieID = Int()
    @State var gifURL = String()
    @State var overview = String()
    @State var searchString = String()
    // @State var searchResults = [dataStructure]
    
    var body: some View {
        VStack {
            TextField("Search Movies", text: $searchString)
            Button("Search"){fetchAPI()}
            Text("\(movieID)")
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
//        let apiKey = "Cv2JmBmYxh5VCXLiub2qytt0lLqTijcv"
//        let url = URL(string: "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(self.searchString)&limit=25&offset=0&rating=g&lang=en")
        let apiKey = 
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
