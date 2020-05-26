import Foundation
import SafariServices
import SwiftUI

public struct SafariView: UIViewControllerRepresentable {
    public let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context _: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        vc.configuration.barCollapsingEnabled = false
        return vc
    }

    public func updateUIViewController(_: SFSafariViewController,
                                       context _: UIViewControllerRepresentableContext<SafariView>) {}
}
