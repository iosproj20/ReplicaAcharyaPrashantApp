//
//  BookListModel.swift
//  ReplicaAcharyaPrashantApp
//
//  Created by Apple on 19/02/24.
//

import Foundation

// MARK: - BookListResponseModelElement
struct BookListResponseModelElement: Codable,Hashable {
    let id: String?
    let type: String?
    let title, subtitle: String?
    let language: String?
    let coverImage: String?
    let shortDescription: String?
    let amount: Int?
    let isUpcoming, isDraft: Bool?
    let pages: Int?
    let paperBookURL: String?
    let copiesTaken: Int?
    let showPaperBookInApp: Bool?
    let appleIAP: AppleIAP?
    let originalAmount: Int?
    
    func hash(into hasher: inout Hasher) {
           // Use one or more properties that uniquely identify instances of your struct
           hasher.combine(id)
           // Add other properties as needed
       }
  
      static func == (lhs: BookListResponseModelElement, rhs: BookListResponseModelElement) -> Bool {
          return lhs.id == rhs.id
  
              // Add other properties as needed
      }
}

// MARK: - AppleIAP
struct AppleIAP: Codable {
    let productID: String?
    let quantity: Int?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case quantity
    }
}



typealias BookListResponseModel = [BookListResponseModelElement]
