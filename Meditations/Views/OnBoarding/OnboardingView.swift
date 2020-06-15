import Foundation
import SwiftUI

struct OnBoardingView: View {
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
