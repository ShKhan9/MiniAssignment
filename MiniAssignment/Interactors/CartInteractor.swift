//
//  HomeVM.swift
//  MiniAssignment
//
//  Created by Shehata Gamal on 4/11/21.
//

import Foundation 

var cartsArr = [Content]()
class CartInteractor {
    
    func getAllData() -> [Content?] {
        
        var currentContent:[Content?] = cartsArr
        
        currentContent.append(nil)
        
        return currentContent
    }
    
    func removeItem(_ index:Int){
        
       cartsArr.remove(at: index)
        
    }
    
    func isCartEmpty() -> Bool {
        return cartsArr.isEmpty
    }
}
  
