# r - робот
# не создаю робота в файле, чтобы установить перегородку

# размеры поля
m = 11
n = 12

function next(side)
    return HorizonSide((Int(side) + 3) % 4)
end 

function rev(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function do_border(side)
    while isborder(r, next(side))
        putmarker!(r)
        move!(r, side)
    end
    putmarker!(r)
    move!(r, next(side))
end

function count(side)
    kol = 0
    while !isborder(r, side)
        move!(r, side)
        kol += 1
    end 
    return kol
end

# устанoвка робота в левый нижний угол и запоминание траектории движения
directions = []
while (!isborder(r, Sud) || !isborder(r, West))
    while (!isborder(r, Sud))
        move!(r, Sud)
        push!(directions, Sud)
    end
    while (!isborder(r, West))
        move!(r, West)
        push!(directions, West)
    end
end

# поиск внутренней перегородки
a = 0
kol_now = 0
dir = Ost
while !isborder(r, Nord)
    if a % 2 == 0
        global kol_now = count(Ost)
        global dir = Ost
    else
        global kol_now = count(West)
        global dir = West
    end
    global a += 1
    if (kol_now + 1) != n
        break
    end
    move!(r, Nord)
end

# отрисовка перегородки
if (dir == West)
    for i in [Sud, West, Nord, Ost]
        do_border(i)
    end
else
    for i in [Nord, Ost, Sud, West]
        do_border(i)
    end
end

# установкак робота в исходное положение
while (!isborder(r, Sud) || !isborder(r, West))
    while (!isborder(r, Sud))
        move!(r, Sud)
    end
    while (!isborder(r, West))
        move!(r, West)
    end
end

while length(directions) > 0
    move!(r, rev(pop!(directions)))
end 