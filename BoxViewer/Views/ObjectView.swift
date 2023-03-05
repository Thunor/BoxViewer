//
//  Setup.swift
//  BoxViewer
//
//  Created by Eric Freitas on 3/4/23.
//

import Foundation
import SceneKit
import SwiftUI


struct ObjectView: View {

  var body: some View {
    let scene = SCNScene()
    let sceneView = SceneView(scene: scene, options: [.allowsCameraControl, .autoenablesDefaultLighting])
      .edgesIgnoringSafeArea(.all)
    
    let cameraNode = SCNNode()
    cameraNode.name = "MainCamera"
    cameraNode.camera = SCNCamera()
    cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
    scene.rootNode.addChildNode(cameraNode)
    
    SetupStellarScene(scene: scene)
    
    return sceneView
  }  
}
