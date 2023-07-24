Shader "USB/kaleidoscope"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Rotation ("Rotation",Range(0,360)) = 0
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
            float _Rotation;

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
            void Unity_Rotate_Degrees_float(float2 UV, float2 Center, float Rotation, out float2 Out)
            {
                Rotation = Rotation * (3.1415926f/180.0f);
                UV -= Center;
                float s = sin(Rotation);
                float c = cos(Rotation);
                float2x2 rMatrix = float2x2(c, -s, s, c);
                rMatrix *= 0.5;
                rMatrix += 0.5;
                rMatrix = rMatrix * 2 - 1;
                UV.xy = mul(UV.xy, rMatrix);
                UV += Center;
                Out = UV;
            }
            float4 frag(v2f i):SV_TARGET{
                float u = abs(i.uv.x-0.5);
                float v = abs(i.uv.y-0.5);
                float2 uv = 0;
                float center = 0.5;
                float rotation = sin(_Time.y*_Rotation);
                Unity_Rotate_Degrees_float(float2(u,v),center,lerp(0,360,rotation),uv);

                float4 color = tex2D(_MainTex,uv);

                return color;
            }
            ENDCG

        }
    }
}
