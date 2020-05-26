import SwiftUI

struct Sheet: View {
    enum SheetType: Identifiable {
        case safari(URL)
        case about
        case settings

        var id: String {
            switch self {
            case let .safari(url):
                return url.absoluteString
            case .about:
                return "about"
            case .settings:
                return "settings"
            }
        }
    }

    let sheetType: SheetType

    private func make() -> some View {
        switch sheetType {
        case let .safari(url):
            return AnyView(SafariView(url: url))
        case .about:
            return AnyView(AboutView())
        case .settings:
            return AnyView(SettingsView())
        }
    }

    var body: some View {
        make()
    }
}
