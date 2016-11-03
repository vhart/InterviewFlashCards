//
//  QueryManager.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 11/2/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import Foundation
import Firebase

enum RequestType: Int {
    case RequestTypeiOS = 1
    case RequestTypeDataStructures
    case RequestTypeAlgorithms
}

class QueryManager: NSObject {
    
    private let baseURL = "https://fiery-torch-4131.firebaseio.com/"
    
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

    func childrenCountForSection(type: RequestType, withCompletion completion: (count: Int) -> Void) {
        let ref = Firebase(url: baseURL)
        ref.queryOrderedByChild(destinationPathForSection(type))
            .queryLimitedToFirst(1)
            .observeEventType(FEventType.ChildAdded, withBlock: { snapshot -> Void in
            let children = Int(snapshot.childrenCount)
            completion(count: children)
        })
    }
    
    func firebaseRequestStringForType(type: RequestType) -> String {
        return baseURL.stringByAppendingString(destinationPathForSection(type))
    }
    
    func destinationPathForSection(type: RequestType) -> String {
        switch type {
        case .RequestTypeiOS:
            return "iOS technical questions"
        case .RequestTypeDataStructures:
            return "data structure questions"
        case .RequestTypeAlgorithms:
            return "algorithm questions"
        }
    }
    
    func populateArrayWithSnapshot(snapshot: FDataSnapshot) -> [[NSObject: AnyObject]] {
        var firebaseArray = [[NSObject: AnyObject]]()
        for dict in snapshot.valueInExportFormat().allValues {
            firebaseArray.append(dict as! [NSObject : AnyObject])
            }
        return firebaseArray
    }
}
