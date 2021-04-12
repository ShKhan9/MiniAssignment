//
//  HomePresenter.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/11/21.
//
 
import RxSwift
import RxCocoa

class CartPresenter {
      
    let cartInteractor = CartInteractor()
    
    let cartRouter = CartRouter()
     
    let tableData = BehaviorRelay(value: [Content?]())
     
    let showNoItems = PublishSubject<Bool>()
    
    func getData() {
        
        tableData.accept(cartInteractor.getAllData())
        
    }
    
    func removeItem(_ index:Int) {
        
       cartInteractor.removeItem(index)
        
       tableData.accept(cartInteractor.getAllData())
        
       showNoItems.onNext(cartInteractor.isCartEmpty())
         
    }
   
    func navigateToHome(_ current:UINavigationController) {
         
        cartRouter.nav = current
        
        cartRouter.navigateToHome()
    }
}
