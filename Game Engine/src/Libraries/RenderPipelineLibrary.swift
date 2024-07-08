//
//  VertexLibrary.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//

import MetalKit
enum RenderPipelineStateTypes {
    case Basic
}
class RenderPipelineLibrary {
    
    var renderPipelineStates: [RenderPipelineStateTypes: RenderPipelineState] = [
        .Basic: Basic_RenderPipeline()
    ]
    var renderPipelineState: MTLRenderPipelineState;

    init() {
        renderPipelineState = renderPipelineStates[.Basic]!.renderPipelineState
    }
    
    public func getRenderPipelineDescriptor(_ type: RenderPipelineStateTypes) -> MTLRenderPipelineState {
        renderPipelineState = renderPipelineStates[type]!.renderPipelineState
        return renderPipelineState
    }
    
}

protocol RenderPipelineState {
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState { get }
}

public struct Basic_RenderPipeline: RenderPipelineState {
    var name: String = "Basic Vertex Descriptor"
    
    var renderPipelineState: MTLRenderPipelineState {
        var renderPipelineState: MTLRenderPipelineState!
        do {
            renderPipelineState = try Engine.device.makeRenderPipelineState(descriptor: Engine.renderLibrary.getRenderDescriptor(.Basic))
            return renderPipelineState
        } catch let error as NSError {
            print(error)
        }
        return renderPipelineState
    }
}
