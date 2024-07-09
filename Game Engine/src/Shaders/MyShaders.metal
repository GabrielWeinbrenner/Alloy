#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct RasterizerData {
    float4 position [[ position ]];
    float4 color ;
};

struct ModelConstants {
    float4x4 modelMatrix;
};

// Hash function to generate pseudo-random values
float hash(float3 p) {
    p = fract(p * 0.8);
    p += dot(p, p.yzx + 19.19);
    return fract((p.x + p.y) * p.z);
}

vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant ModelConstants &modelConstants [[ buffer(1) ]]) {
    RasterizerData rd;
    rd.position = float4(vIn.position, 1.0);
    rd.position = modelConstants.modelMatrix * float4(vIn.position, 1.0);
    rd.color = vIn.color;
    
    return rd;
}
float2 wave(float2 uv, float x, float y){
    return float2(
        uv.x + sin(uv.y * x) * 0.1,
        uv.y + sin(uv.x * y) * 0.1);
}

fragment float4 basic_fragment_shader(RasterizerData rd [[stage_in]]) {
    float3 pos = rd.position.xyz;
    float xPos = pos.x/1000;
    float yPos = pos.y/1000;
//    CHECKERBOARD
//    float strength = step(0.8, fmod(xPos * 10.0, 1.0));
//    strength = step(0.8, strength);
//    strength += step(0.8, fmod(yPos * 10.0, 1.0));
//    strength = clamp(strength, 0.0, 1.0);
//    SIN WAVE
//    float2 wavedUv = wave(float2(xPos, yPos), 30.0, 30.0);
//    float strength = 1.0 - step(0.01, abs(distance(wavedUv, float2(0.5,0.5)) - 0.25));
    float strength = xPos;
//    return float4(strength, strength, strength, 1.0);
    return rd.color;
}
