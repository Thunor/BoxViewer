//
//  SCNNode+Track.swift
//  BoxViewer
//
//  Created by Eric Freitas on 4/30/23.
//

import Foundation
import SceneKit

extension SCNNode {
    /// This will create an orbit track for either a star in a multiple star system, or for a planet
    /// orbiting a star.
    func createTrack(radius: Double) -> SCNNode {
        let eulerX = 90.0
        let circle = SCNNode()
        let geometry = SCNTorus(ringRadius: CGFloat(radius) - 0.01, pipeRadius: 0.01)
        geometry.ringSegmentCount = 60
        circle.geometry = geometry
        circle.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        circle.geometry?.firstMaterial?.emission.contents = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        circle.position = SCNVector3(x: 0, y: 0, z: 0)
        circle.name = "orbitTrack"
        circle.eulerAngles.x = Float(eulerX.deg2rad())
        circle.renderingOrder = 1
        return circle
    }
}
