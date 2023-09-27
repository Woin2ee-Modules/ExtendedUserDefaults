//
//  UserDefaultsKey.swift
//
//
//  Created by Jaewon Yun on 2023/09/27.
//

import Foundation
import ExtendedUserDefaults

enum TestKey: UserDefaultsKeyProtocol, CaseIterable {
    
    case test
    
    var identifier: String {
        switch self {
        case .test:
            return String(describing: self)
        }
    }
    
}
