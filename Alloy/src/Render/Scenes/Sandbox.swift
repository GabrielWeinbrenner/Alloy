//
//  Sandbox.swift
//  Alloy
//
//  Created by Gabriel Weinbrenner on 7/9/24.
//

import MetalKit

class Sandbox: Scene {
    var player = Player()
    var triangles: [Triangle] = []
    var debugCamera = DebugCamera()
    override func buildScene() {
        addCamera(debugCamera)
        let rows = 5
        let columns = 5
        let spacing: Float = 0.1

        for row in -rows..<rows {
            for column in -columns..<columns {
                let triangle = Triangle()
                triangle.position = SIMD3<Float>(
                    Float(column) * spacing,
                    Float(row) * spacing,
                    0
                )
                addChild(triangle)
                triangles.append(triangle)
            }
        }

        // Example to add player and other game objects
        player.scalar = SIMD3<Float>(repeating: 0.1)
        addChild(player)
    }

    override func update(_ deltaTime: Float) {
        let speed: Float = Keyboard.IsKeyPressed(.q) ? 0.1 : 0.01
        if Keyboard.IsKeyPressed(.leftArrow) {
            player.position.x -= deltaTime
        }
        if Keyboard.IsKeyPressed(.rightArrow) {
            player.position.x += deltaTime
        }
        if Keyboard.IsKeyPressed(.upArrow) {
            player.position.y += deltaTime
        }
        if Keyboard.IsKeyPressed(.downArrow) {
            player.position.y -= deltaTime
        }
        if Keyboard.IsKeyPressed(.a) {
            print(player.position)
        }
        for triangle in triangles {
            triangle.rotation.z = atan2f(player.position.x - triangle.position.x, player.position.y - triangle.position.y)
        }
        super.update(deltaTime)
    }
}

class Triangle: GameObject {
    init() {
        super.init(meshType: .Triangle)
        self.scalar = SIMD3<Float>(0.1,0.3,0.1)
    }
    override func update(_ deltaTime: Float) {
        // Example of animating the triangle
        // self.scalar = SIMD3<Float>(repeating: abs(cos(time)))
        super.update(deltaTime)
    }
}
