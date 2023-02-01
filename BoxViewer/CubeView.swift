//
//  CubeView.swift
//  Far Stars (macOS)
//
//  Created by Eric Freitas on 1/11/23.
//

import SwiftUI
import SceneKit


struct CubeView: View {
  var pObj: CelestialBody
  var sObj: CelestialBody
  
  var body: some View {
    let scene = SCNScene()
    let sceneView = SceneView(scene: scene, options: [.allowsCameraControl, .autoenablesDefaultLighting])
    let cameraNode = SCNNode()
    let primaryNode = SCNNode()
    let secondaryNode = SCNNode()
    
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
    scene.rootNode.addChildNode(cameraNode)
    
    primaryNode.geometry = SCNSphere(radius: 0.1)
    primaryNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
    scene.rootNode.addChildNode(primaryNode)
    
    secondaryNode.geometry = SCNSphere(radius: 0.05)
    secondaryNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//    secondaryNode.eulerAngles.x = Float(deg2rad(45))
    scene.rootNode.addChildNode(secondaryNode)
    
    // Primary orbit
    let pOrbitAction = SCNAction.customAction(duration: 10.0) { node, interval in
      let theta = ((interval / 10.0) * 360) - 180
      node.position = getPointOnEllipse(θ: theta, semiMajAxis: pObj.semiMajAxis, e: pObj.eccentricity) // 0.3, 0.2
    }
    let pOrbitSequence = SCNAction.sequence([pOrbitAction])
    let pOrbitLoop = SCNAction.repeatForever(pOrbitSequence)
    primaryNode.runAction(pOrbitLoop)
    
    // Secondary orbit
    let sOrbitAction = SCNAction.customAction(duration: 10.0) { node, interval in
      let theta = (interval / 10.0) * 360
      node.position = getPointOnEllipse(θ: theta, semiMajAxis: sObj.semiMajAxis, e: sObj.eccentricity) // 2.0, 0.4
    }
    let sOrbitSequence = SCNAction.sequence([sOrbitAction])
    let sOrbitLoop = SCNAction.repeatForever(sOrbitSequence)
    secondaryNode.runAction(sOrbitLoop)
    
    // oval path
    let semiMinorAxis = sObj.semiMajAxis * (1 - (sObj.eccentricity * sObj.eccentricity)).squareRoot()
    let pPath = UIBezierPath(ovalIn: CGRect(x: -sObj.semiMajAxis, y: -semiMinorAxis, width: sObj.semiMajAxis * 2, height: semiMinorAxis * 2))
    pPath.flatness = 0.02
    let pMaterial = SCNMaterial()
    pMaterial.diffuse.contents = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    pMaterial.isDoubleSided = true
    let pShape = SCNShape(path: pPath, extrusionDepth: 0.001)
    pShape.materials = [pMaterial]
    
    let ovalNode = SCNNode()
    ovalNode.geometry = pShape
    scene.rootNode.addChildNode(ovalNode)
    
    // set the background color of the scene to black
    scene.background.contents = UIColor.black
  
    return sceneView
  }
}

struct CubeView_Previews: PreviewProvider {
  static var previews: some View {
    let pObj = CelestialBody(position: SCNVector3(x: 0, y: 0, z: 0), eccentricity: 0.2, semiMajAxis: 0.2, inclination: 20.0, lngAscNode: 270.0, argOfPeriapsis: 90.0, trueAnomaly: 45.0)
    let sObj = CelestialBody(position: SCNVector3(x: 0, y: 0, z: 0), eccentricity: 0.2, semiMajAxis: 2.0, inclination: 20.0, lngAscNode: 270.0, argOfPeriapsis: 90.0, trueAnomaly: 45.0)
    
    CubeView(pObj: pObj, sObj: sObj)
  }
}
