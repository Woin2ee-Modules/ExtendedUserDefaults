//
//  UserDefaultsKeyProtocol.swift
//
//
//  Created by Jaewon Yun on 2023/09/27.
//

import Foundation

public protocol UserDefaultsKeyProtocol {

    /// The Identifier to distinguish each key. Must not be duplicates.
    var identifier: String { get }

}
