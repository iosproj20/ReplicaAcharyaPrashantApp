//
//  NetworkManager.swift
//  YogPath
//
//  Created by Apple on 05/09/23.
//

import Foundation
import Combine
import SwiftUI
import Alamofire


enum NetworkError:LocalizedError, Error {
    case unknown
    case unAuthoried
    case unknowError(statusCode:Int)
    case offline
}

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    private var cancellables = Set<AnyCancellable>()
    
    
    func getAPI<T:Decodable>(apiUrl:String,completion:@escaping(Result<T,Error>) -> ()){
        print(apiUrl)
        guard let url = URL(string:apiUrl) else {
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }
                if 200..<300 ~= httpResponse.statusCode {
                    return data
                } else {
                    if httpResponse.statusCode == 401 {
                        throw NetworkError.unAuthoried
                    }else{
                        print(httpResponse.statusCode)
                        throw NetworkError.unknowError(statusCode: httpResponse.statusCode)
                    }
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    if let nsError = error as NSError?, nsError.domain == NSURLErrorDomain {
                        if nsError.code == NSURLErrorNotConnectedToInternet {
                            completion(.failure(NetworkError.offline))
                        }
                    } else {
                        completion(.failure(error))
                    }
                }
            }, receiveValue: { response in
                completion(.success(response))
            })
            .store(in: &cancellables)
    }
}
