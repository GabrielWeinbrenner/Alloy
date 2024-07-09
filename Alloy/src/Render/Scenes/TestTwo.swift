//
//  Sandbox.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/9/24.
//

import MetalKit

class TestTwo: Scene {
    var gameObject = TriangleTwo()
    override func buildScene() {
        self.addChild(gameObject)
    }
}

class TriangleTwo: GameObject {
    init() {
        super.init(meshType: .Triangle)
    }
    override func updateVal() {
        self.scalar = SIMD3<Float>(repeating: abs(cos(time)))
    }
}
