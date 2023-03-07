Shader "USB/ZoomEffect"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Zoom ("Zoom",Range(0,1)) = 0
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
            float _Zoom;

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
            
            v2f vert(appdata v){
                v2f o;
                o.position= UnityObjectToClipPos(v.position);
                o.uv = TRANSFORM_TEX(v.uv,_MainTex);
                return o;
            }
           
            float4 frag(v2f i):SV_TARGET{
                float u = ceil(i.uv.x)*0.5;
                float v = ceil(i.uv.y)*0.5;
                float uLerp = lerp(u,i.uv.x,_Zoom);
                float vLerp = lerp(v,i.uv.y,_Zoom);
                
                float4 color = tex2D(_MainTex,float2(uLerp,vLerp));

                return color;
            }
            ENDCG

        }
    }
}
