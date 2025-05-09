// 启用 OpenGL ES 的扩展功能：外部图像纹理（OES_EGL_image_external）
// 这个扩展允许我们使用 Android 特有的 SurfaceTexture 作为输入源（如摄像头/视频数据）
#extension GL_OES_EGL_image_external : require

// 设置默认浮点数精度为中等精度（mediump）
// 在移动设备上，这能平衡渲染质量和性能
// 可选值：highp（高精度）/mediump（中精度）/lowp（低精度）
precision mediump float;

// 从顶点着色器传递过来的纹理坐标（二维向量）
// 这个值会在片元着色器中进行插值计算
// 范围通常是 [0.0, 0.0]（左下角）到 [1.0, 1.0]（右上角）
varying vec2 v_texPosition;

// 声明一个外部纹理采样器（uniform 表示这个值由外部程序传入）
// samplerExternalOES 是 Android 特有的类型，用于访问 SurfaceTexture 数据
// 注意：不是标准的 sampler2D，必须配合 GL_OES_EGL_image_external 扩展使用
uniform samplerExternalOES sTexture;

// 片元着色器的主函数（每个像素都会执行一次）
void main() {
    // 使用 texture2D 函数从纹理中采样颜色
    // 参数1：纹理采样器（这里是外部纹理 sTexture）
    // 参数2：纹理坐标（v_texPosition）
    // 返回值：vec4 类型的颜色值（RGBA格式）
    gl_FragColor=texture2D(sTexture, v_texPosition);
        // 注意：这里只是简单输出原始纹理颜色
        // 如果要实现滤镜效果，可以在这里对颜色值进行处理，例如：
        // 反色效果：gl_FragColor = vec4(1.0 - gl_FragColor.rgb, gl_FragColor.a);
        // 灰度效果：float gray = dot(gl_FragColor.rgb, vec3(0.299, 0.587, 0.114));
        // gl_FragColor = vec4(gray, gray, gray, gl_FragColor.a);
}
