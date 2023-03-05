//
//  Points.swift
//  BoxViewer
//
//  Created by Eric Freitas on 2/1/23.
//

import Foundation
import SceneKit

/// Find a point on an ellipse given the theta (θ), semiMajorAxis, and eccentricity (e)
func getPointOnEllipse(θ: Double, semiMajAxis: Double, e: Double) -> SCNVector3 {
  
  let a = semiMajAxis - (semiMajAxis * e)
  let theta = deg2rad(θ)
  let r = (a * (1 - e * e)) / (1 + e * cos(theta))
  let x = r * cos(theta)
  let y = r * sin(theta)

  return SCNVector3(x: Float(x), y: Float(y), z: 0)
}
