//
//  GetAll.swift
//  MiniAssignment
//
//  Created by Shehata Gamal on 4/9/21.
//

import Foundation 
import Moya

public enum Marvel {
  // 1
  static private let publicKey = "YOUR PUBLIC KEY"
  static private let privateKey = "YOUR PRIVATE KEY"

  // 2
  case getAll
}

extension Marvel: TargetType {
  // 1
  public var baseURL: URL {
    return URL(string: "https://gateway.dindinn.com/v1/public")!
  }

  // 2
  public var path: String {
    switch self {
    case .getAll: return "/getAll"
    }
  }

  // 3
  public var method: Moya.Method {
    switch self {
    case .getAll: return .get
    }
  }

  // 4
  public var sampleData: Data {
    let response = """
    {
       "discounts":[{ "image":"off1","title":"Saturday discount","desc":"coca-cola as a gift to any other"},{ "image":"off2","title":"Tuesday discount","desc":"Every tuesday there is a free drink to order"},{ "image":"off3","title":"Monday discount","desc":"Roll as a gift to any set of sushi"}],
       "store":[

       {"title":"Pizza","content":
       [
          {"image":"pizza1","title":"Deluxe 1","desc":"chickehn ham speciy 1","price":"46","currency":"USD","quantity":"150 grams 93cm"},
          {"image":"pizza2","title":"Deluxe 2","desc":"chickehn ham speciy 2","price":"77","currency":"USD","quantity":"200 grams 34cm"},
          {"image":"pizza3","title":"Deluxe 3","desc":"chickehn ham speciy 3","price":"99","currency":"USD","quantity":"536 grams 54cm"}
      ],
      "filters":["spicy","vegan"]} ,

       {"title":"Sushi","content":
       [
       
          {"image":"sushi1","title":"Sushi pecok 1","desc":"chickehn ham speciy 1","price":"46","currency":"USD","quantity":"150 grams 93cm"},
          {"image":"sushi2","title":"Sushi moca fine 2","desc":"chickehn ham speciy 2","price":"77","currency":"USD","quantity":"200 grams 34cm"},
          {"image":"sushi3","title":"Sushi de bardo 3","desc":"chickehn ham speciy 3","price":"99","currency":"USD","quantity":"536 grams 54cm"}
          
      ],
      "filters":["sushi1","sushi2"]} ,

       {"title":"Drinks","content":
       [

          {"image":"drink1","title":"Coca-cola jaoafa","desc":"chickehn ham speciy 1","price":"46","currency":"USD","quantity":"150 grams 93cm"},
          {"image":"drink2","title":"Juice mango","desc":"chickehn ham speciy 2","price":"77","currency":"USD","quantity":"200 grams 34cm"},
          {"image":"drink3","title":"Cuted fruits","desc":"chickehn ham speciy 3","price":"99","currency":"USD","quantity":"536 grams 54cm"}
    
      ],
      "filters":["hot","cold"]}
      ]
    }
    """
    return Data(response.utf8)
  }

  // 5
  public var task: Task {
    return .requestPlain // TODO
  }
   // 6
  public var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }

  // 7
  public var validationType: ValidationType {
    return .successCodes
  }
}
