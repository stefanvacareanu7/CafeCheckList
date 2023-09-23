//
//  Logger.swift
//  CafeCheckList
//
//  Created by Yury on 23/09/2023.
//

import Foundation

struct Logger {
    
    // MARK: - Properties
    
    static var isLoggingEnabled = false // Flag to enable/disable logging
    
}

// MARK: - Methods

extension Logger {
    
    // General method for logging
    static func log(_ message: String) {
        guard isLoggingEnabled else { return }
        
        print(message)
    }
    
}
