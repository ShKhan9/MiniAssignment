//
//  HomeTableCell.swift
//  MiniAssignment
//
//  Created by Shehata Gamal  on 4/9/21.
//

import UIKit 
import RxSwift

class HomeTableCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelb: UILabel!
    @IBOutlet weak var desclb: UILabel!
    @IBOutlet weak var quantitylb: UILabel!
    @IBOutlet weak var priceBu: UIButton!
    
    private(set) var disposeBag = DisposeBag()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.priceBu.layer.cornerRadius = 20
        self.priceBu.clipsToBounds = true
        self.img.layer.cornerRadius = 20
        self.img.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
