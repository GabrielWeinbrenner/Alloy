//
//  Node.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//
import MetalKit;

class Node {
    var position: SIMD3<Float> = SIMD3<Float>(repeating: 0)
    var scalar: SIMD3<Float> = SIMD3<Float>(repeating: 1)
    var rotation: SIMD3<Float> = SIMD3<Float>(repeating: 0)
    var children: [Node] = []
    var modelMatrix: matrix_float4x4 {
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.scale(by: scalar)
        modelMatrix.translate(by: position)
        modelMatrix.rotate(by: rotation.x, axis: SIMD3<Float>(1,0,0))
        modelMatrix.rotate(by: rotation.y, axis: SIMD3<Float>(0,1,0))
        modelMatrix.rotate(by: rotation.z, axis: SIMD3<Float>(0,0,1))
        return modelMatrix
    }
    
    func addChild(_ child: Node) {
        self.children.append(child)
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder) throws {
        for child in children {
            try child.render(renderCommandEncoder: renderCommandEncoder)
        }
        if let renderable = self as? Renderable {
            try renderable.commitRender(renderCommandEncoder)
        }
    }
    
    func update(deltaTime: Float) {
        for child in children {
            child.update(deltaTime: deltaTime)
        }
    }
}


