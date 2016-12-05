//
//  QueryManager.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 11/2/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import Foundation
import Firebase

public protocol Networking {
    func getData(for requestType: RequestType, completion: ([[NSObject: AnyObject]]) -> Void)
}

public enum RequestType: Int {
    case iOS
    case DataStructures
    case Algorithms
}

class QueryManager: Networking {

    // MARK: Private Properties
    private let baseURL = "https://fiery-torch-4131.firebaseio.com/"

    // MARK: Actions
    func getData(for requestType: RequestType, completion: ([[NSObject: AnyObject]]) -> Void) {
        let reference = Firebase(url: baseURL)
        let keyForSection = destinationPathForSection(requestType)
        reference.queryOrderedByKey().observeEventType(FEventType.ChildAdded, withBlock: { snapshot in
            if (snapshot.key == keyForSection) {
                let fireBaseDataArray = self.populateArrayWithSnapshot(snapshot)
                completion(fireBaseDataArray)
            }
        })
    }

    private func childrenCountForSection(type: RequestType, withCompletion completion: (count: Int) -> Void) {
        let ref = Firebase(url: baseURL)
        ref.queryOrderedByChild(destinationPathForSection(type))
            .queryLimitedToFirst(1)
            .observeEventType(FEventType.ChildAdded, withBlock: { snapshot -> Void in
            let children = Int(snapshot.childrenCount)
            completion(count: children)
        })
    }
    
    private func firebaseRequestStringForType(type: RequestType) -> String {
        return baseURL.stringByAppendingString(destinationPathForSection(type))
    }
    
    private func destinationPathForSection(type: RequestType) -> String {
        switch type {
        case .iOS:
            return "iOS technical questions"
        case .DataStructures:
            return "data structure questions"
        case .Algorithms:
            return "algorithm questions"
        }
    }
    
    private func populateArrayWithSnapshot(snapshot: FDataSnapshot) -> [[NSObject: AnyObject]] {
        var firebaseArray = [[NSObject: AnyObject]]()
        for dict in snapshot.valueInExportFormat().allValues {
            firebaseArray.append(dict as! [NSObject : AnyObject])
            }
        return firebaseArray
    }
}
