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

    func getData(for requestType: RequestType, completion: @escaping (JSON) -> Void) {
        let fileName: FileName
        switch  requestType {
        case .algorithms: fileName = .algorithm
        case .dataStructures: fileName = .dataStructure
        case .iOS: fileName = .technical
        }

        guard let path = fileName.resourcePath,
            let jsonData = try? Data(contentsOf: path,
                                     options: .mappedIfSafe),
            let json = (try? JSONSerialization
                .jsonObject(with: jsonData as Data,
                            options: .allowFragments)) as? [String: Any],
            let data = json["data"] as? JSON else {
                completion([])
                return
        }

        completion(data)
    }
}
