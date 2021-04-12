//
//  HomePresenter.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/11/21.
//
 
import UIKit

class HomeRouter {
     
    var nav:UINavigationController?
     
    func navigateToCarts() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "CartVC") as! CartVC
        
        nav?.pushViewController(vc, animated: true)
        
    }
    
}
