//
//  SCNScene+StellarSetup.swift
//  BoxViewer
//
//  Created by Eric Freitas on 4/30/23.
//

import Foundation
import SceneKit
import SceneKit.ModelIO

extension SCNScene {
    
    func setupStellarScene(animate: Bool = true) {
        let pObj = OrbitalElements(position: SCNVector3(x: 0, y: 0, z: 0), eccentricity: 0.0, semiMajAxis: 0.2, inclination: 20.0, lngAscNode: 270.0, argOfPeriapsis: 90.0, trueAnomaly: 56.0)
        let sObj = OrbitalElements(position: SCNVector3(x: 0, y: 0, z: 0), eccentricity: 0.0, semiMajAxis: 2.0, inclination: 20.0, lngAscNode: 270.0, argOfPeriapsis: 90.0, trueAnomaly: (45 + 180))
        
        let systemNode = SCNNode()
        var primaryNode = SCNNode()
        var secondaryNode = SCNNode()
        
        systemNode.geometry = SCNSphere(radius: 0.01)
        systemNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        rootNode.addChildNode(systemNode)
        
        primaryNode = createNodeForObj(radius: 0.1, color: .yellow, orbElems: pObj)
        systemNode.addChildNode(primaryNode.createTrack(radius: pObj.semiMajAxis))
        systemNode.addChildNode(primaryNode)
        
        secondaryNode = createNodeForObj(radius: 0.05, color: .brown, orbElems: sObj)
        systemNode.addChildNode(secondaryNode.createTrack(radius: sObj.semiMajAxis))
        systemNode.addChildNode(secondaryNode)
        
        // incline the system node
        systemNode.eulerAngles.x = Float(pObj.inclination.deg2rad())
        // longitude of ascending node
        systemNode.eulerAngles.y = Float(pObj.lngAscNode.deg2rad())
        
        if animate {
            animateOrbit(celObj: pObj, node: primaryNode)
            animateOrbit(celObj: sObj, node: secondaryNode)
            animateRotation(node: primaryNode)
        }
        
        // set the background color of the scene to black
        background.contents = UIColor.black
    }
    
    private func createNodeForObj(radius: CGFloat, color: UIColor, orbElems: OrbitalElements) -> SCNNode {
        let starNode = SCNNode()
        
        starNode.geometry = SCNSphere(radius: radius)
        // Uncomment the two lines below to use Fibonacci Spheres
        //let fiboGeo = SCNGeometry()
        //starNode.geometry = fiboGeo.createFiboSphere(radius: radius)
        
        starNode.geometry?.firstMaterial?.diffuse.contents = color
        starNode.geometry?.firstMaterial?.emission.contents = color
        starNode.position = orbElems.getFixedPointOnEllipse()
        addDiscLight(to: starNode, color: color)
        return starNode
    }
    
    /// This method is not quite right, especially during animation.
    private func addDiscLight(to node: SCNNode, color: UIColor) {
        let lightModel = MDLAreaLight()
        lightModel.lightType = .discArea
        
        let starlightNode = SCNNode()
        starlightNode.light = SCNLight(mdlLight: lightModel)
        starlightNode.light?.color = color
        starlightNode.position = node.position
        node.addChildNode(starlightNode)
    }
    
    // This should be a part of the OrbitalElements struct
    private func animateOrbit(celObj: OrbitalElements, node: SCNNode) {
        let pOrbitAction = SCNAction.customAction(duration: 10.0) { node, interval in
            let theta = ((interval / 10.0) * 360) - 180
            node.position = celObj.getPointOnEllipse(θ: theta) // 0.3, 0.2
        }
        let pOrbitSequence = SCNAction.sequence([pOrbitAction])
        let pOrbitLoop = SCNAction.repeatForever(pOrbitSequence)
        node.runAction(pOrbitLoop)
    }
    
    private func animateRotation(node: SCNNode) {
        let rotAction = SCNAction.customAction(duration: 10) { node, interval in
            let rotAngle = ((interval / 100.0) * 360) - 180
            node.eulerAngles.z = Float(rotAngle)
        }
        let rotSequence = SCNAction.sequence([rotAction])
        let rotLoop = SCNAction.repeatForever(rotSequence)
        node.runAction(rotLoop)
    }
}
