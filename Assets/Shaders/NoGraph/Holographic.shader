Shader "USB/Holographic"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Sections ("Sections", Range(1,20)) = 5
        _Saturation("Saturation",Range(0.1,5)) = 1
    }
    SubShader
    {
        CGINCLUDE
        #include "UnityCg.cginc"
        ENDCG
        Tags{
            "RenderType"="Transparent"
            "RenderPipeline"="UniversalRenderPipeline"
            "Queue" = "Transparent"
        }
        Blend SrcAlpha OneMinusSrcAlpha
        Pass{
            
            CGPROGRAM
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Sections;
            float4 _Color;
            float _Saturation;
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
                float4 tanCol = clamp(0,abs(tan((i.uv.y+_Time.y)*_Sections)),1);
                tanCol *=_Color;

                float4 color = tex2D(_MainTex,i.uv)*tanCol;
                
                return color*_Saturation;
            }
            ENDCG

        }
    }
}
