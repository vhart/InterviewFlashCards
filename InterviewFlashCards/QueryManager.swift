//
//  QueryManager.swift
//  InterviewFlashCards
//
//  Created by Charles Kang on 11/2/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import Foundation
import Firebase

enum RequestType {
    case iOS
    case DataStructures
    case Algorithms
    case Error
}

class QueryManager: NSObject {
    
    let BASE_URL = "https://fiery-torch-4131.firebaseio.com/"
    
    func getDataForRequest(type: RequestType, completion: ([[NSObject: AnyObject]]) -> Void) {
        let ref = Firebase(url: BASE_URL)
        let keyForSection = self.destinationPathForSection(type)
        
        ref.queryOrderedByKey().observeEventType(FEventType.ChildAdded, withBlock: { snapshot in
            if (snapshot.key == keyForSection) {
                let fireBaseDataArray = self.populateArrayWithSnapshot(snapshot)
                completion(fireBaseDataArray)
            }
        })
    }
    
    func childrenCountForSection(type: RequestType, withCompletion completion: (count: Int) -> Void) {
        let ref = Firebase(url: BASE_URL)
        ref.queryOrderedByChild(self.destinationPathForSection(type)).queryLimitedToFirst(1).observeEventType(FEventType.ChildAdded, withBlock: { snapshot -> Void in
            let children = Int(snapshot.childrenCount)
            completion(count: children)
        })
    }
    
    func firebaseRequestStringForType(type: RequestType) -> String {
        return BASE_URL.stringByAppendingString(self.destinationPathForSection(type))
    }
    
    
    func destinationPathForSection(type: RequestType) -> String {
        switch type {
        case .iOS:
            return "iOS technical questions"
        case .DataStructures:
            return "data structure questions"
        case .Algorithms:
            return "algorithm questions"
        case .Error:
            return "Error"
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