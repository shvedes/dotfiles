precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {

    vec4 pixColor = texture2D(tex, v_texcoord);

    pixColor[0] *= 1.1;
    pixColor[1] *= 1.1;
    pixColor[2] *= 1.1;

    gl_FragColor = pixColor;
}

// vim:ft=glsl
