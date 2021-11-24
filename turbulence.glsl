vec2 hash( vec2 p ) 
{
	p = vec2( dot(p,vec2(127.1,311.7)),
			  dot(p,vec2(269.5,183.3)) );

	return -1.0 + 2.0*fract(sin(p)*43758.5453123+(iTime*0.01));
}

float noise( in vec2 p )
{
    const float K1 = 0.366025404; // (sqrt(3)-1)/2;
    const float K2 = 0.211324865; // (3-sqrt(3))/6;

	vec2 i = floor( p + (p.x+p.y)*K1 );
	
    vec2 a = p - i + (i.x+i.y)*K2;
    vec2 o = step(a.yx,a.xy);    
    vec2 b = a - o + K2;
	vec2 c = a - 1.0 + 2.0*K2;

    vec3 h = max( 0.5-vec3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );

	vec3 n = h*h*h*h*vec3( dot(a,hash(i+0.0)), dot(b,hash(i+o)), dot(c,hash(i+1.0)));

    return dot( n, vec3(70.0) );
}

float turbulence(in vec2 p, in float amplitude, in float fbase, in float attenuation, in int noctave) {
    int i;
    float res = .0;
    float f = fbase;
    for (i=0;i<noctave;i++) {
        res = res+amplitude*noise(f*p);
        amplitude = amplitude*attenuation;
        f = f*2.;
    }
    return res;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{  
    float time = iTime*10.;
    // Output to screen
    vec3 colors = vec3(
        turbulence(fragCoord+(time*10.)+vec2(-500.), 1., 0.002, 0.5, 1),
        turbulence(fragCoord+vec2(time*-8., time*2.)+vec2(-100., 600.), 1., 0.0023, 0.9, 1),
        turbulence(fragCoord+vec2(time*10., time*-20.), 1., 0.0025, 0.5, 1)
    );
    fragColor = vec4(colors,1.0);
    //fragColor = vec4(vec3(noise(fragCoord*0.1)), 1.0);
}