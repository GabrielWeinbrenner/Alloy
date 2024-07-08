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
    
    var renderDescriptors: [RenderDescriptorTypes: RenderDescriptor] = [
        .Basic: Basic_RenderDescriptor()
    ]
    private var renderDescriptor: MTLRenderPipelineDescriptor;

    init() {
        renderDescriptor = renderDescriptors[.Basic]!.renderDescriptor
    }
    
    public func getRenderDescriptor(_ type: RenderDescriptorTypes) -> MTLRenderPipelineDescriptor {
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
    
    var renderDescriptor: MTLRenderPipelineDescriptor {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor();
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.mainPixelFormat;
        renderPipelineDescriptor.vertexFunction = Engine.shaderLibrary.vertex(.Basic)
        renderPipelineDescriptor.fragmentFunction = Engine.shaderLibrary.fragment(.Basic)
        renderPipelineDescriptor.vertexDescriptor = Engine.vertexLibrary.getVertexDescriptor(.Basic);
        return renderPipelineDescriptor;
    }
}
