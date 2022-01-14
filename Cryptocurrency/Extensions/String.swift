//
//  String.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
