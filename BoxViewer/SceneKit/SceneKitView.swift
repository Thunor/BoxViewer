//
//  SceneKitView.swift
//  BoxViewer
//
//  Created by Eric Freitas on 3/5/23.
//
//  This is necessary in order to get an SCNView (not the SwiftUI SceneView) that conforms
//  to the SCNSceneRenderer protocol.

import SwiftUI
import SceneKit
import Foundation
import UIKit
//import AppKit


struct ScenekitView: UIViewRepresentable {
  
  typealias UIViewType = RightClickableSCNView
  
  var scene: SCNScene
  var view = RightClickableSCNView()
  
  func makeUIView(context: Context) -> RightClickableSCNView {
    // Instantiate the SCNView and setup the scene
    view.scene = scene
    
    return view
  }
  
  func updateUIView(_ nsView: RightClickableSCNView, context: Context) { }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(view)
  }
  
  class Coordinator: NSObject {
    private let view: RightClickableSCNView
    init(_ view: RightClickableSCNView) {
      
      self.view = view
      
      super.init()
    }
  }
}

class RightClickableSCNView: SCNView {
//  override func mouseDown(with theEvent: NSEvent) {
//    //        print("left mouse")
//  }
//
//  override func rightMouseDown(with theEvent: NSEvent) {
//    print("right mouse")
//  }
//
//  override func rightMouseDragged(with event: NSEvent) {
//    print("right mouse dragged: dX: \(event.deltaX), dY: \(event.deltaY)")
//    //      event.deltaX
//  }
}
