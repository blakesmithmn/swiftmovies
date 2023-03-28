//
//  MovieAPI.swift
//  swiftmovies
//
//  Created by Blake Smith on 3/28/23.
//

import Foundation

final class MovieAPI: ObservableObject {
    
    static let shared = MovieAPI()
    
    func searchMovieAPI() {
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=c41679c7f7f63e2c04429409ac131884&language=en-US&query=spirited away&page=1&include_adult=false"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
           
            guard let data = data else {
                print("data was nil")
                return
            }
            
            guard let movieList = try? JSONDecoder().decode(SearchResults.self, from: data) else {
                print("couldn't decode JSON")
                return
            }
            
            print(movieList.results)
        }
        task.resume()
    }
    
}

struct SearchResults: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String?
    let id: Int?
    let overview: String?
    let poster_path: String?
}

// example reponse for a search for 'spirited away'


//{
//    "page": 1,
//    "results": [
//        {
//            "adult": false,
//            "backdrop_path": "/Ab8mkHmkYADjU7wQiOkia9BzGvS.jpg",
//            "genre_ids": [
//                16,
//                10751,
//                14
//            ],
//            "id": 129,
//            "original_language": "ja",
//            "original_title": "千と千尋の神隠し",
//            "overview": "A young girl, Chihiro, becomes trapped in a strange new world of spirits. When her parents undergo a mysterious transformation, she must call upon the courage she never knew she had to free her family.",
//            "popularity": 108.549,
//            "poster_path": "/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg",
//            "release_date": "2001-07-20",
//            "title": "Spirited Away",
//            "video": false,
//            "vote_average": 8.54,
//            "vote_count": 14099
//        },
//        {
//            "adult": false,
//            "backdrop_path": "/3or4Lkg4EMWDV4oJKXSEfYsCBF3.jpg",
//            "genre_ids": [
//                18,
//                12,
//                10751,
//                14
//            ],
//            "id": 1001196,
//            "original_language": "ja",
//            "original_title": "千と千尋の神隠し",
//            "overview": "A young girl named Chihiro finds herself trapped in a mysterious world inhabited by spirits and when her parents are turned into pigs, she must rescue them. The movie version of the stage production was filmed during the play’s 2022 run at the Imperial Theatre in Tokyo.",
//            "popularity": 3.933,
//            "poster_path": "/iBy25orrkB1hjYNLCXdzMfXqWXR.jpg",
//            "release_date": "2023-04-23",
//            "title": "Spirited Away: Live on Stage",
//            "video": true,
//            "vote_average": 0.0,
//            "vote_count": 0
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [
//                99,
//                16
//            ],
//            "id": 698296,
//            "original_language": "en",
//            "original_title": "The Art of 'Spirited Away'",
//            "overview": "The people that brought the film Sen to Chihiro no kamikakushi (2001) (a.k.a. \"Spirited Away\") to the US explain how it was converted into English, with some minor confusion between languages, and how well it did in both Japan and America.",
//            "popularity": 1.409,
//            "poster_path": "/x1iaVnI4mTaETwAKTLyIAKFwQSJ.jpg",
//            "release_date": "2003-04-15",
//            "title": "The Art of 'Spirited Away'",
//            "video": false,
//            "vote_average": 8.0,
//            "vote_count": 2
//        }
//    ],
//    "total_pages": 1,
//    "total_results": 3
//}
