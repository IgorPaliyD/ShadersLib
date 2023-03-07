using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
using UnityEditor;

public class DissolveAnimator : MonoBehaviour
{
    [SerializeField] private float _dissolveDuration;
    [SerializeField] private Renderer _dissolveRenderer;
    private bool isExecutable = false;
    private Material _materialInstance;
    private void Awake()
    {
        if (!_dissolveRenderer)
        {
            if (TryGetComponent<Renderer>(out var rend))
            {
                isExecutable = true;
                _dissolveRenderer = rend;
            }
            else
            {
                isExecutable = false;
                return;
            }
        }
        _materialInstance = GetMaterial(_dissolveRenderer);
        if (!_materialInstance)
        {
            isExecutable = false;
            return;
        }
    }
    private Material GetMaterial(Renderer rend)
    {
        if (rend.materials.Length > 1)
        {
            for (int i = 0; i < rend.materials.Length; i++)
            {
                if (rend.materials[i].shader.name.Contains("Dissolve"))
                {
                    return rend.materials[i];
                }
            }
        }
        else
        {
            return rend.material;
        }
        return null;
    }
    public void DissolveIn()
    {
        if (isExecutable)
        {
            _materialInstance.DOFloat(0, "_Dissolve", _dissolveDuration);
        }
    }
    public void DissolveOut()
    {
        if (isExecutable)
        {
            _materialInstance.DOFloat(1, "_Dissolve", _dissolveDuration);
        }
    }

    
}
