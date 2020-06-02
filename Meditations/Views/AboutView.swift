import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var selectedSheet: Sheet.SheetType?

    private var versionNumber: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? NSLocalizedString("Error", comment: "")
    }

    private var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? NSLocalizedString("Error", comment: "")
    }

    private var dismissButton: some View {
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

    private func makeRow(image: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: image)
                .imageScale(.medium)
                .foregroundColor(color)
                .frame(width: 30)
            Text(LocalizedStringKey(text))
                .foregroundColor(.acText)
                .font(.body)
            Spacer()
            Image(systemName: "chevron.right").imageScale(.medium)
        }
    }

    private func makeDetailRow(image: String, text: String, detail: String, color: Color) -> some View {
        HStack {
            Image(systemName: image)
                .imageScale(.medium)
                .foregroundColor(color)
                .frame(width: 30)
            Text(LocalizedStringKey(text))
                .foregroundColor(.acText)
                .font(.body)
            Spacer()
            Text(detail)
                .foregroundColor(.gray)
                .font(.callout)
        }
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: SectionHeaderView(text: "The app")) {
                    makeRow(image: "chevron.left.slash.chevron.right",
                            text: "Souce code / report an issue", color: .acHeaderBackground)
                        .onTapGesture {
                            self.selectedSheet = .safari(URL(string: "https://github.com/blomma/meditations")!)
                        }
                    makeDetailRow(image: "tag",
                                  text: "App version",
                                  detail: "\(versionNumber) (\(buildNumber))",
                                  color: .acHeaderBackground)
                }
                Section(header: SectionHeaderView(text: "Acknowledgements")) {
                    makeRow(image: "suit.heart.fill", text: "Our amazing contributors", color: .red)
                        .onTapGesture {
                            self.selectedSheet = .safari(URL(string: "https://github.com/blomma/meditations/graphs/contributors")!)
                        }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(Text("About"), displayMode: .inline)
            .navigationBarItems(leading: dismissButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(item: $selectedSheet, content: {
            Sheet(sheetType: $0)
        })
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
