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
                    if self.viewModel.noOfPages > 0 {
                        ForEach(1...self.viewModel.pageProgress, id: \.self) { page in
                            VStack {
                                ForEach(self.viewModel.questions(for: page)) { question in
                                    QuestionView(
                                        question: question,
                                        rating: self.$viewModel.ratings[unchecked: question.id],
                                        header: self.viewModel.header(for: question)
                                    )
                                    .padding()
                                }
                                Spacer()
                            }
                            .padding()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                        }
                    }
                }
            }
            .content
            .offset(x: self.isUserSwiping ? self.offset : CGFloat(self.index) * -geometry.size.width)
            .frame(width: geometry.size.width, alignment: .leading)
            .contentShape(Rectangle())
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
                        self.index < (self.viewModel.pageProgress - 1) {
                            self.index += 1
                        }
                        if
                            value.predictedEndTranslation.width > geometry.size.width / 2,
                            self.index > 0 {
                            self.index -= 1
                        }
                        withAnimation() {
                            self.isUserSwiping = false
                        }
                    }
            )
        }
    }
}

struct SwiperView_Previews: PreviewProvider {
    @ObservedObject static private var viewModel: OnBoardingViewModel = OnBoardingViewModel()
    @State static private var index: Int = 0

    static var previews: some View {
        SwiperView(viewModel: viewModel, index: $index)
    }
}
