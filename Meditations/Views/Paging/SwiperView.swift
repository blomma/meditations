import SwiftUI

struct SwiperView: View {
    @ObservedObject var viewModel: OnBoardingViewModel

    @Binding var index: Int
    @State private var offset: CGFloat = 0
    @State private var isUserSwiping: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(self.viewModel.questions) { question in
                        QuestionView(
                            question: question,
                            rating: self.$viewModel.ratings[unchecked: question.id],
                            header: self.viewModel.header(for: question)
                        )
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                    }
                }
            }
            .content
            .offset(x: self.isUserSwiping ? self.offset : CGFloat(self.index) * -geometry.size.width)
            .frame(width: geometry.size.width, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.isUserSwiping = true
                        self.offset = value.translation.width + -geometry.size.width * CGFloat(self.index)
                    }
                    .onEnded { value in
                        if
                            value.startLocation.x > value.location.x,
                            value.predictedEndTranslation.width < geometry.size.width / 2,
                            self.index < self.viewModel.questions.count - 1 {
                            self.index += 1
                        }
                        if
                            value.predictedEndTranslation.width > geometry.size.width / 2,
                            self.index > 0 {
                            self.index -= 1
                        }
                        withAnimation {
                            self.isUserSwiping = false
                        }
                    }
            )
        }
    }
}
