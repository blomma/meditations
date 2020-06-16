import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var appUserDefaults = AppUserDefaults.shared

    var closeButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark.circle.fill")
                .style(appStyle: .barButton)
                .foregroundColor(.acText)
        })
        .buttonStyle(BorderedBarButtonStyle())
        .accentColor(Color.acText.opacity(0.2))
        .safeHoverEffectBarItem(position: .leading)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: SectionHeaderView(text: "App Settings")) {
                    Toggle(isOn: $appUserDefaults.showOnBoarding) {
                        Text("Toggle onBoardingView")
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(Text("Preferences"), displayMode: .inline)
            .navigationBarItems(leading: closeButton)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
