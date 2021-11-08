//
//  Folder.swift
//  BenchBuddy
//
//  Created by Christopher Dwyer on 10/4/21.
//

import Foundation

struct Folder: Codable {
    var title: String
    var children: [UUID]
}
