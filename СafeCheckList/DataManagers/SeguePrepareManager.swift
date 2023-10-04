//
//  SeguePrepareManager.swift
//  CafeCheckList
//
//  Created by Yury on 24/09/2023.
//

import UIKit

class SeguePrepareManager {
    
    // MARK: - Properties
    
    static var shared = SeguePrepareManager()
    
    // MARK: - Init
    
    // Закрытый инициализатор, чтобы предотвратить создание новых экземпляров класса
    private init() {}
    
}

// MARK: - Methods

extension SeguePrepareManager {
    
    func editCafe(to add: AddViewController, model dataModel: inout [Cafe], indexPath: IndexPath) {
        add.navigationTitle = "Edit cafe details"
        add.cafeName = dataModel[indexPath.section].name
        add.ratingCafe = dataModel[indexPath.section].rating
        add.notes = dataModel[indexPath.section].note
    }
    
    func addNewCafe(to add: AddViewController) {
        add.navigationTitle = "Add new cafe"
    }
    
}
