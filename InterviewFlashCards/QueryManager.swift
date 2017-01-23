import Foundation
import Firebase
import FirebaseDatabase

public typealias JSON = [String: Any]
public protocol DataGenerator {
    func getData(for requestType: RequestType,
                     completion: @escaping ([JSON]) -> Void)
}

public enum RequestType: Int {
    case iOS
    case dataStructures
    case algorithms
}

class QueryManager: DataGenerator {
    // MARK: Private Properties
    fileprivate let baseURL = "https://fiery-torch-4131.firebaseio.com/"

    func getData(for requestType: RequestType, completion: @escaping ([JSON]) -> Void) {
        let keyForSection = destinationPathForSection(requestType)
        let reference = FIRDatabase.database().reference(withPath: keyForSection)
        reference.observe(.value, with: { snapshot in
            let dataArray = self.populateArray(withSnapshot: snapshot)
            completion(dataArray)
        })
    }

    fileprivate func firebaseRequestStringForType(_ type: RequestType) -> String {
        return baseURL + destinationPathForSection(type)
    }

    fileprivate func destinationPathForSection(_ type: RequestType) -> String {
        switch type {
        case .iOS:
            return "iOS technical questions"
        case .dataStructures:
            return "data structure questions"
        case .algorithms:
            return "algorithm questions"
        }
    }

    fileprivate func populateArray(withSnapshot snapshot: FIRDataSnapshot) -> [JSON] {
        var firebaseArray = [JSON]()
        for dict in (snapshot.valueInExportFormat() as AnyObject).allValues {
            firebaseArray.append(dict as! [String: Any])
            }
        return firebaseArray
    }
}
