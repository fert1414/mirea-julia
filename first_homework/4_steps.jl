# r - робот
using HorizonSideRobots
a = 9
r=Robot(a, a, animate=true)

function rev(side)
    return HorizonSide((Int(side) + 2) % 4)
end

# перемещения в случайную точку поля
x = trunc(rand() * a)
y = trunc(rand() * a)
for i in 1:x
    move!(r, Nord)
end
for i in 1:y
    move!(r, Ost)
end

# функция, которая ставит робота в правый нижний угол
dir = []
function go_to_angle()
    while !isborder(r, Sud)
        move!(r, Sud)
        push!(dir, Sud)
    end
    while !isborder(r, Ost)
        move!(r, Ost)
        push!(dir, Ost)
    end
end

function go_to_border(side, c, k = 0)
    if (k != 0)
        move!(r, side)
    end
    for i in 1:(c - 1)
        putmarker!(r)
        move!(r, side)
    end
    putmarker!(r)
end

go_to_angle()
for i in 1:a
    if (i % 2 != 0)
        if i == 1
            go_to_border(West, a - i + 1, 0)
        else
            go_to_border(West, a - i + 1, i)
        end
    else
        go_to_border(Ost, a - i + 1)
    end
    if !isborder(r, Nord)
        move!(r, Nord)
    end
end

while !isborder(r, Sud)
    move!(r, Sud)
end
while !isborder(r, Ost)
    move!(r, Ost)
end

for i in dir
    move!(r, rev(i))
end