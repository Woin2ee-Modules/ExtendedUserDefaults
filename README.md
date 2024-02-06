# ExtendedUserDefaults

## Usage

Prepare keys to use.
```swift
enum UserDefaultsKey: UserDefaultsKeyProtocol { 
    // The keys to use for UserDefaults.
    case soundIsOn
    case settings
    
    // Conform to `UserDefaultsKeyProtocol`.
    var identifier: String {
        return String(describing: self)
    }
}
```

The UserDefaults object.
```swift
let userDefaults = ExtendedUserDefaults.standard
```

Set value.
```swift
// Use the prepared key.
userDefaults.setValue(true, forKey: UserDefaultsKey.soundIsOn)

// Set codable object.
let settings = Settings()        
userDefaults.setCodable(settings, forKey: UserDefaultsKey.settings)
```

Get value.
```swift
// Get value as `Any?` type.
let soundIsOn = userDefaults.object(forKey: UserDefaultsKey.soundIsOn)
// or as specific type.
let soundIsOn = userDefaults.bool(forKey: UserDefaultsKey.soundIsOn)

// Get codable value.
let settings = userDefaults.object(Settings.self, forKey: UserDefaultsKey.settings)
// Return value is `Result` type.
switch settings {
case .success(let success):
    // Handling success.
case .failure(let failure):
    // Handling failure.
}
```
