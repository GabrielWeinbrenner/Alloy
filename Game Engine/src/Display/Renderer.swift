//
//  Renderer.swift
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//

import MetalKit

class Renderer: NSObject {
    var gameObject: GameObject = GameObject()
    
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // When the window is resized
    }
    
    func draw(in view: MTKView) {
        // Pass in the view that we're delegating from 
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return; }
        
        let commandBuffer = Engine.commandQueue.makeCommandBuffer();
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        gameObject.render(renderCommandEncoder!)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    
}
