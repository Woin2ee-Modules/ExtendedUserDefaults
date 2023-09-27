//
//  RxExtendedUserDefaults.swift
//  
//
//  Created by Jaewon Yun on 2023/09/27.
//

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

}
