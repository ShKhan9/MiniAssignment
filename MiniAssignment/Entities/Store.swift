//
//  Offer.swift
//  MiniAssignment
//
//  Created by Shehata Gamal on 4/9/21.
//

import Foundation
import ObjectMapper
 
// MARK: - Store
struct Store: Mappable {
    var title: String!
    var content: [Content]!
    var filters: [String]!
    
    init?(map: Map) {}

     mutating func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
        filters <- map["filters"]
    }
}
 
