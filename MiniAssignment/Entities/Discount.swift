//
//  Offer.swift
//  MiniAssignment
//
//  Created by Shehata Gamal on 4/9/21.
//

import Foundation
import ObjectMapper
 
// MARK: - Discount
struct Discount: Mappable {
    var image, title, desc: String!
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
      image <- map["image"]
      title <- map["title"]
      desc <- map["desc"]
    }
}

 
