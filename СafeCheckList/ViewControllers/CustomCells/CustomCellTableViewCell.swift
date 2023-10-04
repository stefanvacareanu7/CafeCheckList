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
        setupUI()
    }
    
    // MARK: - IB Actions
    
    @IBAction func starsGestRecognizer(_ sender: UITapGestureRecognizer) {
        ActionManager.shared.updateStarsRating(image: starsRatingImage, in: sender, forTableView: tableView, delegate: delegate)
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
    
    private func setupUI() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(starsGestRecognizer(_:)))
        starsRatingImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
}
