//
//  Cafes.swift
//  СafeCheckList
//
//  Created by Yury on 04/09/2023.
//

import Foundation

struct Cafe {
    
    static var shared = [Cafe(name: "KFC", rating: 4, checked: false)]
    
    var name: String
    var rating: Int
    var checked: Bool
}
