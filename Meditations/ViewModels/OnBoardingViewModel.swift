import Combine
import Foundation
import SwiftUI

class OnBoardingViewModel: ObservableObject {
    private var questionsCancellable: AnyCancellable?

    @Published var questions: [Question] = []
    @Published var currentPage: Int = 1
    @Published var ratings: [String: Rating] = [:]

    public var noOfQuestionsPerPage = 3

    init() {
        questionsCancellable = Questions.shared.$questions.sink { [weak self] questions in
            self?.questions = questions
            self?.ratings = Dictionary(uniqueKeysWithValues: questions.map {
                ($0.id, Rating.zero)
            })
        }
    }

    func questions(for section: Int) -> [Question] {
        let startIndex = section * noOfQuestionsPerPage
        let endIndex = startIndex + noOfQuestionsPerPage

        return Array(questions[startIndex ... endIndex])
    }

    func header(for question: Question) -> String {
        guard let pos = questions.firstIndex(of: question) else {
            return ""
        }

        return "\(pos)/\(questions.count)"
    }
}
