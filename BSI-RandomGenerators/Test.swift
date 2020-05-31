//
//  tests.swift
//  POD_lab5
//
//  Created by Adam Linke on 21/11/2017.
//  Copyright © 2017 Adam Linke. All rights reserved.
//

import Foundation
class Test {
    let receivedRandomGeneratedBinaryString: String
    init(_ randomGeneratedBinaryString: String) {
        self.receivedRandomGeneratedBinaryString = randomGeneratedBinaryString
    }
    func randomTest() -> (NumberOf0: Int, NumberOf1: Int) {
        var numberOf0 = 0
        var numberOf1 = 1
        for index in receivedRandomGeneratedBinaryString {
            if index == "0" {
                numberOf0 += 1
            } else {
                numberOf1 += 1
            }
        }
        return (numberOf0, numberOf1)
    }
    func seriesTest() -> [Int] {
        var HowManySeries = [0,0,0,0,0,0]

        var lastSign = receivedRandomGeneratedBinaryString.first
        var buffer = 0
        for index in receivedRandomGeneratedBinaryString {
            if index == lastSign {
                buffer += 1
            } else  if buffer != 0 {
                if buffer < 7 {
                    HowManySeries[buffer - 1] += 1
                } else {
                    HowManySeries[5] += 1
                }
                buffer = 0
                lastSign = index
            }
        }
        return HowManySeries
    }
    func longSeriesTest() -> Bool { //returns true if test is passed returns false if not
        var buffer = 0
        var lastSign = receivedRandomGeneratedBinaryString.first
        for index in receivedRandomGeneratedBinaryString  {
            if index == lastSign {
                buffer += 1
                if buffer == 26 {
                    return false
                }
            } else {
                buffer = 0
                lastSign = index
            }
        }
        return true
    }
    func pokerTest() -> Double { // should be corrected for values which aren't even etc.
        var Combination = [Int](repeating: 0, count: 16)
        var Segments = [String](repeating: "", count: receivedRandomGeneratedBinaryString.count / 4 + 1) // 30569,
        var count = 0
        for index in receivedRandomGeneratedBinaryString { // dividing into smaller segments
            Segments[count / 4] += String(index)
            count += 1
        }
        for index in Segments { // checking how often combinations repeat
            if let number = Int(index, radix: 2) {
                Combination[number] += 1
            }
        }
        var x: Double
        var s = 0
        for index in Combination { //poker test
            s += index * index
        }
        x = 16 / Double(receivedRandomGeneratedBinaryString.count / 4) * Double(s) - 5000
        return x
    }
}

