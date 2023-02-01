//
//  Body.swift
//  BoxViewer
//
//  https://en.wikipedia.org/wiki/Orbital_elements
//
//  Created by Eric Freitas on 1/31/23.
//

import Foundation
import SceneKit

struct CelestialBody {
  /// Angles are in degrees
  var position: SCNVector3
  var eccentricity: Double      // eccentricity of the ellipse
  var semiMajAxis: Double       // sum of the periapsis and apoapsis divided by two
                                // measured from the center of the body to the center of mass of both bodies
  var inclination: Double       // angle - vertical tilt of the ellipse with respect to the reference plane
  var lngAscNode: Double        // angle - orients the ascending node with respect to the reference plane and the vernal point,
                                //          which should probably be the center point of the sector.
  var argOfPeriapsis: Double    // angle - orients the ellipse (rotates in its own plane) measured from the ascending node to
                                //          the periapsis.
  var trueAnomaly: Double       // angle - defines the position of the object along the ellipse at a specific time or epoch
}
