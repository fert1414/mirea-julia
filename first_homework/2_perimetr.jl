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

dir = []
# функция, которая ставит робота в левый верхний угол
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

function go_straight(side)
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end
end

go_to_angle()
for i in [Sud, Ost, Nord, West]
    go_straight(i)
end

for i in dir
    move!(r, rev(i))
end