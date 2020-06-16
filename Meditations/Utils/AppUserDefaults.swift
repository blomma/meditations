import Combine
import Foundation

public class AppUserDefaults: ObservableObject {
    public static let shared = AppUserDefaults()

    @UserDefault("showOnboarding", defaultValue: true)
    public var showOnBoarding: Bool {
        willSet {
            objectWillChange.send()
        }
    }
}
