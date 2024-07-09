//
//  Sandbox.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/9/24.
//

import MetalKit

class Sandbox: Scene {
    var player = Player()
    var gameObject = Triangle()
    override func buildScene() {
        self.addChild(player)
        self.addChild(gameObject)
    }
}

class Triangle: GameObject {
    init() {
        super.init(meshType: .Triangle)
    }
    override func updateVal() {
        self.scalar = SIMD3<Float>(repeating: abs(cos(time)))
    }
}
