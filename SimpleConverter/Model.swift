//
//  Model.swift
//  SimpleConverter
//
//  Created by Денис Чупров on 06.05.2022.
//

import Foundation


// MARK: - Welcome
struct Money: Codable {
    let table: String
        let rates: [String: Double]
        let lastupdate: String
}




