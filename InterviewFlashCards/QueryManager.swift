//import Foundation
//import Firebase
//import FirebaseDatabase
//import SwiftyJSON
//

//class QueryManager: DataGenerator {
//    // MARK: Private Properties
//    fileprivate let baseURL = "https://fiery-torch-4131.firebaseio.com/"
//
//    func getData(for requestType: RequestType, completion: @escaping ([JSON]) -> Void) {
//        let keyForSection = destinationPathForSection(requestType)
//        let reference = FIRDatabase.database().reference(withPath: keyForSection)
//        reference.observe(.value, with: { snapshot in
//            let dataArray = self.populateArray(withSnapshot: snapshot)
//            completion(dataArray)
//        })
//    }
//
//    fileprivate func firebaseRequestStringForType(_ type: RequestType) -> String {
//        return baseURL + destinationPathForSection(type)
//    }
//
//    fileprivate func destinationPathForSection(_ type: RequestType) -> String {
//        switch type {
//        case .iOS:
//            return "iOS technical questions"
//        case .dataStructures:
//            return "data structure questions"
//        case .algorithms:
//            return "algorithm questions"
//        }
//    }
//
//    fileprivate func populateArray(withSnapshot snapshot: FIRDataSnapshot) -> [JSON] {
//        var firebaseArray = [JSON]()
//        for dict in (snapshot.value as [[String: Any]]).allValues {
//            if let dict = dict as [String: Any] {
//            firebaseArray.append(dict as JSON)
//            }
//            }
//        return firebaseArray
//    }
//}
