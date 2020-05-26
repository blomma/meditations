import Foundation
import SwiftUI

public struct QuestionResponse: Codable {
    let total: Int
    let results: [Question]
}

public struct Question: Codable, Equatable, Identifiable {
    public var id: String
    public var label: String
}
