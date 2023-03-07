Shader "USB/SinCos"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Speed ("Zoom",Range(0,3)) = 1
    }
    SubShader
    {
        CGINCLUDE
        #include "UnityCg.cginc"
        ENDCG
        Pass{
            Tags{
                "RenderType"="Opaque"
                "RenderPipeline"="UniversalRenderPipeline"
            }
            CGPROGRAM
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Speed;

            #pragma vertex vert
            #pragma fragment frag

            struct appdata{
                float4 position: POSITION;
                float2 uv: TEXCOORD0;
            };

            struct v2f{
                float4 position: SV_POSITION;
                float2 uv: TEXCOORD0;
            };
            float3 rotation(float3 vertex){
                float c = cos(_Time.y*_Speed);
                float s = sin(_Time.y*_Speed);
                float3x3 m=float3x3(
                c,0,s,
                0,1,0,
                -s,0,c
                );
                return mul(m,vertex);
            }

            v2f vert(appdata v){
                v2f o;
                float3 rotationVert = rotation(v.position);
                o.position= UnityObjectToClipPos(rotationVert);
                o.uv = TRANSFORM_TEX(v.uv,_MainTex);
                return o;
            }
            
            float4 frag(v2f i):SV_TARGET{
                
                float4 color = tex2D(_MainTex,i.uv);

                return color;
            }
            ENDCG

        }
    }
}
