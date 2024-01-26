//
//  RxExtendedUserDefaults.swift
//  
//
//  Created by Jaewon Yun on 2023/09/27.
//

/*
MIT License

Copyright (c) 2023 Woin2ee-Modules

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import Foundation
import ExtendedUserDefaults
import RxSwift

extension ExtendedUserDefaults: ReactiveCompatible {}

extension Reactive where Base: ExtendedUserDefaults {

    public func setValue(_ value: Any?, forKey key: UserDefaultsKeyProtocol) -> Single<Void> {
        base.setValue(value, forKey: key)

        return .just(())
    }

    public func setCodable(_ value: Codable, forKey key: UserDefaultsKeyProtocol) -> Single<Void> {
        let result = base.setCodable(value, forKey: key)

        switch result {
        case .success:
            return .just(())
        case .failure(let error):
            return .error(error)
        }
    }

    public func object(forKey key: UserDefaultsKeyProtocol) -> Single<Any> {
        let object = base.object(forKey: key)

        guard let object = object else {
            return .error(ExtendedUserDefaultsError.keyNotFound)
        }

        return .just(object)
    }

    public func object<T: Decodable>(_ type: T.Type, forKey key: UserDefaultsKeyProtocol) -> Single<T> {
        let result = base.object(type, forKey: key)

        switch result {
        case .success(let decoded):
            return .just(decoded)
        case .failure(let error):
            return .error(error)
        }
    }

    public func bool(forKey key: UserDefaultsKeyProtocol) -> Single<Bool> {
        let object = base.bool(forKey: key)

        guard let object = object else {
            return .error(ExtendedUserDefaultsError.keyNotFound)
        }

        return .just(object)
    }

}
