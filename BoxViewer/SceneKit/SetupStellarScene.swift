//
//  SetupStellarScene.swift
//  BoxViewer
//
//  Created by Eric Freitas on 3/5/23.
//

import Foundation
import SceneKit

func SetupStellarScene(scene: SCNScene) {
  let pObj = OrbitalElements(position: SCNVector3(x: 0, y: 0, z: 0), eccentricity: 0.0, semiMajAxis: 0.2, inclination: 20.0, lngAscNode: 270.0, argOfPeriapsis: 90.0, trueAnomaly: 56.0)
  let sObj = OrbitalElements(position: SCNVector3(x: 0, y: 0, z: 0), eccentricity: 0.0, semiMajAxis: 2.0, inclination: 20.0, lngAscNode: 270.0, argOfPeriapsis: 90.0, trueAnomaly: (45 + 180))
  
  let systemNode = SCNNode()
  let primaryNode = SCNNode()
  let secondaryNode = SCNNode()
  
  systemNode.geometry = SCNSphere(radius: 0.01)
  systemNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
  scene.rootNode.addChildNode(systemNode)
  
  //    primaryNode.geometry = SCNSphere(radius: 0.1)
  primaryNode.geometry = createFiboSphere(radius: 0.1)
  primaryNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
  primaryNode.geometry?.firstMaterial?.emission.contents = UIColor.green
  primaryNode.position = getPointOnEllipse(θ: pObj.trueAnomaly, semiMajAxis: pObj.semiMajAxis, e: pObj.eccentricity)
  systemNode.addChildNode(primaryNode)
  
  secondaryNode.geometry = SCNSphere(radius: 0.05)
  secondaryNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
  secondaryNode.position = getPointOnEllipse(θ: sObj.trueAnomaly, semiMajAxis: sObj.semiMajAxis, e: sObj.eccentricity)
  systemNode.addChildNode(CreateTrack(radius: sObj.semiMajAxis))
  systemNode.addChildNode(CreateTrack(radius: pObj.semiMajAxis))
  systemNode.addChildNode(secondaryNode)
  
  // incline the system node
  systemNode.eulerAngles.x = Float(deg2rad(pObj.inclination))
  // longitude of ascending node
  systemNode.eulerAngles.y = Float(deg2rad(pObj.lngAscNode))
  
  // Primary orbit
  let pOrbitAction = SCNAction.customAction(duration: 10.0) { node, interval in
    let theta = ((interval / 10.0) * 360) - 180
    node.position = getPointOnEllipse(θ: theta, semiMajAxis: pObj.semiMajAxis, e: pObj.eccentricity) // 0.3, 0.2
  }
  let pOrbitSequence = SCNAction.sequence([pOrbitAction])
  let pOrbitLoop = SCNAction.repeatForever(pOrbitSequence)
  //    primaryNode.runAction(pOrbitLoop)
  
  // Secondary orbit
  let sOrbitAction = SCNAction.customAction(duration: 10.0) { node, interval in
    let theta = (interval / 10.0) * 360
    node.position = getPointOnEllipse(θ: theta, semiMajAxis: sObj.semiMajAxis, e: sObj.eccentricity) // 2.0, 0.4
  }
  let sOrbitSequence = SCNAction.sequence([sOrbitAction])
  let sOrbitLoop = SCNAction.repeatForever(sOrbitSequence)
  //    secondaryNode.runAction(sOrbitLoop)
  
  // set the background color of the scene to black
  scene.background.contents = UIColor.black
}
