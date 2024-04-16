Shader "Unlit/RimLight"
{
    Properties
    {
        _RimColor("RimColor",COLOR) =(1,1,1,1)
        _RimPower("RimPower",Range(0.0001,5.0)) = 0.1
        _Specular("Color",COLOR) = (1,1,1,1)
        _Diffuse("Diffuse",COLOR) = (1,1,1,1)
        _Gloss("Gloss",Range(8.0,256)) = 20

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"
            fixed4 _Diffuse;
            fixed4 _RimColor;
            float _RimPower;
            fixed4 _Specular;
            float _Gloss;


            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldNormal:TEXCOORD0;
                float3 worldPos :TEXCOORD1;
            };

            v2f vert (a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = mul(v.normal,(float3x3)unity_WorldToObject);
                o.worldPos = mul(unity_ObjectToWorld,v.vertex).xyz;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                //fixed3 reflectDir = normalize(reflect(-worldLightDir,worldNormal));
                fixed3 diffuse = _LightColor0.rgb*_Diffuse.rgb*saturate(dot(worldNormal,worldLightDir));
                fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz-i.worldPos.xyz);
                float rim = 1- saturate(dot(worldNormal,viewDir));
                fixed3 rimColor = _RimColor*pow(rim,1/_RimPower);
                fixed3 halfDir = normalize(worldLightDir+viewDir);
                fixed3 specular = _LightColor0.rgb*_Specular.rgb*pow(saturate(dot(worldNormal,halfDir)),_Gloss);

                return fixed4(rimColor+ambient+diffuse+specular,1.0);
            }
            ENDCG
        }
    }
}
