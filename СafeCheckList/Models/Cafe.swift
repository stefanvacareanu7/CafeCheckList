//
//  Cafes.swift
//  СafeCheckList
//
//  Created by Yury on 04/09/2023.
//

import Foundation

struct Cafe: Codable {
    
    // MARK: - Properties
    
    static var shared = [Cafe(name: "Some Cafe", rating: 0, checked: false)]
    
    var name: String
    var rating: Int
    var checked: Bool
    var starImageName: String {
            switch rating {
            case 0:
                return "0stars"
            case 1:
                return "1stars"
            case 2:
                return "2stars"
            case 3:
                return "3stars"
            case 4:
                return "4stars"
            case 5:
                return "5stars"
            default:
                return "0stars"
            }
        }
    
}
