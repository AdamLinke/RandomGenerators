//
//  LCG.swift
//  POD_lab5
//
//  Created by Adam Linke on 22/11/2017.
//  Copyright © 2017 Adam Linke. All rights reserved.
//
// Based on materials from Popowczak and wikipedia
// todo: check if the modulus values are correct, fix NAG and APPLE implementation
// todo: generateRandomString() should have option to return particular number of bytes from Xn number
// todo: correct output seed values (for example bits 30...16 for ANSI C)
// todo: correct generateRandomString() to return specific length not length * Xn length
import Foundation
class LCG {
    let m: Int // modulus
    let a: Int // multiplier
    let b: Int // increment
    let x0: Int // seed
    init?(implementation: Implementation, seed: Int) { //seed is start value should be <=0 and <m
        if let valuesToInitialize = LCG.implementationValues(implementation: implementation, seed: seed) {
            self.x0 = seed
            self.a = valuesToInitialize.a
            self.b = valuesToInitialize.b
            self.m = valuesToInitialize.m
        } else {
            return nil
        }
    }
    enum Implementation {
        case ANSI_C
        case MINSTD
        case RANDU
        case Fortran
        case NAG
        case APPLE
    }
    static func implementationValues(implementation: Implementation, seed: Int) -> (m: Int, a: Int, b: Int)? {
        var m = 1
        switch (implementation) {
        case .ANSI_C:
            m <<= 31
            if seed >= 0 && seed < m {
                return (m: m, a: 0x41C64E6D, b: 12356)
            }
        case .MINSTD:
            m <<= 30
            m -= 1
            if seed >= 0 && seed < m {
                return (m: m, a: 16807, b: 0) // a = 7^5
            }
        case .RANDU:
            m <<= 30
            if seed >= 0 && seed < m {
                return (m: m, a: 0x41C64E6D, b: 12356)
            }
        case .Fortran:
            m <<= 31
            m -= 1
            if seed >= 0 && seed < m {
                return (m: m, a: 630360016, b: 0)
            }
        case .NAG: // not working yet (requires BigInt)
            m <<= 58
            if seed >= 0 && seed < m {
                return (m: m, a: Int(pow(13.0,13.0)), b: 0)
            }
        case .APPLE: // not working yet (requires BigInt)
            m <<= 34
            if seed >= 0 && seed < m {
                return (m: m, a: 0x48C227395, b: 0)
            }
        }
        return nil
    }
    func generateRandomString(length: Int) -> String { // returns every Xn number as a String
        var generatedRandomString = ""
        var previousXn = x0
        var Xn: Int
        for _ in 1 ... length {
            Xn = (a*previousXn + b) % m
            generatedRandomString += String(Xn)
            previousXn = Xn
        }
        return generatedRandomString
    }
}

