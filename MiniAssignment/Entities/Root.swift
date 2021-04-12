//
//  Offer.swift
//  MiniAssignment
//
//  Created by Shehata Gamal on 4/9/21.
//

import Foundation
import ObjectMapper
 
// MARK: - Root
struct Root: Mappable {
    var discounts: [Discount]!
    var store: [Store]!
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        discounts <- map["discounts"]
        store <- map["store"]
    }
}
 
