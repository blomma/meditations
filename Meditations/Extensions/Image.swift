import Foundation
import SwiftUI

public extension Image {
    enum AppImageStyle {
        case barButton
    }

    func style(appStyle: AppImageStyle) -> some View {
        switch appStyle {
        case .barButton: return barButton()
        }
    }
}

extension Image {
    private func barButton() -> some View {
        imageScale(.medium)
            .font(.system(size: 16, weight: .bold, design: .rounded))
    }
}
