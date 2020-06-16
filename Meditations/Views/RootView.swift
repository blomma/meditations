import Combine
import Foundation
import SwiftUI

struct RootView: View {
    // TODO: This is a bug in swiftui, unless we add this, i.e. the presenting view, when we return the navigationbuttons cant be pushed again.
    // I think this happens because the presentationMode is not inherited from the presenter view, so the presenter didn't know that the modal is already closed. You can fix this by adding presentationMode to presenter, in this case to ContentView.
    @Environment(\.presentationMode) var presentation

    @ObservedObject var appUserDefaults = AppUserDefaults.shared

    @State private var selectedSheet: Sheet.SheetType?

    var body: some View {
        VStack {
            if self.appUserDefaults.showOnBoarding {
                OnBoardingView()
            } else {
                HomeView(selectedSheet: $selectedSheet)
            }
        }
        .sheet(item: $selectedSheet,
               content: { Sheet(sheetType: $0) })
        .background(Color.acBackground)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
