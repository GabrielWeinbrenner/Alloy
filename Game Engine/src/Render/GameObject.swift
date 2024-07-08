//
//  GameObject.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//
import MetalKit

class GameObject {
    typealias Vertex = VertexLibrary.Vertex
    
    var vertices: [Vertex] = [];
    var vertexBuffer: MTLBuffer!;
    
    init() {
        self.vertices = [
            Vertex(position: SIMD3<Float>(0,1,0), color: SIMD4(1,0,0,1)),
            Vertex(position: SIMD3<Float>(-1,-1,0), color: SIMD4(0,1,0,1)),
            Vertex(position: SIMD3<Float>(1,-1,0), color: SIMD4(0,0,1,1)),
        ]

        createBuffers(from: self.vertices)
    }
    
    func createBuffers(from vertices: [VertexLibrary.Vertex]) {
        vertexBuffer = Engine.device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<VertexLibrary.Vertex>.stride, options: [])
    }
    
    func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Engine.renderPipelineLibrary.getRenderPipelineDescriptor(.Basic))
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)

    }


}
