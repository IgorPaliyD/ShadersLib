Shader "Unlit/Wireframe"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            
            CGPROGRAM
            #if !defined(FLAT_WIREFRAME_INCLUDED)
            #define FLAT_WIREFRAME_INCLUDED

            #include "My Lighting.cginc"

            void MyGeometryProgram () {}

            #endif
            #pragma target 4.0
            #pragma vertex MyVertexProgram
            #pragma fragment MyFragmentProgram
            #pragma geometry MyGeometryProgram
            // make fog work
            #include "MyFlatWireframe.cginc"
               #define CUSTOM_GEOMETRY_INTERPOLATORS \
	        float2 barycentricCoordinates : TEXCOORD9;
            struct InterpolatorsGeometry{
              InterpolatorsVertex data;  
              //float2 barycentricCoordinates : TEXCOORD9;
              #if defined (CUSTOM_GEOMETRY_INTERPOLATORS)
		        CUSTOM_GEOMETRY_INTERPOLATORS
	            #endif
            };
            [maxvertexcount(3)]
            void GeomertyProgram(trangle InterpolatorsVertex i[3],inout TriangleStream<InterpolatorsGeometry> stream){
                float3 p0 = i[0].worldPos.xyz;
                float3 p1 = i[1].worldPos.xyz;
                float p2 = i[2].worldPos.xyz;

                float3 triangleNormal = normalize(cross(p1 - p0, p2 - p0));
                i[0].normal = triangleNormal;
	            i[1].normal = triangleNormal;
	            i[2].normal = triangleNormal;

                InterpolatorsGeometry g0, g1, g2;
	            g0.data = i[0];
	            g1.data = i[1];
	            g2.data = i[2];

                g0.barycentricCoordinates = float3(1,0);
	            g1.barycentricCoordinates = float3(0, 1);
	            g2.barycentricCoordinates = float3(0, 0);

                stream.Append(i[0]);
                stream.Append(i[1]);
                stream.Append(i[2]);
            }
         
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
