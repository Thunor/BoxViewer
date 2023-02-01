//
//  conversions.swift
//  BoxViewer
//
//  Created by Eric Freitas on 2/1/23.
//

import Foundation

func deg2rad(_ number: Double) -> Double {
  number * .pi / 180
}

func rad2deg(_ number: Double) -> Double {
  number * 180 / .pi
}
