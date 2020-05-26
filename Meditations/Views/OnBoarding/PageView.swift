import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0

    init(_ views: [Page]) {
        viewControllers = views.map {
            let v = UIHostingController(rootView: $0)
            v.view.backgroundColor = .clear
            return v
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
    }
}
