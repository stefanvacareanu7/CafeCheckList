//
//  ActionManager.swift
//  CafeCheckList
//
//  Created by Yury on 24/09/2023.
//

import UIKit

protocol StarImageChangeDelegate: AnyObject {
    func starImageDidChange(imageName: String, forSection: Int)
}

class ActionManager {
    
    // MARK: - Properties
    
    static var shared = ActionManager()
    
    // MARK: - Init
    
    private init() {}
    
}

// MARK: - Methods

extension ActionManager {
    
    func updateStarsRating(image starRatingImage: UIImageView, in sender: UITapGestureRecognizer) {
        let starWidth = starRatingImage.bounds.width / 5
        let starIndex = Int(sender.location(in: starRatingImage).x / starWidth)
        Logger.log("The star with index \(starIndex) was pressed")
        let starImages = ["1stars", "2stars", "3stars", "4stars", "5stars"]
        
        if starIndex >= 0 && starIndex < starImages.count {
            let imageName = starImages[starIndex]
            starRatingImage.image = UIImage(named: imageName)
        }
    }
    
    func updateStarsRating(image starRatingImage: UIImageView, in sender: UITapGestureRecognizer, forTableView tableView: UITableView?, delegate: CustomCellDelegate?) {
        guard let tableView = tableView else { return }
        
        let location = sender.location(in: tableView)
        
        if let indexPath = tableView.indexPathForRow(at: location) {
            let starWidth = starRatingImage.bounds.width / 5
            let starIndex = Int(sender.location(in: starRatingImage).x / starWidth)
            
            Logger.log("The star with index \(starIndex) was pressed in section \(indexPath.section) row \(indexPath.row)")
            
            let starImages = ["1stars", "2stars", "3stars", "4stars", "5stars"]
            
            if starIndex >= 0 && starIndex < starImages.count {
                let imageName = starImages[starIndex]
                starRatingImage.image = UIImage(named: imageName)
                
                delegate?.starImageDidChange(imageName: imageName, forSection: indexPath.section)
            }
        }
    }
    
}
