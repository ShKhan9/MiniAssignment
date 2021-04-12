//
//  CartTableCell.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/9/21.
//

import UIKit 
import RxSwift

class CartTableCell: UITableViewCell {

    
    private(set) var disposeBag = DisposeBag()
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelb: UILabel!
    @IBOutlet weak var pricelb: UILabel!
    @IBOutlet weak var removeBu: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
