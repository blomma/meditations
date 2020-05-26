import Combine
import Foundation

public enum Category: String, CaseIterable {
    case questions
}

public struct QuestionnaireApiService {
    private static let decoder = JSONDecoder()
    private static let apiQueue = DispatchQueue(label: "questionnaire_api",
                                                qos: .userInitiated,
                                                attributes: .concurrent)

    public static func fetchFile<T: Codable>(endpoint: Category) -> AnyPublisher<T, APIError> {
        Result(catching: {
            guard let url = Bundle.main.url(forResource: endpoint.rawValue, withExtension: nil) else {
                throw APIError.message(reason: "Error while loading local ressource")
            }

//            let d = try Data(contentsOf: url)
//            let t = try decoder.decode(T.self, from: d)

            return try Data(contentsOf: url)
        })
            .publisher
            .decode(type: T.self, decoder: Self.decoder)
            .mapError { APIError.parseError(reason: $0.localizedDescription) }
            .subscribe(on: Self.apiQueue)
            .eraseToAnyPublisher()
    }
}
