//
//  CelestialObjects.swift
//  BoxViewer
//
//  Created by Eric Freitas on 2/1/23.
//

import Foundation
import SceneKit

/// This will create an orbit track for either a star in a multiple star system, or for a planet
/// orbiting a star.
func CreateTrack(radius: Double) -> SCNNode {
  let circle = SCNNode()
  let geometry = SCNTube(innerRadius: CGFloat(radius) - 0.01, outerRadius: CGFloat(radius) + 0.01, height: 0.01)
  geometry.radialSegmentCount = 60
  circle.geometry = geometry
  circle.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
  circle.position = SCNVector3(x: 0, y: 0, z: 0)
  circle.name = "orbitTrack"
  circle.eulerAngles.x = Float(deg2rad(90))
  return circle
}

