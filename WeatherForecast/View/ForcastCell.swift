//
//  ForcastCell.swift
//  WeatherForecast
//
//  Created by admin on 9/6/2564 BE.
//

import UIKit

class ForcastCell: UITableViewCell {
    
    static let identifier = "ForcastCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ForcastCell", bundle: nil)
    }

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDes: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with title: String, imageName: String){
        dateLabel.text = title
        weatherImage.image = UIImage(named: imageName)
    }
    
}
