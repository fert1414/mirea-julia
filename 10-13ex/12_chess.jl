# r - робот
using HorizonSideRobots
a = 13
r = Robot(a, a, animate = true)

function random()
    x = trunc(rand() * a)
    y = trunc(rand() * a)
    for i in 1:x
        move!(r, Nord)
    end
    for i in 1:y
        move!(r, Ost)
    end
end

function rev(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function print_line(side, kol)
    while !isborder(r, side)
        for i in 1:kol
            putmarker!(r)
            if !isborder(r, side)
                move!(r, side)
            end
        end
        for i in 1:kol
            if !isborder(r, side)
                move!(r, side)
            end
        end
    end
end

function print_line(side, n, count)
    while !isborder(r, side)
        if trunc(count / n) % 2 == 0
            putmarker!(r)
        end
        move!(r, side)
        count += 1
    end
    if trunc(count / n) % 2 == 0
        putmarker!(r)
    end 
    count += 1 
    while !isborder(r, rev(side))     
        move!(r, rev(side))
    end
end

# основна функция, маркирующая поле
function solve()
    # перемещаем робота в случайную точку поля
    random()

    # перемещаем робота в левый нижний угол и запоминаем движение
    directions = []
    while !isborder(r, Sud)
        move!(r, Sud)
        push!(directions, Sud)
    end
    while !isborder(r, West)
        move!(r, West)
        push!(directions, West)
    end

    n = 4 # сторона одного квадрата
    count = 0
    k = 0
    flag = false
    while !flag
        for i in 1:n
            print_line(Ost, n, count)
            if isborder(r, Nord)
                flag = true
                break
            end
            move!(r, Nord)
        end
        if flag
            break
        end
        count += n
    end

    while !isborder(r, Sud)
        move!(r, Sud)
    end
    while !isborder(r, West)
        move!(r, West)
    end
    for i in directions
        move!(r, rev(i))
    end
end

solve()