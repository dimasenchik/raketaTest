//
//  ArrayExtensions.swift
//  RaketaTest
//
//  Created by Dima Senchik on 01.10.2020.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
