void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Time varying pixel color
    vec3 col = 0.5 + 0.5*cos(fragCoord.xxx/vec3(2));
    col = smoothstep(vec3(0), vec3(0.5), col);

    // Output to screen
    fragColor = vec4(col,1.0);
}