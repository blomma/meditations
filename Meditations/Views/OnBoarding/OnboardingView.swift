import Foundation
import SwiftUI

struct OnBoardingView: View {
    // TODO: This is a bug in swiftui, unless we add this, i.e. the presenting view, when we return the navigationbuttons cant be pushed again.
    // I think this happens because the presentationMode is not inherited from the presenter view, so the presenter didn't know that the modal is already closed. You can fix this by adding presentationMode to presenter, in this case to ContentView.
    @Environment(\.presentationMode) var presentation

    @ObservedObject var appUserDefaults = AppUserDefaults.shared

    @ObservedObject private var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @State private var index: Int = 0

    var body: some View {
        VStack {
            SwiperView(viewModel: self.viewModel, index: self.$index)
            HStack(spacing: 8) {
                ForEach(0 ... (self.viewModel.pageProgress - 1), id: \.self) { index in
                    self.makeSwipeButton(isSelected: Binding(get: { self.index == index }, set: { _ in })) {
                        withAnimation {
                            self.index = index
                        }
                    }
                }
                if viewModel.showDone {
                    Button(action: {
                        self.appUserDefaults.showOnBoarding = false
                    }, label: {
                        Image(systemName: "wind")
                            .style(appStyle: .barButton)
                            .foregroundColor(.acText)
                    })
                    .buttonStyle(BorderedBarButtonStyle())
                    .accentColor(Color.acText.opacity(0.2))
                    .safeHoverEffectBarItem(position: .leading)
                        .padding(.leading, 20)
                }
            }
            .padding(.bottom, 12)
        }
        .background(Color.acBackground)
        .environment(\.horizontalSizeClass, .regular)
    }
    
    private func makeSwipeButton(isSelected: Binding<Bool>, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }) {
            Circle()
                .frame(width: 16, height: 16)
                .foregroundColor(isSelected.wrappedValue ? Color.black : Color.black.opacity(0.5))
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
