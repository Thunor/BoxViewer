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

struct OrbitalElements {
    /// Angles are in degrees
    var position: SCNVector3  // REMOVE and use Xg/Yg/Zg in StarSystem
    var eccentricity: Double      // eccentricity of the ellipse
    var semiMajAxis: Double       // sum of the periapsis and apoapsis divided by two
                                  // measured from the center of the body to the center of mass of both bodies
    var inclination: Double       // angle - vertical tilt of the ellipse with respect to the reference plane
    var lngAscNode: Double        // angle - orients the ascending node with respect to the reference plane and the vernal point,
                                  //          which should probably be the center point of the sector.
    var argOfPeriapsis: Double    // angle - orients the ellipse (rotates in its own plane) measured from the ascending node to
                                  //          the periapsis.
    var trueAnomaly: Double       // angle - defines the position of the object along the ellipse at a specific time or epoch
    
    /// Find the position of the object along it's elliptical orbit given the offset from the start offset in degrees.
    /// - Parameter θ: The position of the object along the ellipse in degrees.
    /// - Returns: The position as an SCNVector3 relative to center of mass.
    func getPointOnEllipse(θ: Double) -> SCNVector3 {
        
        let a = semiMajAxis - (semiMajAxis * eccentricity)
        let theta = (θ + trueAnomaly).deg2rad()
        let r = (a * (1 - eccentricity * eccentricity)) / (1 + eccentricity * cos(theta))
        let x = r * cos(theta)
        let y = r * sin(theta)
        
        return SCNVector3(x: Float(x), y: Float(y), z: 0)
    }
    
    /// Find the position of the object along it's elliptical orbit using the trueAnomaly.
    /// - Returns: The position as an SCNVector3 relative to center of mass.
    func getFixedPointOnEllipse() -> SCNVector3 {
        return getPointOnEllipse(θ: trueAnomaly)
    }
}
