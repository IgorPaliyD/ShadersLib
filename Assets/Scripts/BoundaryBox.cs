using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class BoundaryBox : MonoBehaviour
{
    //public GameObject boundingBox;
    public Vector3 bboxScale;
    public Vector3 bboxOffset;
    void Start()
    {
        Vector3 bboxLenght = bboxScale;
        Vector3 centerBBox = bboxOffset;
        // Min and max BBox points in world coordinates.
        Vector3 BMin = centerBBox - bboxLenght/2;
        Vector3 BMax = centerBBox + bboxLenght/2;
        // Pass the values to the material.
        gameObject.GetComponent<Renderer>().sharedMaterial.SetVector("_BBoxMin", BMin);
        gameObject.GetComponent<Renderer>().sharedMaterial.SetVector("_BBoxMax", BMax);
        gameObject.GetComponent<Renderer>().sharedMaterial.SetVector("_EnviCubeMapPos", centerBBox);
    }
}
