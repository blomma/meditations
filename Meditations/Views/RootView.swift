import Combine
import Foundation
import SwiftUI

struct RootView: View {
    // TODO: This is a bug in swiftui, unless we add this, i.e. the presenting view, when we return the navigationbuttons cant be pushed again.
    // I think this happens because the presentationMode is not inherited from the presenter view, so the presenter didn't know that the modal is already closed. You can fix this by adding presentationMode to presenter, in this case to ContentView.
    @Environment(\.presentationMode) var presentation

    @State private var selectedSheet: Sheet.SheetType?
    @ObservedObject var appUserDefaults = AppUserDefaults.shared

    var body: some View {
        NavigationView {
            List {
                if !appUserDefaults.hasLetsGetToKnowYou {
                    OnBoardingView()
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(Text("Knowing you, knowing me"))
            .navigationBarItems(leading: aboutButton, trailing: settingsButton)
            .sheet(item: $selectedSheet,
                   content: { Sheet(sheetType: $0) })
        }
    }

    private var settingsButton: some View {
        Button(action: {
            self.selectedSheet = .settings
        }) {
            Image(systemName: "slider.horizontal.3")
                .style(appStyle: .barButton)
                .foregroundColor(.acText)
        }
        .buttonStyle(BorderedBarButtonStyle())
        .accentColor(Color.acText.opacity(0.2))
        .safeHoverEffect()
    }

    private var aboutButton: some View {
        Button(action: {
            self.selectedSheet = .about
        }) {
            Image(systemName: "info.circle")
                .style(appStyle: .barButton)
                .foregroundColor(.acText)
        }
        .buttonStyle(BorderedBarButtonStyle())
        .accentColor(Color.acText.opacity(0.2))
        .safeHoverEffect()
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
