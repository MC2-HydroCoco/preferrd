//
//  StringHelper.swift
//  preferrd
//
//  Created by Timothy Ananda on 15/06/21.
//

import Foundation

extension StringProtocol {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}
