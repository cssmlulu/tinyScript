import Data.Array

{-
图的表示结构和构造函数参考了Data.Graph
https://hackage.haskell.org/package/containers-0.5.6.3/docs/Data-Graph.html
-}

--点
type Vertex  = Int 
--边
type Edge    = (Vertex, Vertex)
--点的范围
type Bounds  = (Vertex, Vertex)
--图. 用Array表示，记录从每个顶点出发直接相连的顶点
--example: array (1,5) [(1,[2,4]),(2,[5,3]),(3,[4]),(4,[5]),(5,[])]
type Graph   = Array Vertex [Vertex]

--图的构造函数，用一组边集来构造
--example: g = buildGraph (1,5) [(1,2),(2,3),(3,4),(4,5),(2,5),(1,4)]
buildGraph :: Bounds -> [Edge] -> Graph
buildGraph bounds edges = accumArray (flip (:)) [] bounds edges


--输出一个顶点可以到达另一个顶点的路径
--visited数组记录已访问过的顶点
findpath :: Graph -> Vertex -> Vertex -> [[Vertex]]
findpath g x y = findpath' g x y [x]
  where
    findpath' g a b visited
        | a == b    = [[b]]
        | otherwise = [a:path | c <- g!a, c `notElem` visited, path <- findpath' g c b (c:visited)]
