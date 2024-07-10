//
//  Renderer.swift
//  Alloy
//
//  Created by Gabriel Weinbrenner on 7/8/24.
//

import MetalKit

class Renderer: NSObject { 
    
    init(_ mtkView: MTKView) {
        super.init()
        Preferences.ScreenSize = SIMD2<Float>(Float(mtkView.bounds.width), Float(mtkView.bounds.height))
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        Preferences.ScreenSize = SIMD2<Float>(Float(view.bounds.width), Float(view.bounds.height))
    }
    
    func draw(in view: MTKView) {
        // Pass in the view that we're delegating from 
        guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else { return; }
        
        let commandBuffer = Engine.shared.commandQueue?.makeCommandBuffer();
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        do {
            try Engine.shared.sceneManager.tickScene(renderCommandEncoder: renderCommandEncoder!, deltaTime: 1 / Float(view.preferredFramesPerSecond))
        } catch {
            let nserror = error as NSError
            print(nserror)
        }

        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    
}
