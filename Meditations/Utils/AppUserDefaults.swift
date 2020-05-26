import Combine
import Foundation

public class AppUserDefaults: ObservableObject {
    public static let shared = AppUserDefaults()

    @UserDefault("done_letsgettoknowyou", defaultValue: false)
    public var hasLetsGetToKnowYou: Bool {
        willSet {
            objectWillChange.send()
        }
    }
}
