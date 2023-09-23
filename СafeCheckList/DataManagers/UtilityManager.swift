//
//  UtilityManager.swift
//  CafeCheckList
//
//  Created by Yury on 24/09/2023.
//

import UIKit

struct UtilityManager {
    
    // MARK: - Properties
    
    static var shared = UtilityManager()
    
}

// MARK: - Methods

extension UtilityManager {
    
    func dataModelCheckedImageStatus(dataModel: inout [Cafe], indexPath: IndexPath) {
        dataModel[indexPath.section].checked = !dataModel[indexPath.section].checked
    }
    
    func hideOrUnhideImage(dataModel: [Cafe], tableView: UITableView, indexPath: IndexPath) {
        if let customCell = tableView.cellForRow(at: indexPath) as? CustomCellTableViewCell {
            if dataModel[indexPath.section].checked {
                customCell.uncheckedImage.isHidden = true
                customCell.checkedImage.isHidden = false
            } else {
                customCell.uncheckedImage.isHidden = false
                customCell.checkedImage.isHidden = true
            }
        }
    }
    
}
