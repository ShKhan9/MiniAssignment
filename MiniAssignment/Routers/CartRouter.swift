//
//  HomePresenter.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/11/21.
//
 
import UIKit

class CartRouter {
     
    var nav:UINavigationController?
     
    func navigateToHome() {
        
        nav?.popViewController(animated: true)
        
    }
    
}
