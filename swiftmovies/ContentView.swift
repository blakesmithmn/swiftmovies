//
//  ContentView.swift
//  swiftmovies
//
//  Created by Blake Smith on 3/23/23.
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
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movies, id: \.self) {movie in
                    HStack {
                        Image("")
                            .frame(width: 130, height: 70)
                            .background(Color.gray)
                        Text(movie.name)
                            .bold()
                    }
                    .padding(3)
                }
                
            }
            .navigationTitle("Movies")
            .onAppear {
                viewModel.fetchMovies()
            }
                    
                }
                
            }
    
           
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
