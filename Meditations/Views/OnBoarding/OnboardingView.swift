import Foundation
import SwiftUI

struct OnBoardingView: View {
    @ObservedObject private var viewModel: OnBoardingViewModel = OnBoardingViewModel()

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    ForEach(viewModel.questions) { question in
                        QuestionView(
                            question: question,
                            rating: self.$viewModel.ratings[unchecked: question.id],
                            header: self.viewModel.header(for: question)
                        )
                    }
                    
                    
                }
            }
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
    }

//    func selectedQuestion(id: String) -> Binding<Question> {
//        guard let index = self.viewModel.questions.firstIndex(where: { $0.id == id }) else {
//            fatalError("This question does not exist.")
//        }
//
//        return self.$viewModel.questions[index]
//    }

//    func selectedRating(for id: String) -> Binding<Rating> {
//        guard let index = self.viewModel.answers.firstIndex(where: {$0.questionId == id}) else {
//            fatalError("This question does not exist.")
//        }
//
//        return self.$viewModel.answers[index].rating
//    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
