//
//  ApiCall.swift
//  TMDBMovie
//
//  Created by Ahmad Ilyas on 27/06/21.
//

import Foundation
import Alamofire
import Combine

class ApiCall:Codable {
    static let host:String = "https://api.themoviedb.org/3/"
    static let imageHost:String = "https://image.tmdb.org/t/p/w300//"
    static let headers: HTTPHeaders = [
        .accept("application/json"),
        .authorization(bearerToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMjYzNTkyMTNmMWFmMTY4M2FkMGI2NmNjM2ZhNmE5YSIsInN1YiI6IjYwZDc2NDRhOTk3OWQyMDA3M2YxNjhkYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xgD0yiOzGvtBML4ZT1DWdFxibfcykcfsfxGGDedLDpY")
    ]
    
    func fetchMovie(genreID: String, completion:@escaping (GenreServices) -> ()) {
        guard let url = URL(string:"\(ApiCall.host)discover/movie?with_genres=\(genreID)&include_video=true") else { return }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        request.headers = ApiCall.headers
            
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                
                if let result = json["results"] {
                    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    do {
                        let movies = try! JSONDecoder().decode(GenreServices.self, from: jsonData)
                        
                        #if DEBUG
                            print(result)
                            print(movies.totalResults)
                        #endif
                        
                        completion(movies)
                    }catch{
                        
                        return
                    }
                }
                
            } catch {
                
                return
            }
            
        }
        .resume()
    }
    
    func fetchMovieDetail(movieID: String, completion:@escaping (MovieServices) -> ()) {
        guard let url = URL(string:"\(ApiCall.host)movie/\(movieID)") else { return }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        request.headers = ApiCall.headers
            
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                
                if let result = json["results"] {
                    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    do {
                        let movies = try! JSONDecoder().decode(MovieServices.self, from: jsonData)
                        
                        #if DEBUG
                            print(result)
                        #endif
                        
                        completion(movies)
                    }catch{
                        
                        return
                    }
                }
                
            } catch {
                
                return
            }
            
        }
        .resume()
    }
    
    func fetchMovieReviews(movieID: String, completion:@escaping (ReviewServices) -> ()) {
        guard let url = URL(string:"\(ApiCall.host)movie/\(movieID)/reviews") else { return }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        request.headers = ApiCall.headers
            
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                
                if let result = json["results"] {
                    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    do {
                        let reviews = try! JSONDecoder().decode(ReviewServices.self, from: jsonData)
                        
                        #if DEBUG
                            print(result)
                        #endif
                        
                        completion(reviews)
                    }catch{
                        
                        return
                    }
                }
                
            } catch {
                
                return
            }
            
        }
        .resume()
    }
}
