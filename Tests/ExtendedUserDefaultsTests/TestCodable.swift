//
//  TestCodable.swift
//
//
//  Created by Jaewon Yun on 2023/09/27.
//

import Foundation

struct TestCodable: Codable, Equatable {

    let name: String

    let data: Data

    var amount: Double = 0

}
