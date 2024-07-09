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
    func updateVal() {}
    override func update(deltaTime: Float) {
        time += deltaTime
        updateVal()
        updateModelConstants(deltaTime: deltaTime)
    }
    func updateModelConstants(deltaTime: Float) {
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
