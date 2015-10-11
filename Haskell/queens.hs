queens :: Int -> [[Int]]
queens n = queens' n
    where queens' 0       = [[]]
        --递归，在k-1行有解的情况下增加新的一行
          queens' k       = [q:qs | qs <- queens' (k-1), q <- [1..n], isValid q qs]
        --检查新一行的放置是否合法（不在同一列&不在对角线）
          isValid   q qs = not (q `elem` qs || sameDiag q qs)
        --检查是否在对角线
          sameDiag q qs = any (\(dif,qs') -> abs (q - qs') == dif) $ zip [1..] qs