//
//  MyShaders.metal
//  Game Engine
//
//  Created by Gabriel Weinbrenner on 7/7/24.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position;
    float4 color;
};

struct RasterizerData {
    float4 position [[ position ]];
    float4 color;
};
float noise(float x) {
    return fract(sin(x) * 43758.5453);
}

vertex RasterizerData basic_vertex_shader(device VertexIn *vertices [[ buffer(0) ]],
                                          uint vertexID [[vertex_id]]) {
    RasterizerData rd;
    rd.position = float4(vertices[vertexID].position, 1.0);
    rd.color = vertices[vertexID].color;
    
    return rd;
}

fragment float4 basic_fragment_shader(RasterizerData rd [[stage_in]]) {
//    float noiseValue = noise(rd.position.y * 10.0);
//    float strength = sin(noiseValue * 20.0);
//
//    float4 modifiedColor = rd.color * (0.5 + 0.5 * strength);

    return rd.color;
}
