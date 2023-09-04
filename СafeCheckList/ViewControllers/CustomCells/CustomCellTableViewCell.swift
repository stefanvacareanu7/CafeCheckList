//
//  AddOrEditTableViewCell.swift
//  СafeCheckList
//
//  Created by Yury on 04/09/2023.
//

import UIKit

class CustomCellTableViewCell: UITableViewCell {

    // MARK: - IB Outlets
    @IBOutlet weak var checkedImage: UIImageView!
    @IBOutlet weak var uncheckedImage: UIImageView!
    @IBOutlet weak var starsRatingImage: UIImageView!
    @IBOutlet weak var cafeNameLable: UILabel!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}

// MARK: - Methods
extension CustomCellTableViewCell {
   
    // Configure the cell
    func cellConfig(indexPath: IndexPath, dataModel: [Cafe]) {
        
        cafeNameLable.text = dataModel[indexPath.section].name
        checkedImage.isHidden = true
        
        switch dataModel[indexPath.section].rating {
            case 0:
                starsRatingImage.image = UIImage(named: "0stars")
            case 1:
                starsRatingImage.image = UIImage(named: "1star")
            case 2:
                starsRatingImage.image = UIImage(named: "3stars")
            case 3:
                starsRatingImage.image = UIImage(named: "3stars")
            case 4:
                starsRatingImage.image = UIImage(named: "4stars")
            case 5:
                starsRatingImage.image = UIImage(named: "5stars")
            default:
                return
        }

    }
    
    
}


