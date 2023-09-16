//
//  GestureHandlerManager.swift
//  СafeCheckList
//
//  Created by Yury on 16/09/2023.
//

import UIKit

class GestureHandler: NSObject {
    
    // MARK: - Prperties
    
    weak var tableView: UITableView?
    var dataModel: [Cafe] // Подставьте ваш тип данных
    
    // MARK: - Init
    init(tableView: UITableView, dataModel: [Cafe]) {
        self.tableView = tableView
        self.dataModel = dataModel
    }
    
}

// MARK: - Methods

extension GestureHandler: UIGestureRecognizerDelegate {
    
    // MARK: Gesture recognizer
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        guard let tableView = tableView else { return }
        
        let location = gestureRecognizer.location(in: tableView)
        
        if let indexPath = tableView.indexPathForRow(at: location),
           let cell = tableView.cellForRow(at: indexPath) as? CustomCellTableViewCell {
            
            let locationInCell = gestureRecognizer.location(in: cell)
            
            if cell.starsRatingImage.frame.contains(locationInCell) {
                handleStarTap(at: indexPath, in: cell, location: gestureRecognizer.location(in: cell.starsRatingImage))
            } else {
                handleCellTap(at: indexPath, in: cell)
            }
        }
    }
    
    private func handleStarTap(at indexPath: IndexPath, in cell: CustomCellTableViewCell, location: CGPoint) {
        let starWidth = cell.starsRatingImage.bounds.width / 5
        let starIndex = Int(location.x / starWidth)
        
        print("The star with index \(starIndex) was pressed in the section with index \(indexPath.section)")
        
        let starImages = ["1star", "2stars", "3stars", "4stars", "5stars"]
        if starIndex >= 0 && starIndex < starImages.count {
            let imageName = starImages[starIndex]
            cell.starsRatingImage.image = UIImage(named: imageName)
        }
    }
    
    private func handleCellTap(at indexPath: IndexPath, in cell: CustomCellTableViewCell) {
        dataModel[indexPath.section].checked = !dataModel[indexPath.section].checked
        
        if dataModel[indexPath.section].checked {
            cell.uncheckedImage.isHidden = true
            cell.checkedImage.isHidden = false
        } else {
            cell.uncheckedImage.isHidden = false
            cell.checkedImage.isHidden = true
        }
    }
    
}
