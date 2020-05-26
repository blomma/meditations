import Foundation
import SwiftUI

struct OnBoardingView2: View {
    var directionForward = true
    @State var currentView: Int

    var viewIds = 1 ..< 5

    @State var xOffset: CGFloat = 0

    init() {
        _currentView = State(initialValue: viewIds.first!)
    }

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(self.viewIds) { _ in
                    LetsGetToKnowYouView()
                        .frame(width: geometry.size.width)
                }
            }
            .offset(x: self.xOffset, y: 0)
            .gesture(DragGesture()
                .onChanged { value in
                    self.xOffset = value.location.x - value.startLocation.x
                }
                .onEnded { _ in
                    let inPercent = 100 * self.xOffset / (geometry.size.width / 2)
                    let changedCount = inPercent / 100
                    if changedCount < -1 { // drag left to go to next one
                        self.xOffset = geometry.size.width + self.xOffset

//                        guard let currentCardInd = self.cards.firstIndex(where: { $0.id == self.currentCard.id }) else { fatalError("cant find current card") }
//                        let nextInd = self.cards.index(currentCardInd, offsetBy: Int(-changedCount))
//                        if self.cards.indices.contains(nextInd) {
//                            self.currentCard = self.cards[nextInd]
//                            self.xOffset = geometry.size.width + self.xOffset
//                        } else {
//                            guard let firstCard = self.cards.first else { fatalError("cant get first card") }
//                            self.currentCard = firstCard
//                            self.xOffset = geometry.size.width + self.xOffset
//                        }
                    } else if changedCount > 1 { // drag right to go to previos one
                        self.xOffset = -geometry.size.width + self.xOffset
//                        guard let currentCardInd = self.cards.firstIndex(where: { $0.id == self.currentCard.id }) else { fatalError("cant find current card") }
//                        let previosInd = self.cards.index(currentCardInd, offsetBy: Int(-changedCount))
//                        if self.cards.indices.contains(previosInd) {
//                            self.currentCard = self.cards[previosInd]
//                            self.xOffset = -geometry.size.width + self.xOffset
//                        } else {
//                            guard let lastCard = self.cards.last else { fatalError("cant get last card") }
//                            self.currentCard = lastCard
//                            self.xOffset = -geometry.size.width + self.xOffset
//                        }
                    }

                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.xOffset = 0
                    }
            })
        }
    }
}

struct OnboardingView2_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView2()
            .padding()
    }
}
