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
enum RenderPipelineError: Error {
    case descriptorNotFound
    case pipelineCreationFailed
}
class RenderPipelineLibrary {
    
    var renderPipelineStates: [RenderPipelineStateTypes: RenderPipelineState] = [:]
    var renderPipelineState: MTLRenderPipelineState?;
    
    public func ignite(device: MTLDevice, renderLibrary: RenderLibrary) throws {
        renderPipelineStates = [
            .Basic: try Basic_RenderPipeline(device, renderLibrary)
        ]
        renderPipelineState = renderPipelineStates[.Basic]!.renderPipelineState
    }
    
    public func getRenderPipelineDescriptor(_ type: RenderPipelineStateTypes) -> MTLRenderPipelineState? {
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
    
    var renderPipelineState: MTLRenderPipelineState
    
    init(_ device: MTLDevice, _ renderLibrary: RenderLibrary) throws {
        guard let renderDescriptor = renderLibrary.getRenderDescriptor(.Basic) else {
            throw(RenderPipelineError.descriptorNotFound)
        }
        do {
            self.renderPipelineState = try device.makeRenderPipelineState(descriptor: renderDescriptor)
        } catch let error as NSError {
            throw error
        }
    }
}
