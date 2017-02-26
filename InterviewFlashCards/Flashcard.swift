import SwiftyJSON
import BrightFutures

enum FlashcardError: Error {
    case preparationTimeout
    case invalidImage
}

public enum FlashcardType {
    case iOS
    case dataStructures
    case algorithms
}

public class Flashcard {
    let type: FlashcardType
    let question: String
    let answer: String
    let questionImageUrlString: String?

    private(set) var questionImage: UIImage? = nil

    private let requestQueue = DispatchQueue(label: "com.interviewflashcards.flashcard")

    public init?(dictionary dict: [String: Any], type: FlashcardType) {
        let json = SwiftyJSON.JSON(dict)
        guard let question = json["question"].string,
            let answer = json["answer"].string
            else { return nil }

        self.type = type
        self.question = question
        self.answer = answer
        self.questionImageUrlString = json["question_url"].string
    }

    func prepareQuestionImagesIfNeeded() -> Future<Void, FlashcardError> {
        let promise = Promise<Void, FlashcardError>()

        guard questionImageUrlString != nil && questionImage == nil else {
            promise.success()
            return promise.future
        }

        requestQueue.async {
            if let questionUrlString = self.questionImageUrlString,
                let questionImageUrl = URL(string: questionUrlString) {
                do {
                    let data = try Data(contentsOf: questionImageUrl)
                    if let image = UIImage(data: data) {
                        self.questionImage = image
                        promise.success()
                    } else {
                        promise.failure(.invalidImage)
                    }
                } catch _ {
                    promise.failure(.invalidImage)
                }
            }
        }

        return promise.future
    }

    class func flashcards(ofType type: FlashcardType,
                          fromDictionaries dictionaries: [[String: Any]]) -> [Flashcard] {
        return dictionaries.flatMap { Flashcard(dictionary: $0, type: type) }
    }

}
