//
//  AddOrEditTableViewCell.swift
//  СafeCheckList
//
//  Created by Yury on 04/09/2023.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func starImageDidChange(imageName: String, forSection section: Int)
}

class CustomCellTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var tableView: UITableView?
    private let totalStars: CGFloat = 5
    weak var delegate: CustomCellDelegate?
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var uncheckedImage: UIImageView!
    @IBOutlet weak var checkedImage: UIImageView!
    @IBOutlet weak var starsRatingImage: UIImageView!
    @IBOutlet weak var cafeNameLable: UILabel!
    
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(starsGestRecognizer(_:)))
        starsRatingImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - IB Actions
    
    @IBAction func starsGestRecognizer(_ sender: UITapGestureRecognizer) {
        guard let tableView = tableView else { return }
        let location = sender.location(in: tableView)
        
        if let indexPath = tableView.indexPathForRow(at: location) {
            
            let starWidth = starsRatingImage.bounds.width / totalStars
            let starIndex = Int(sender.location(in: starsRatingImage).x / starWidth)
            
            Logger.log("The star with index \(starIndex) was pressed in section \(indexPath.section) row \(indexPath.row)")
            
            let starImages = ["1stars", "2stars", "3stars", "4stars", "5stars"]
            if starIndex >= 0 && starIndex < starImages.count {
                let imageName = starImages[starIndex]
                starsRatingImage.image = UIImage(named: imageName)
                
                delegate?.starImageDidChange(imageName: imageName, forSection: indexPath.section)
                
            }
        }
    }
    
}

// MARK: - Methods

extension CustomCellTableViewCell {
    
    // Configure the cell
    func cellConfig(indexPath: IndexPath, dataModel: [Cafe]) {
        
        cafeNameLable.text = dataModel[indexPath.section].name
        checkedImage.isHidden = !dataModel[indexPath.section].checked
        uncheckedImage.isHidden = dataModel[indexPath.section].checked
        
        switch dataModel[indexPath.section].rating {
            case 0:
                starsRatingImage.image = UIImage(named: "0stars")
            case 1:
                starsRatingImage.image = UIImage(named: "1stars")
            case 2:
                starsRatingImage.image = UIImage(named: "2stars")
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


