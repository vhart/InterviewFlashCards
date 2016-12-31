//
//  QueryManager.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 11/2/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

public typealias JSON = [[String: Any]]
public protocol Networking {
    func getData(for requestType: RequestType,
                     completion: @escaping (JSON) -> Void)
}

public enum RequestType: Int {
    case iOS
    case dataStructures
    case algorithms
}

class QueryManager: Networking {
    // MARK: Private Properties
    fileprivate let baseURL = "https://fiery-torch-4131.firebaseio.com/"

    func getData(for requestType: RequestType, completion: @escaping (JSON) -> Void) {
        let keyForSection = destinationPathForSection(requestType)
        let reference = FIRDatabase.database().reference(withPath: keyForSection)
        reference.observe(.value, with: { snapshot in
            let dataArray = self.populateArray(withSnapshot: snapshot)
            completion(dataArray)
        })
//        reference?.queryOrderedByKey().observe(FEventType.childAdded, with: { snapshot in
//            if let snapshot = snapshot,
//                snapshot.key == keyForSection {
//                let fireBaseDataArray = self.populateArrayWithSnapshot(snapshot)
//                completion(fireBaseDataArray)
//
//            }
//        })
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

    fileprivate func populateArray(withSnapshot snapshot: FIRDataSnapshot) -> JSON {
        var firebaseArray = JSON()
        for dict in (snapshot.valueInExportFormat() as AnyObject).allValues {
            firebaseArray.append(dict as! [String: Any])
            }
        return firebaseArray
    }
}
