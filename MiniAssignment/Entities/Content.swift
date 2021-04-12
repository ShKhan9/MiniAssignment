//
//  Offer.swift
//  MiniAssignment
//
//  Created by Shehata Gamal on 4/9/21.
//

import Foundation
import ObjectMapper
 
// MARK: - Content
struct Content: Mappable {
    var image, title, desc, price: String!
    var currency,quantity: String!
    
    init?(map: Map) {}

   mutating func mapping(map: Map) {
        image <- map["image"]
        title <- map["title"]
        desc <- map["desc"]
        price <- map["price"]
        currency <- map["currency"]
        quantity <- map["quantity"]
    }
}


 
