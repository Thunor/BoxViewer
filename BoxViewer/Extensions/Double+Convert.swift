//
//  Double+Convert.swift
//  BoxViewer
//
//  Created by Eric Freitas on 4/30/23.
//

import Foundation

extension Double {
    func deg2rad() -> Double {
        self * .pi / 180
    }

    func rad2deg() -> Double {
        self * 180 / .pi
    }
}
