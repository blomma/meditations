import Foundation
import SwiftUI

public enum Rating: Int, CaseIterable {
    case one = 1, two = 2, three = 3, four = 4, five = 5, zero = 0

    public static var allCases: [Rating] {
        return [.one, .two, .three, .four, .five]
    }

    var title: LocalizedStringKey {
        switch self {
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .zero: return "0"
        }
    }
}
