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

# функция, которая ставит робота в левый верхний угол
dir = []
function go_to_angle()
    while !isborder(r, Nord)
        move!(r, Nord)
        push!(dir, Nord)
    end
    while !isborder(r, West)
        move!(r, West)
        push!(dir, West)
    end
end

function go_to_border(side)
    while !isborder(r, side)
        putmarker!(r)
        move!(r, side)
    end
    putmarker!(r)
end

go_to_angle()
for i in 1:a
    if (i % 2 != 0)
        go_to_border(Ost)
    else
        go_to_border(West)
    end
    if !isborder(r, Sud)
        move!(r, Sud)
    end
end

while !isborder(r, Nord)
    move!(r, Nord)
end
while !isborder(r, West)
    move!(r, West)
end

for i in dir
    move!(r, rev(i))
end