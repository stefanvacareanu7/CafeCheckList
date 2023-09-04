//
//  Cafes.swift
//  СafeCheckList
//
//  Created by Yury on 04/09/2023.
//

import Foundation

struct Cafe {
    
    // MARK: - Properties
    static var shared = [Cafe(name: "Some Cafe", rating: 0, checked: false)]
    
    var name: String
    var rating: Int
    var checked: Bool
    
}
