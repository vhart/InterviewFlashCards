import SwiftyJSON

public typealias JSON = [String: Any]
public protocol DataGenerator {
    func getData(for requestType: FlashcardType,
                 completion: @escaping ([Flashcard]) -> Void)
}

struct JsonFileReader: DataGenerator {
    enum FileName: String {
        case algorithm = "algorithm-questions"
        case dataStructure = "data-structure-questions"
        case technical = "iOS-technical-questions"

        var resourcePath: URL? {
            guard let bundlePath =
                Bundle.main.path(forResource: self.rawValue, ofType: "json") else { return nil }
            return URL(fileURLWithPath: bundlePath)
        }
    }

    func getData(for requestType: FlashcardType, completion: @escaping ([Flashcard]) -> Void) {
        let fileName: FileName
        switch  requestType {
        case .algorithms: fileName = .algorithm
        case .dataStructures: fileName = .dataStructure
        case .iOS: fileName = .technical
        }

        guard let path = fileName.resourcePath,
            let jsonData = try? Data(contentsOf: path,
                                     options: .mappedIfSafe),
            let json = json(from: jsonData),
            let data = json["data"] as? [JSON] else {
                completion([])
                return
        }
        completion(Flashcard.flashcards(ofType: requestType,
                                        fromDictionaries: data))
    }

    private func json(from data: Data) -> [String: Any]? {
        let json: Any?
        do {
            json = try JSONSerialization
            .jsonObject(with: data as Data,
                        options: .allowFragments)
            return json as? [String: Any]
        } catch let error {
            fatalError("developer error: \(error.localizedDescription)")
        }
    }
}
