import Foundation
import SwiftUI

public extension Text {
    enum AppTextStyle {
        case title, rowTitle, rowDescription
        case sectionHeader
    }

    func style(appStyle: AppTextStyle) -> Text {
        switch appStyle {
        case .title: return title()
        case .rowTitle: return rowTitle()
        case .sectionHeader: return sectionHeader()
        case .rowDescription: return rowDescription()
        }
    }
}

extension Text {
    private func title() -> Text {
        font(.title)
            .fontWeight(.bold)
            .foregroundColor(.acText)
    }

    private func sectionHeader() -> Text {
        font(.system(.subheadline, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(Color.acSecondaryBackground)
    }

    private func rowTitle() -> Text {
        font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.acText)
    }

    private func rowDescription() -> Text {
        font(.subheadline)
            .foregroundColor(.acText)
    }
}
