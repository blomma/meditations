import Foundation

public class Questions: ObservableObject {
    public static let shared = Questions()

    @Published public var questions: [Question] = []

    init() {
        _ = QuestionnaireApiService
            .fetchFile(endpoint: .questions)
            .replaceError(with: QuestionResponse(total: 0, results: []))
            .eraseToAnyPublisher()
            .map { $0.results }
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] questions in
                self?.questions = questions
            }
    }
}
