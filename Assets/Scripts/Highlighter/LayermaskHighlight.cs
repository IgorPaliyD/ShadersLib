using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Tools
{
    public class LayermaskHighlight : MonoBehaviour
    {
        [SerializeField] private List<HiglightState> m_states;
        [SerializeField] private bool m_allowHighlight = true;
        [SerializeField] private GameObject m_targetObject;
        private void Start()
        {
            if (CanProcess())
            {
                AddNewLayer("default", m_targetObject.layer);
            }

        }
        public void AddNewLayer(string layerName, LayerMask mask)
        {
            if (StateNameCheck(layerName)) return;
            var newState = new HiglightState();
            newState.StateName = layerName;
            newState.StateLayer = mask;
            m_states.Add(newState);
        }
        public void Highlight(string highlightLayer)
        {
            if (!CanProcess() || !StateNameCheck(highlightLayer)) return;
            for (int i = 0; i < m_states.Count; i++)
            {
                if (m_states[i].StateName == highlightLayer)
                {
                    m_targetObject.layer = m_states[i].StateLayer;
                    break;
                }
            }

        }
        public void UndoHiglight(string highlightLayer)
        {
            if (!CanProcess()) return;
            for (int i = 0; i < m_states.Count; i++)
            {
                if (m_states[i].StateName == highlightLayer)
                {
                    m_targetObject.layer = m_states[i].StateLayer;
                    break;
                }
            }
        }
        private bool StateNameCheck(string stateName)
        {
            bool result = false;
            for (int i = 0; i < m_states.Count; i++)
            {
                if (m_states[i].StateName == stateName)
                {
                    result = true;
                    break;
                }
            }
            return result;
        }
        private bool CanProcess()
        {
            if (m_targetObject == null) return false;
            if (m_allowHighlight == false) return false;
            if (m_states.Count == 0 || m_states == null) return false;
            return true;
        }
        [System.Serializable]
        private struct HiglightState
        {
            public string StateName;
            public LayerMask StateLayer;
        }
    }

}