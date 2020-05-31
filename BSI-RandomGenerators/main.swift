//
//  main.swift
//  BSI-RandomGenerators
//
//  Created by Adam Linke on 30/05/2020.
//  Copyright © 2020 Adam Linke. All rights reserved.
//

import Foundation
import GameplayKit

print("ARC4")
let arc4 = GKARC4RandomSource()
var arc4GeneratedNumbers: [Int] = []
for _ in 0...1_000 {
    arc4GeneratedNumbers.append(abs(arc4.nextInt()))
}
let arc4NumbersAsBinaryString = String(generateBinaryString(from: arc4GeneratedNumbers).prefix(20_000))
let arc4Test = Test(arc4NumbersAsBinaryString)
print(arc4Test.randomTest()) // (NumberOf0: 9749, NumberOf1: 10252) // zdał
print(arc4Test.seriesTest()) // [2511, 1225, 634, 346, 160, 158] // zdał
print(arc4Test.longSeriesTest()) // true // zdał
print(arc4Test.pokerTest()) // 26.195200000000114 .. zdał


print("MERSENNE-TWISTER")
let mersenne = GKMersenneTwisterRandomSource()
var mersenneGeneratedNumbers: [Int] = []
for _ in 0...1_000 {
    mersenneGeneratedNumbers.append(abs(mersenne.nextInt()))
}
let mersenneNumbersAsBinaryString = String(generateBinaryString(from: mersenneGeneratedNumbers).prefix(20_000))
let mersenneTest = Test(mersenneNumbersAsBinaryString)
print(mersenneTest.randomTest()) // (NumberOf0: 9713, NumberOf1: 10288) // Nie zdał
print(mersenneTest.seriesTest()) // [2489, 1261, 609, 315, 164, 142] // zdał
print(mersenneTest.longSeriesTest()) // true
print(mersenneTest.pokerTest()) // 25.747199999999793 // zdał

print("LCG")
let lcgApple = GKLinearCongruentialRandomSource()
var lcgAppleGeneratedNumbers: [Int] = []
for _ in 0..<5_000 {
    lcgAppleGeneratedNumbers.append(abs(lcgApple.nextInt()))
}
let lcgAppleNumbersAsBinaryString = String(generateBinaryString(from: lcgAppleGeneratedNumbers).prefix(20_000))
let lcgAppleTest = Test(lcgAppleNumbersAsBinaryString)
print(lcgAppleTest.randomTest()) // (NumberOf0: 9844, NumberOf1: 10157) (test pojednczych bitów 9725-10275
print(lcgAppleTest.seriesTest()) // [2519, 1289, 592, 314, 159, 157] (test serii) [2315-2685], [1114-1386], [527-723], [240-384], [103-209], [103-209]
print(lcgAppleTest.longSeriesTest()) // true (test długiej serii) , true(nie ma serii 26 bitów lub więcej)
print(lcgAppleTest.pokerTest()) // 24.364800000000287 (test pokerowy), [2,16-46,17]


func generateBinaryString(from numbers: [Int]) -> String {
    var stringBits: String = ""
    for number in numbers {
        stringBits.append(String(number, radix: 2))
    }
    return stringBits
}


/// Own implementations tests
let bbs = BBS()
let bbsResult = bbs.generateBinaryRandomString(length: 20_000) // length in number of bits
let bbsTest = Test(bbsResult)
print("Test 1")
print(bbsTest.randomTest())
print("Test 2")
print(bbsTest.seriesTest())
print("Test 3")
print(bbsTest.longSeriesTest())
print("Test 4")
print(bbsTest.pokerTest())

let lcg = LCG(implementation: .ANSI_C, seed: 4324234)
let lcgResult = lcg?.generateRandomString(length: 20_000)
let lcgTest = Test(lcgResult!)
print("Test 1")
print(lcgTest.randomTest())
print("Test 2")
print(lcgTest.seriesTest())
print("Test 3")
print(lcgTest.longSeriesTest())
print("Test 4")
print(lcgTest.pokerTest())
