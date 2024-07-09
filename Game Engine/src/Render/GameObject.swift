//
//  GameObject.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//
import MetalKit

struct ModelConstants {
    var modelMatrix: matrix_float4x4!
}
class GameObject: Node {
    var mesh: Mesh
    var modelConstants = ModelConstants()
    
    init(meshType: MeshTypes) {
        mesh = Engine.meshLibrary.getMesh(meshType)
    }
    
    var time: Float = 0
    func update(deltaTime: Float) {
        time += deltaTime
//        self.position = SIMD3<Float>(cos(time*2), 0, 0)
//        self.scalar = SIMD3<Float>(1, abs(cos(time*4) + 0.2), 1)
        self.rotation.z = cos(time*20)
        updateModelConstants(deltaTime: deltaTime)
    }
    
    private func updateModelConstants(deltaTime: Float) {
        modelConstants.modelMatrix = self.modelMatrix
    }
}

extension GameObject: Renderable {
    func commitRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
//        renderCommandEncoder.setTriangleFillMode(.lines)
        renderCommandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
        renderCommandEncoder.setRenderPipelineState(Engine.renderPipelineLibrary.getRenderPipelineDescriptor(.Basic))
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)
        

    }
}
