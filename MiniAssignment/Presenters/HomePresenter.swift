//
//  HomePresenter.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/11/21.
//
 
import RxSwift
import RxCocoa 

class HomePresenter {
     
    let homeInteractor = HomeInteractor()
    let homeRouter = HomeRouter()
    
    let tableData = BehaviorRelay(value: [Content?]())
    let discountData = BehaviorRelay(value: [Discount]())
    let cartCount = PublishSubject<Int>()
    
    
    var currentContent = [Content]()
    var filters = [String]()
    var types = [String]()
    var root:Root!
     
    var current = 0 {
       didSet {
           updateContent()
       }
    }
    
    func getData() {
        homeInteractor.getAllData() { res in
            if let res = res {
                self.root = res
                self.current = 0
                self.discountData.accept(res.discounts ?? [])
            }
        }
        
        // listen to cart changes
        updateCart()
    }
      
    func updateContent(){
        let base = root.store![self.current]
        self.filters = base.filters ?? []
        self.types = root.store?.map { $0.title } ?? []
        var content:[Content?] = base.content ?? []
        self.currentContent = content.compactMap { $0 }
        content.insert(nil, at: 0)
        self.tableData.accept(content)
    }
      
    func navigateToCarts(_ current:UINavigationController) {
        homeRouter.nav = current
        homeRouter.navigateToCarts()
    }
    
    func addItemToCart(_ item:Content) {
        homeInteractor.addItemToCart(item)
        updateCart()
    }
    
    func updateCart() { 
        cartCount.onNext(homeInteractor.getCartCount())
       
    }
    
}
