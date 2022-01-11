using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
public class RendererMaterialSetter : MonoBehaviour
{
    public Material Material;
    public Renderer ObjectRenderer;
    public int ShaderPass;
    [SerializeField]private CommandBuffer cb;
    private void SetUpMaterial(){
        Mesh mesh = ObjectRenderer.GetComponent<MeshFilter>().sharedMesh;
        int subMeshCount = mesh.subMeshCount;
        cb = new CommandBuffer();
        
        for(int i =0;i<subMeshCount;i++){
            cb.DrawRenderer(ObjectRenderer, Material,i,ShaderPass);
        }
    }
    private void Start() {
        SetUpMaterial();
    }
}
