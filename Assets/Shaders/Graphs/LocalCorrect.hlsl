#ifndef LOCALCORRECT_INCLUDED
#define LOCALCORRECT_INCLUDED

void LocalCorrect_float3(float3 origVec, float3 bboxMin, float3 bboxMax, float3 vertexPos, float3 cubemapPos, out float3 result){
float3 invOrigVec = float3(1.0,1.0,1.0)/origVec;
float3 intersecAtMaxPlane = (bboxMax - vertexPos) * invOrigVec;
float3 intersecAtMinPlane = (bboxMin - vertexPos) * invOrigVec;
float3 largestIntersec = max(intersecAtMaxPlane, intersecAtMinPlane);
float Distance = min(min(largestIntersec.x, largestIntersec.y), largestIntersec.z);
float3 IntersectPositionWS = vertexPos + origVec * Distance;
result = IntersectPositionWS - cubemapPos;
}


#endif