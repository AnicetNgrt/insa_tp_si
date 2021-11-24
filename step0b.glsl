void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float time = cos(iTime)*30.+50.;
    vec2 center = iResolution.xy/vec2(2);
    float it = 0.5 + 0.5*cos(distance(fragCoord, center)*(pow(time, 3.)/50.));
    it = smoothstep(0.25+0.25*cos(time), 0.75+0.25*sin(time), it);

    vec3 color = vec3(1.);
    vec3 invColor = vec3(1., 0., 0.);

    // Output to screen
    fragColor = vec4((color*it) + (invColor*(1.-it)), 1.0);
}