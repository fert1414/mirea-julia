# r - робот
using HorizonSideRobots
a = 15
r = Robot(a, a, animate = true);

function rev(side, k)
    return HorizonSide((Int(side) + k) % 4)
end

function doLine(side)
    k = 0
    while (!isborder(r, side) && !isborder(r, rev(side, 1)))
        move!(r, side)
        move!(r, rev(side, 1))
        putmarker!(r)
        k += 1
    end
    for i in 1:k
        move!(r, rev(side, 2))
        move!(r, rev(side, 3))
    end
end

# перемещение в случайную точку поля
x = trunc(rand() * a);
y = trunc(rand() * a);

for i in 1:x
    move!(r, Nord)
end
for i in 1:y
    move!(r, Ost)
end

for i in [Nord, Ost, Sud, West]
    doLine(i)
end
putmarker!(r)