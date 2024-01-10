//
//  MoonService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation

#warning("Trust yourself.")

struct MoonService {

    func fetchMoonDetails(completion: @escaping(Result<TopLevelDictionary,NetworkingError>) -> Void) {
        
        guard let baseURL = URL(string:"https://moon-phase.p.rapidapi.com") else { return }
        var request = URLRequest(url: baseURL)
        request.setValue("fd66434d56mshe2585fcca18be24p15a830jsndea44508c3f9", forHTTPHeaderField:"X-RapidAPI-Key")
        request.httpMethod = "GET"
        request.url?.append(path:"advanced")
        print(request.url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                print("Oh no! Something went wrong.", error.localizedDescription)
                completion(.failure(.thrownError(error))); return
                
            }
            guard let moonData = data else {
                print("There was an error checking for Data")
                completion(.failure(.noData))
                return
            }
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: moonData)
                completion(.success(topLevelDictionary)); return
            } catch {
                completion(.failure(.unableToDecode)); return
            }
        
        }.resume()
        
        }
    
    func fetchHoroscope(sunSign:String,completion: @escaping(Result<Horoscope,NetworkingError>) -> Void) {
        
        guard let baseURL = URL(string:"https://horoscope-astrology.p.rapidapi.com") else { return }
        var request = URLRequest(url: baseURL)
        request.setValue("fd66434d56mshe2585fcca18be24p15a830jsndea44508c3f9", forHTTPHeaderField:"X-RapidAPI-Key")
        request.httpMethod = "GET"
        request.url?.append(path:"horoscope")
        let apiQueryItem = URLQueryItem(name:"day", value:"week")
        let apiQuerySecondItem = URLQueryItem(name:"sunsign", value: sunSign)
        request.url?.append(queryItems: [apiQueryItem,apiQuerySecondItem])
        print(request.url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                print("Oh no! Something went wrong.", error.localizedDescription)
                completion(.failure(.thrownError(error))); return
            }
        
            guard let horoscopeData = data else {
                print("There was an error checking for Data")
                completion(.failure(.noData))
                return
            }
            do {
               let Horoscope = try JSONDecoder().decode(Horoscope.self, from: horoscopeData)
                        completion(.success(Horoscope)); return
            } catch {
                completion(.failure(.unableToDecode)); return
            }
        
        }.resume()
    }

}
