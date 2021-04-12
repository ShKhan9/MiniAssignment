//
//  ViewController.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/9/21.
//

import UIKit 
import RxSwift
import RxCocoa

class HomeVC: UIViewController {
      
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var topCon: NSLayoutConstraint!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var cartlb: UILabel!
    @IBOutlet weak var cartImg: UIImageView!
    
    var pager:UIPageViewController!
    
    var pages = [UIViewController]()
    
    let homePresenter = HomePresenter()
    
    let disposeBag = DisposeBag()
   
    var pagingTimer:Timer?
    
    var pageControlTimer:Timer?
      
    var originY:CGFloat = 0
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // configure the tableView with custom cells

        tableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tableView.register(UINib(nibName: "HeaderTableCell", bundle: nil), forCellReuseIdentifier: "header")
 
        tableView.layer.cornerRadius = 30
        
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tableView.clipsToBounds = true
        
        cartView.layer.cornerRadius = 10
        
        cartView.clipsToBounds = true
       
        // listen for bottom table changes
        homePresenter.tableData.bind(to: tableView.rx.items){ [self](tv, row, item) -> UITableViewCell in

            if row == 0 {
             
                let cell = tv.dequeueReusableCell(withIdentifier: "header") as! HeaderTableCell
                cell.configure(homePresenter.types, filters:homePresenter.filters, current:homePresenter.current)
                cell.pizzaBu.rx.tap.subscribe { [weak self] _ in
                    self?.homePresenter.current = cell.pizzaBu.tag
                }.disposed(by: cell.disposeBag)
                cell.sushiBu.rx.tap.subscribe { [weak self] _ in
                    self?.homePresenter.current = cell.sushiBu.tag
                }.disposed(by: cell.disposeBag)
                cell.drinksBu.rx.tap.subscribe { [weak self] _ in
                    self?.homePresenter.current = cell.drinksBu.tag
                }.disposed(by: cell.disposeBag)
                cell.selectionStyle = .none
                return cell
                
            } else {
             
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! HomeTableCell
                cell.img.image = UIImage(named: item!.image)
                cell.titlelb.text = item!.title
                cell.desclb.text = item!.desc
                cell.priceBu.setTitle((item!.price) + " " + (item!.currency) , for: .normal)
                cell.quantitylb.text = item!.quantity
                cell.priceBu.rx.tap.subscribe { [weak self] _ in
                    self?.homePresenter.addItemToCart(item!)
                    cell.priceBu.backgroundColor = UIColor.green
                    UIView .animate(withDuration: 0.5, animations: {
                        cell.priceBu.backgroundColor = UIColor.black
                    })
                    
                }.disposed(by: cell.disposeBag)
                cell.selectionStyle = .none
                return cell
                
            }

        }.disposed(by: disposeBag)
          
        
        // start getting data to display
        homePresenter.getData()
       
        // listen for top pager changes
        homePresenter.discountData.subscribe { [weak self] (res) in
            self?.addPager(res)
        }.disposed(by:disposeBag)
       
        
        // listen for cart count changes
        homePresenter.cartCount.subscribe { [weak self] (res) in
            self?.updateCart(res.element!)
        }.disposed(by: disposeBag)

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // save origin y of the table for drag calculation
        originY = tableView.frame.minY
       
    }
     
    func addPager(_ items:[Discount]) {
        
        // create pager pages
        
        pages = items.map {
            let vc =  storyboard!.instantiateViewController(withIdentifier: "OfferVC") as! OfferVC
            vc.item = $0
            return vc
        }
        
        // create an instance og pager and add it to congtainerView
        
        pager = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
                        
        self.addChild(pager)

        pager.view.translatesAutoresizingMaskIntoConstraints = false

        self.containerView.addSubview(pager.view)

        pager.didMove(toParent: self)

        pager.delegate = self

        pager.dataSource  = self
          
        NSLayoutConstraint.activate( [
            
            pager.view.leftAnchor.constraint(equalTo: self.containerView.leftAnchor),
            
            pager.view.rightAnchor.constraint(equalTo: self.containerView.rightAnchor),
            
            pager.view.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            
            pager.view.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor),
            
        ])
       
        pager.setViewControllers([pages[homePresenter.current]], direction: .forward, animated:false, completion: nil)
  
        pageControl.numberOfPages = pages.count
      
        pageControl.pageIndicatorTintColor = .lightGray
        
        pageControl.currentPageIndicatorTintColor = .white
        
        containerView.bringSubviewToFront(pageControl)
        
        // add drag gesture to table
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        
        self.tableView.addGestureRecognizer(gestureRecognizer)
        
        // add open cart gesture to cart icon to open CartVC
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(openCart))
        
        self.cartImg.addGestureRecognizer(tapRecognizer)
        
        self.cartImg.isUserInteractionEnabled = true
 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       // set table height to number of items * item height to make it move as one part no scrolling
       tableView.frame =  CGRect.init(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.width, height:CGFloat(400 * homePresenter.currentContent.count) + 150 )
     
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let limitUp = CGFloat(400 * homePresenter.currentContent.count) + containerView.frame.height + 150 - 30
            
            let actual = limitUp - self.view.frame.height
            
            let translation = gestureRecognizer.translation(in: self.view)
          
            let sum = topCon.constant + translation.y
           
            if sum <= 0 && actual >= abs(sum) {
                topCon.constant += translation.y
                view.layoutIfNeeded()
            }
            
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
               
        }
        
    }
 
    
    @objc func openCart(_ gestureRecognizer: UITapGestureRecognizer) {
        // open CartVC
        homePresenter.navigateToCarts(self.navigationController!)
        
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // update cart number
        homePresenter.updateCart()
        
        // start animation timers
        startPagingTimer()
        startPageControlTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // dispose animation timers when the view is disappeared
        stopTimer(&pagingTimer)
        stopTimer(&pageControlTimer)
        
    }
    
    func updateCart(_ value:Int) {
        
        // hide/show cart icon according to current number of items
        
        if value == 0 {
            cartView.isHidden = true
            cartImg.isHidden = true
        }
        else {
            
            cartView.isHidden = false
            cartImg.isHidden = false
            cartlb.text = "\(value)"
        }
        
    }
    
    func startPageControlTimer() {
        
        // track current vc index to assign it to page control
        
        pageControlTimer =  Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (t) in
        
             let index = self.pages.firstIndex(of:self.pager.viewControllers!.first!)!
          
             self.pageControl.currentPage = index
            
         }
         

    }
    func startPagingTimer() {
        
         // automatic animate pager every 2 second
        
         pagingTimer =  Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [self] (t) in
              
             let index = self.pages.firstIndex(of:self.pager.viewControllers!.first!)!
             
            if index + 1 < self.pages.count {
                 
                self.pager.setViewControllers([self.pages[index + 1]], direction: .forward, animated: true, completion: nil)
                 
            }
            else {
                
                self.pager.setViewControllers([self.pages.first!], direction: .reverse, animated: false, completion: nil)
 
            }
                      
         }

    }
    func stopTimer(_ timer:inout Timer?) {
        
        // stop timer completely and dispose it
        
        timer?.invalidate()
        
        timer = nil
        
    }
    
}


// implement pager delegate and data source

extension HomeVC : UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
         
        let index = self.pages.firstIndex(of: viewController)!
        
        if index >= 1 {
             
            return pages[index - 1]
        }
   
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
         let index = self.pages.firstIndex(of: viewController)!
         
        if index < pages.count - 1 {
             
           return pages[index + 1]
       }
 
       return nil
         
    } 
    
}
 
