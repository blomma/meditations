import Foundation

extension Dictionary where Key == String, Value == Rating {
    subscript(unchecked key: Key) -> Value {
        get {
            guard let result = self[key] else {
                fatalError("This rating does not exist.")
            }
            return result
        }
        set {
            self[key] = newValue
        }
    }
}
