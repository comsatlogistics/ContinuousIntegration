//
//  Shuffle.swift
//  Numerals
//
//  Created by Small Factory Studios on 11/30/19.
//  Copyright © 2019 Ray Dolber. All rights reserved.
//

import Foundation

extension MutableCollection {
  /// Shuffles the contents of this collection.
  mutating func shuffle() {
    //
    let c = count
    guard c > 1 else { return }
    
    for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
      let d = Int(arc4random_uniform(numericCast(unshuffledCount)))
      let i = index(firstUnshuffled, offsetBy: d)
      swapAt(firstUnshuffled, i)
    }
  }
}

extension Sequence {
  /// Returns an array with the contents of this sequence, shuffled.
  func shuffled() -> [Element] {
    var result = Array(self)
    result.shuffle()
    return result
  }
}

extension String {
  func garbled() -> String {
    return String(shuffled())
  }
}
