//
//  HomeVM.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/11/21.
//

import Foundation
import Moya
import ObjectMapper

class HomeInteractor {
     
    let provider = MoyaProvider<Marvel>(stubClosure: MoyaProvider<Marvel>.immediatelyStub) // mocked response init
     
    func getAllData(completion:@escaping((Root?)->())) {
      
        provider.request(.getAll) { result in
          switch result {
          case .success(let response):
            do {
                let res = try response.mapJSON()
                let data = try JSONSerialization.data(withJSONObject: res)
                guard let str = String(data:data,encoding: .utf8) , let root = Mapper<Root>().map(JSONString: str) else { return }
                completion(root)
            } catch {
              completion(nil)
            }
          case .failure:
            completion(nil)
          }
        }
    }
    
    func addItemToCart(_ item:Content) {
        
        cartsArr.append(item)
        
    }
    
    func getCartCount() -> Int {
        
        return cartsArr.count
        
    }
}
  
