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
    
    // MARK: - Init
    
    private init() {}
    
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
    
    func updateSaveButton(cafeName cafeNameTextFiled: UITextField, notes notesAboutCafe: UITextView, button saveButton: UIBarButtonItem, image starRatingImage: UIImageView, rating ratingInDataMadel: inout Int?, originalNotes originalNotesText: String?) {
        guard let text = cafeNameTextFiled.text else { return }
        
        let currentTextViewText = notesAboutCafe.text ?? ""
        let isTextViewChanged = currentTextViewText != originalNotesText
        
        saveButton.isEnabled = !text.isEmpty || isTextViewChanged
        
        switch starRatingImage.image {
            case UIImage(named: "1stars"):
                ratingInDataMadel = 1
            case UIImage(named: "2stars"):
                ratingInDataMadel = 2
            case UIImage(named: "3stars"):
                ratingInDataMadel = 3
            case UIImage(named: "4stars"):
                ratingInDataMadel = 4
            case UIImage(named: "5stars"):
                ratingInDataMadel = 5
            default:
                return
        }
    }
    
}
