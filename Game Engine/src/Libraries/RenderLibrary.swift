//
//  VertexLibrary.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//

import MetalKit
enum RenderDescriptorTypes {
    case Basic
}
class RenderLibrary {
    
    var renderDescriptors: [RenderDescriptorTypes: RenderDescriptor] = [:]
    private var renderDescriptor: MTLRenderPipelineDescriptor?;

    public func ignite(shaderLibrary: ShaderLibrary, vertexLibrary: VertexLibrary) {
        renderDescriptors = [
            .Basic: Basic_RenderDescriptor(shaderLibrary, vertexLibrary)
        ]
        renderDescriptor = renderDescriptors[.Basic]!.renderDescriptor

    }
    
    public func getRenderDescriptor(_ type: RenderDescriptorTypes) -> MTLRenderPipelineDescriptor? {
        renderDescriptor = renderDescriptors[type]!.renderDescriptor
        return renderDescriptor
    }
    
}

protocol RenderDescriptor {
    var name: String { get }
    var renderDescriptor: MTLRenderPipelineDescriptor { get }
}

public struct Basic_RenderDescriptor: RenderDescriptor {
    var name: String = "Basic Render Descriptor"
    
    var renderDescriptor: MTLRenderPipelineDescriptor
    
    init(_ shaderLibrary: ShaderLibrary, _ vertexLibrary: VertexLibrary) {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor();
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.mainPixelFormat;
        renderPipelineDescriptor.vertexFunction = shaderLibrary.vertex(.Basic)
        renderPipelineDescriptor.fragmentFunction = shaderLibrary.fragment(.Basic)
        renderPipelineDescriptor.vertexDescriptor = vertexLibrary.getVertexDescriptor(.Basic);
        self.renderDescriptor = renderPipelineDescriptor;
    }
}
