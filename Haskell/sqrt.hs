--根号2运算

--迭代法
mysqrt::Double->Double
mysqrt x = iter y0
  where
    iter y
      | abs(x-y*y) <  epsilon = y
      | otherwise = iter (next y)
    next y = (y+x/y)/2.0
    epsilon = 0.00000001
    y0 = 1.0

--给定函数f和初始点x0 输出（近似）使f(x)=x的点x
fixPoint::(Double->Double)->Double
fixPoint f =
    iter x0 (f x0)
    where
        iter old new
          |abs(old-new) < epsilon = old
          |otherwise = iter new (f new)
        x0 = 1.0
        epsilon = 0.00000001

mysqrt2::Double->Double
mysqrt2 x =
    fixPoint (\y->(x/y+y)/2.0)

--牛顿迭代法
newtonIter::(Double->Double)->Double
newtonIter f =
    fixPoint (\y->(y - f y/df y))
    where
        df y = (f (y+dy) - f y) / dy
        dy = 0.00001

mysqrt3::Double->Double
mysqrt3 x =
    newtonIter (\y->(x-y*y)) 