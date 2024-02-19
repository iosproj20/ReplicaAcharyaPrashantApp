//
//  BookListDataSource.swift
//  ReplicaAcharyaPrashantApp
//
//  Created by Apple on 19/02/24.
//

import Foundation
import SwiftUI
import Combine


class BookListViewModel:ObservableObject{
    
    @Published var dataResponse:BookListResponseModel?
    
    func fetchData(completion:@escaping(Result<Bool,Error>)->Void){
        let apiUrl = APIConstant.shared.baseUrl + ApiType.getBooksData.rawValue 
        print(apiUrl)
        
        NetworkingManager.shared.getAPI(apiUrl:apiUrl) { (response:Result<BookListResponseModel,Error>) in
            switch response {
            case .success(let data):
                self.dataResponse = data
                print(self.dataResponse as Any)
                completion(.success(false))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
