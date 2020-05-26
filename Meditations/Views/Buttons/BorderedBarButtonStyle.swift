import Foundation
import SwiftUI

public struct BorderedBarButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 14, style: .continuous).foregroundColor(Color.accentColor))
    }
}
