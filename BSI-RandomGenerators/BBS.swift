//
//  BBS.swift
//  POD_lab5
//
//  Created by Adam Linke on 23/11/2017.
//  Copyright © 2017 Adam Linke. All rights reserved.
//
// blum blum shub
import Foundation
class BBS {
    let p: Int
    let q: Int
    let blumNumber: Int //computed property
    let seed: Int

    // t string length
    // x = x0
    init (p: Int, q: Int, seed: Int){
        self.p = p
        self.q = q
        blumNumber = p * q
        self.seed = seed
    }
    init(seed: Int) { //initialization with partially example values
        self.p = 14323
        self.q = 20107
        blumNumber = p * q
        self.seed = seed
    }
    init() { //initialization with example values
        self.p = 14323
        self.q = 20107
        blumNumber = p * q
        self.seed = 2432432432
    }
    func generateBinaryRandomString(length: Int) -> String {
        var generatedCode = ""
        let x0 = (seed << 1) % blumNumber
        var previousX = x0
        for _ in 1 ... length {
            let newX = (previousX << 1) % blumNumber
            previousX = newX
            let xInBinary = String(newX, radix: 2)
            let xLastBinaryNumber = xInBinary.last!
            generatedCode += String(xLastBinaryNumber)
        }
        return generatedCode
    }
}

