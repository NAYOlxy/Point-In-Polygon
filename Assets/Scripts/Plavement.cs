using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Plavement : MonoBehaviour
{
    Ray ray;
    RaycastHit hitInfo;

    void Update()
    {
        // Screen Sapce -> Ray
        ray = Camera.main.ScreenPointToRay(Input.mousePosition);

        if (Physics.Raycast(ray, out hitInfo, Mathf.Infinity))
        {
            // 返回射线指向的点的坐标
            Vector3 vector = hitInfo.point;
            transform.position = vector;
            transform.rotation = Quaternion.FromToRotation(Vector3.up, hitInfo.normal);
        }
    }
}
