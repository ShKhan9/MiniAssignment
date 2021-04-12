//
//  OfferVC.swift
//  MiniAssignment
//
//  Created by Shehata Gamal on 4/9/21.
//

import UIKit

class OfferVC: UIViewController {

    @IBOutlet weak var deslb: UILabel!
    @IBOutlet weak var titlelb: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var item:Discount!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         
        setItem()
        
    }
    
    func setItem() {
        self.img.image = UIImage(named: item.image!)
        self.titlelb.text = item.title
        self.deslb.text = item.desc
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
