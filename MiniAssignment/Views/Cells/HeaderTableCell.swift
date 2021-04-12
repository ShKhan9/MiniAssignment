//
//  HeaderTableCell.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/9/21.
//

import UIKit 
import RxSwift

class HeaderTableCell: UITableViewCell {

    
    @IBOutlet weak var pizzaBu: UIButton!
    @IBOutlet weak var sushiBu: UIButton!
    @IBOutlet weak var drinksBu: UIButton!
    @IBOutlet weak var filter1: UIButton!
    @IBOutlet weak var filter2: UIButton!
    
    private(set) var disposeBag = DisposeBag()
    
    lazy var allBus:[UIButton] = {
        return [pizzaBu,sushiBu,drinksBu]
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    
    func configure(_ items:[String],filters:[String],current:Int) {
        
        
        allBus.indices.forEach {
            
            allBus[$0].setTitle(items[$0], for: .normal)
            
            allBus[$0].setTitleColor(allBus[$0].tag == current ? UIColor.lightGray : UIColor.black , for: .normal)
            
            
        }
        
        
        filter1.setTitle(filters.first!, for: .normal)
        filter2.setTitle(filters.last!, for: .normal)
      
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
