# r - робот
using HorizonSideRobots
a = 15
r=Robot(a, a, animate=true)

# перемещения в случайную точку поля
x = trunc(rand() * a)
y = trunc(rand() * a)
for i in 1:x
    move!(r, Nord)
end
for i in 1:y
    move!(r, Ost)
end

function rev(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function go_to_border_and_back(side)
    counter = 0
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
        counter += 1
    end
    for i in 1:counter
        move!(r, rev(side))
    end
end

for i in [Nord, Sud, West, Ost]
    go_to_border_and_back(i)
end
putmarker!(r)