//
//  Array+Extensions.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 08/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
