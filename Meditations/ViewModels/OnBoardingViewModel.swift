import Combine
import Foundation
import SwiftUI

class OnBoardingViewModel: ObservableObject {
    private var questionsCancellable: AnyCancellable?

    @Published var questions: [Question] = []
    @Published var ratings: [String: Rating] = [:] {
        didSet {
            let questionsRated = ratings.filter { $0.value != Rating.zero }.count
            if questionsRated == questions.count {
                if questionsRated > 0 {
                    showDone = true
                }
                
                return
            }
            
            let currentPageProgress = Int((Double(questionsRated) / Double(noOfQuestionsPerPage)).rounded(FloatingPointRoundingRule.up))
            
            let nextQuestion = min(questions.count, questionsRated + 1)
            let nextPageProgress = Int((Double(nextQuestion) / Double(noOfQuestionsPerPage)).rounded(FloatingPointRoundingRule.up))
            
            // At this point we know for sure there are unanswered questions
            if currentPageProgress < nextPageProgress {
                pageProgress = nextPageProgress
            }
        }
    }

    let noOfQuestionsPerPage = 3
    @Published var noOfPages = 1
    @Published var pageProgress: Int = 1

    @Published var showDone: Bool = false
    
    init() {
        questionsCancellable = Questions.shared.$questions.sink { [weak self] questions in
            self?.questions = questions
            self?.ratings = Dictionary(uniqueKeysWithValues: questions.map {
                ($0.id, Rating.zero)
            })
            
            guard let noOfQuestionsPerPage = self?.noOfQuestionsPerPage else {
                return
            }
            
            self?.noOfPages = Int((Double(questions.count) / Double(noOfQuestionsPerPage)).rounded(FloatingPointRoundingRule.up))
        }
    }

    // 1 based, not zero based
    func questions(for page: Int) -> [Question] {
        let startIndex = (page - 1) * noOfQuestionsPerPage
        var endIndex = startIndex + noOfQuestionsPerPage - 1

        endIndex = min(endIndex, questions.count - 1)
        return Array(questions[startIndex ... endIndex])
    }

    func header(for question: Question) -> String {
        guard let pos = questions.firstIndex(of: question) else {
            return ""
        }

        return "\(pos)/\(questions.count)"
    }
}
