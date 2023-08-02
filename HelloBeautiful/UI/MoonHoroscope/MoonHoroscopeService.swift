//
//  MoonHoroscopeService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.
//

import Foundation

protocol MoonHoroscopeServiceable {
    func fetchMoonDetails(completion: @escaping(Result<TopLevelDictionary,NetworkingError>) -> Void)
    func fetchHoroscope(sunSign:String,completion: @escaping(Result<Horoscope,NetworkingError>) -> Void) }
    
struct MoonHoroscopeService: APIDataProvidable, MoonHoroscopeServiceable {
    func fetchMoonDetails(completion: @escaping(Result<TopLevelDictionary,NetworkingError>) -> Void) {
        // compose URL
        guard let baseURL = URL(string:"https://moon-phase.p.rapidapi.com") else { return }
        var request = URLRequest(url: baseURL)
        request.setValue("fd66434d56mshe2585fcca18be24p15a830jsndea44508c3f9", forHTTPHeaderField:"X-RapidAPI-Key")
        request.httpMethod = "GET"
        request.url?.append(path:"advanced")
        print(request.url)
    // data task
        perform(request) { result in
            switch result {
            case.success(let moonData):
                do {
                    let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: moonData)
                    completion(.success(topLevelDictionary)); return
                } catch {
                    completion(.failure(.thrownError(error))); return
                }
            case .failure(_):
                completion(.failure(.unableToDecode))
            }
        }
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
        perform(request) { result in
            switch result {
            case.success(let horoscopeData):
                do {
                   let Horoscope = try JSONDecoder().decode(Horoscope.self, from: horoscopeData)
                            completion(.success(Horoscope)); return
                } catch {
                    completion(.failure(.thrownError(error))); return
                }
            case.failure(_):
                completion(.failure(.unableToDecode))
            } // switch
        }
    }
}
