# r - робот
using HorizonSideRobots
r = Robot(13, 13, animate=true)

function line(side, flag)
    while !isborder(r, side)
        if flag == 1
            putmarker!(r)
            move!(r, side)
            if (!isborder(r, side))
                move!(r, side)
            end
        else
            move!(r, side)
            putmarker!(r)
            if (!isborder(r, side))
                move!(r, side)
            end
        end
    end
    if (flag == 1)
        putmarker!(r)
    end
end

# установка робота в случайную точку поля
a = trunc(rand() * 13)
b = trunc(rand() * 13)
for i in 1:a
    move!(r, Nord)
end
for i in 1:b
    move!(r, Ost)
end

# установка робота в левый нижний угол
x = 0
y = 0
ok = 0
while !isborder(r, Sud)
    move!(r, Sud)
    global y += 1
end
while !isborder(r, West)
    move!(r, West)
    global x += 1
end

if (x + y) % 2 == 0
    ok = 1
else
    ok = 0
end

# отрисовка шахматного поля
n = 1
line(Ost, ok)
ok += 1
ok = ok % 2
while !isborder(r, Nord)
    move!(r, Nord)
    if (n % 2 == 0)
        line(Ost, ok)
    else
        line(West, ok)
    end
    global ok += 1
    global ok = ok % 2
    global n += 1
end

# возвращение в исходную позицию
while !isborder(r, Sud)
    move!(r, Sud)
end
while !isborder(r, West)
    move!(r, West)
end
for i in 1:x
    move!(r, Ost)
end
for i in 1:y
    move!(r, Nord)
end