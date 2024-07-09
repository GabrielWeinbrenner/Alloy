//
//  Player.swift
//  Alloy
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//
import Foundation

class Player: GameObject {
    init() {
        super.init(meshType: .Quad)
    }
    override func update(deltaTime: Float) {
//        self.position = SIMD3<Float>(cos(time*2), 0, 0)
//        self.scalar = SIMD3<Float>(1, abs(cos(time*4) + 0.2), 1)
        self.rotation.z = cos(time*5)
        super.update(deltaTime: deltaTime)
    }
}
