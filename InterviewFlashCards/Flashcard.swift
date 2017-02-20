import SwiftyJSON
import BrightFutures

enum FlashcardError: Error {
    case preparationTimeout
    case invalidImage
}

class Flashcard {
    let question: String
    let answer: String?
    let questionImageUrlString: String?

    private(set) var questionImage: UIImage? = nil
    private(set) var hasLoadedQuestionImages: Bool = false
    private(set) var hasLoadedAnswerImages: Bool = false

    private let requestQueue = DispatchQueue(label: "com.interviewflashcards.flashcard")

    public init?(dictionary dict: [String: Any]) {
        let json = SwiftyJSON.JSON(dict)
        guard let question = json["question"].string
            else { return nil }

        self.question = question
        self.answer = json["answer"].string
        self.questionImageUrlString = json["question_url"].string
    }

    func prepareQuestionImagesIfNeeded() -> Future<Void, FlashcardError> {
        let promise = Promise<Void, FlashcardError>()

        guard questionImage == nil else {
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

    class func flashcards(fromDictionaries dictionaries: [[String: Any]]) -> [Flashcard] {
        return dictionaries.flatMap { Flashcard(dictionary: $0) }
    }

}
