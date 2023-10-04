//
//  UnwindManager.swift
//  CafeCheckList
//
//  Created by Yury on 24/09/2023.
//

import UIKit

class UnwindManager {
    
    // MARK: - Properties
    
    static var shared = UnwindManager()
    
    // MARK: - Init
    
    // Закрытый инициализатор, чтобы предотвратить создание новых экземпляров класса
    private init() {}
    
}

// MARK: - MEthods

extension UnwindManager {
    
    func insertNewSection(from addViewController: AddViewController, model dataModel: inout [Cafe], table tableView: UITableView) {
        let name = addViewController.cafeNameTextFiled.text ?? ""
        let rating = addViewController.ratingInDataMadel ?? 0
        let note = addViewController.notesAboutCafe.text ?? ""
        // Adding new cafe information to the data model
        let newSectionIndex = dataModel.count
        dataModel.append(Cafe(name: name, rating: rating, checked: false, note: note))
        // Inserting a new section in tableView
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            tableView.insertSections(IndexSet(integer: newSectionIndex), with: .automatic)
        }
    }
    
    func updateCurrentSection(from addViewController: AddViewController, model dataModel: inout [Cafe], indexPath: IndexPath, table tableView: UITableView) {
        
        // Updating cafe information to the data model
        dataModel[indexPath.section].name = addViewController.cafeNameTextFiled.text ?? ""
        dataModel[indexPath.section].rating = addViewController.ratingInDataMadel ?? 0
        dataModel[indexPath.section].note = addViewController.notesAboutCafe.text ?? ""
        // Updating a section in a tableView
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
}
