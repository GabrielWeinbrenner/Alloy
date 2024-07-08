//
//  GameObject.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//
import MetalKit


class GameObject: Node {
    var mesh: Mesh
    init(meshType: MeshTypes) {
        mesh = Engine.meshLibrary.getMesh(meshType)
    }

}

extension GameObject: Renderable {
    func commitRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
//        renderCommandEncoder.setTriangleFillMode(.lines)
        renderCommandEncoder.setRenderPipelineState(Engine.renderPipelineLibrary.getRenderPipelineDescriptor(.Basic))
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: mesh.vertexCount)

    }
}
