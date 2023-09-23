//
//  StorageManager.swift
//  CafeCheckList
//
//  Created by Yury on 23/09/2023.
//

import Foundation

class StorageManager {
    
    // MARK: - Properties
    
    static var shared = StorageManager()
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let plistUrl: URL

    // MARK: - Init
    
    init() {
        self.plistUrl = documentDirectory.appendingPathComponent("CafeList").appendingPathExtension("plist")
    }

}

// MARK: - Methods
extension StorageManager {
    
    func saveToFile(dataModel: [Cafe]) {
        let newData = try? PropertyListEncoder().encode(dataModel)
        guard let data = newData else { return }
        
        do {
            try data.write(to: plistUrl, options: .noFileProtection)
        } catch let error {
            Logger.log(error.localizedDescription)
        }
    }
    
    func loadFromFile(dataModel: [Cafe], closure: @escaping ([Cafe]) -> Void) {
        let newData = try? Data(contentsOf: plistUrl)
        guard let data = newData else { return }
        
        do {
            let cafeList = try PropertyListDecoder().decode([Cafe].self, from: data)
            closure(cafeList)
        } catch let error {
            Logger.log(error.localizedDescription)
        }
    }
    
}
