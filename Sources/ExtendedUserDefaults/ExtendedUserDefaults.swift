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

public final class ExtendedUserDefaults {
    
    let userDefaults: UserDefaults

    public static let standard: ExtendedUserDefaults = .init(userDefaults: .standard)
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    /// Creates a user defaults object initialized with the defaults for the app and current user.
    public init() {
        self.userDefaults = .init()
    }
    
    /// Creates a user defaults object initialized with the defaults for the specified database name.
    /// - Parameter suiteName: The domain identifier of the search list.
    public init?(suiteName: String?) {
        guard let userDefaults: UserDefaults = .init(suiteName: suiteName) else {
            return nil
        }
        self.userDefaults = userDefaults
    }

    public func setValue(_ value: Any?, forKey key: UserDefaultsKeyProtocol) {
        userDefaults.setValue(value, forKey: key.identifier)
    }

    @discardableResult
    public func setCodable(_ value: Codable, forKey key: UserDefaultsKeyProtocol) -> Result<Void, Error> {
        do {
            let encoded = try JSONEncoder().encode(value)
            setValue(encoded, forKey: key)

            return .success(())
        } catch {
            return .failure(error)
        }
    }

    public func object(forKey key: UserDefaultsKeyProtocol) -> Any? {
        return userDefaults.object(forKey: key.identifier)
    }

    public func object<T: Decodable>(_ type: T.Type, forKey key: UserDefaultsKeyProtocol) -> Result<T, Error> {
        let object = self.object(forKey: key)

        guard let data = object as? Data else {
            return .failure(ExtendedUserDefaultsError.keyNotFound)
        }

        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }

    public func removeObject(forKey key: UserDefaultsKeyProtocol) {
        userDefaults.removeObject(forKey: key.identifier)
    }

    public func removeAllObject<Key>(forKeyType keyType: Key.Type) where Key: CaseIterable & UserDefaultsKeyProtocol {
        keyType.allCases.forEach { key in
            userDefaults.removeObject(forKey: key.identifier)
        }
    }
    
}
