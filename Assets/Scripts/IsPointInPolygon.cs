using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;

public static class IsPointInPolygon
{
   public static bool PointInPolygon(List<Vector3> PolygonList,int count,Vector2 p)
    {
        int crossNum = 0;

        for(int i = 1;i<count;i++)
        {
            Vector2 v1 = new Vector2(PolygonList[i-1].x, PolygonList[i-1].z);
            Vector2 v2 = new Vector2(PolygonList[i].x, PolygonList[i].z);

            if(((v1.y<=p.y)&&(v2.y>p.y))||((v1.y > p.y) && (v2.y <= p.y)))
            {
                if (p.x < v1.x + (p.y - v1.y) / (v2.y - v1.y) * (v2.x - v1.x))
                {
                    crossNum += 1;
                }
            }
        }
        Vector2 beg = new Vector2(PolygonList[0].x, PolygonList[0].z);
        Vector2 en = new Vector2(PolygonList[count-1].x, PolygonList[count-1].z);
        if (((beg.y <= p.y) && (en.y > p.y)) || ((beg.y > p.y) && (en.y <= p.y)))
        {
            if (p.x < beg.x + (p.y - beg.y) / (en.y - beg.y) * (en.x - beg.x))
            {
                crossNum += 1;
            }
        }

        if (crossNum % 2 == 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }
}
