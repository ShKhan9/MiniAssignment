//
//  CartVC.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/9/21.
//

import UIKit
import RxSwift
import RxCocoa
 
class CartVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    var disposeBag = DisposeBag()
    
    let cartPresenter = CartPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "CartTableCell", bundle: nil), forCellReuseIdentifier: "cell")

        tableView.register(UINib(nibName: "FooterTableCell", bundle: nil), forCellReuseIdentifier: "footer")

        // listen for bottom table changes
        cartPresenter.tableData.bind(to: tableView.rx.items){ [self](tv, row, item) -> UITableViewCell in

            if cartsArr.count == row {
             
                let cell = tv.dequeueReusableCell(withIdentifier: "footer") as! FooterTableCell
                let sum  = cartsArr.map { Int($0.price)! }.reduce(0, +)
                cell.totallb.text = "\(sum)" + " USD"
                cell.isHidden = sum == 0
                return cell
                
            } else {
             
                let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! CartTableCell
                cell.removeBu.rx.tap.subscribe { [weak self] _ in
                    self?.cartPresenter.removeItem(row)
                }.disposed(by: cell.disposeBag)
                cell.img.image = UIImage.init(named: item!.image)
                cell.titlelb.text = item?.title
                cell.pricelb.text = (item?.price ?? "") + " " + (item?.currency ?? "")
                cell.selectionStyle = .none
                return cell
                
            }

        }.disposed(by: disposeBag)
        
        
        // listen for cart empty changes
        cartPresenter.showNoItems.subscribe { [weak self] (res) in
            self?.emptyView.isHidden = !res
        }.disposed(by: disposeBag)
        
        
        cartPresenter.getData()
        
    }

    @IBAction func backClicked(_ sender: Any) {
        // navigate back to HomeVC
        cartPresenter.navigateToHome(self.navigationController!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

 
