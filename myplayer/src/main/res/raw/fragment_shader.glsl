// 设置默认浮点数精度为中等精度（mediump）
// 在移动设备上平衡渲染质量和性能
precision mediump float;

// 从顶点着色器传递过来的纹理坐标（经过插值后的二维坐标）
// 范围是 [0.0, 1.0]，对应纹理的完整范围
varying vec2 v_texPosition;

uniform sampler2D sampler_y;  // Y（亮度）分量
uniform sampler2D sampler_u;  // U（色度）分量
uniform sampler2D sampler_v;  // V（色度）分量
void main() {
   // 定义变量存储 YUV 值
    mediump vec3 yuv;
    // 定义变量存储转换后的 RGB 值（使用低精度以节省资源）
    lowp vec3 rgb;

     // 从三个纹理中采样 YUV 分量，并进行归一化处理
      // Y 分量范围通常是 [16/255, 235/255]，所以减去 0.0625（≈16/255）
    yuv.x = texture2D(sampler_y, v_texPosition).r - 0.0625;
    yuv.y = texture2D(sampler_u, v_texPosition).r - 0.5;
    yuv.z = texture2D(sampler_v, v_texPosition).r - 0.5;

   // 使用 3x3 矩阵将 YUV 转换为 RGB
   // 这是标准的 BT.601 色彩空间转换矩阵
    rgb = mat3( 1,1,1,
    0,-0.39465,2.03211,
    1.13983,-0.58060,0) * yuv;


    //float y,u,v;
    //y = texture2D(sampler_y,v_texPosition).r - 0.0625;
    //u = texture2D(sampler_u,v_texPosition).r- 0.5;
    //v = texture2D(sampler_v,v_texPosition).r- 0.5;


    //vec3 rgb;
    //rgb.r = y + 1.403 * v;
    //rgb.g = y - 0.344 * u - 0.714 * v;
    //rgb.b = y + 1.770 * u;

 // 输出最终颜色（RGBA格式，alpha值固定为1表示不透明）
    gl_FragColor = vec4(rgb,1);
}
