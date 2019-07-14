//
//  RevelThread.swift
//  App
//
//  Created by Arminas Ruzgas on 7/14/19.
//

import Foundation
import Vapor
//1
import FluentPostgreSQL

final class RevelThread: Codable {
    var id: Int?
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

//2
extension RevelThread: Content {}
extension RevelThread: PostgreSQLModel { }
extension RevelThread: Migration {}
extension RevelThread: Parameter {}
