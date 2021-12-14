# r - робот
# не создаю в файле, чтобы расставить прегородки

function next(side, kol)
    return HorizonSide((Int(side) + kol) % 4)
end

function set(side1, side2, dir)
    while (!isborder(r, side1) || !isborder(r, side2))
        while !isborder(r, side1)
            move!(r, side1)
            push!(dir, side1)
        end
        while !isborder(r, side2)
            move!(r, side2)
            push!(dir, side2)
        end
    end
end

function go_around(side, kol)
    kol = 0
    flag = true
    while (isborder(r, side) && !isborder(r, next(side, 1)))
        move!(r, next(side, 1))
        kol += 1
    end
    if !isborder(r, side)
        move!(r, side)
    else
        flag = false
    end
    if flag
        while isborder(r, next(side, 3))
            move!(r, side)
        end
        for i in 1:kol
            move!(r, next(side, 3))
        end
    end
end

function draw_line(side)
    kol = 0
    while true
        if !isborder(r, side)
            putmarker!(r)
            move!(r, side)
        else
            putmarker!(r)
            # обхожу препятствие, если оно есть
            go_around(side, kol)
        end
        if (isborder(r, side) && isborder(r, next(side, 1)))
            break
        end
    end
    
end

function solve()
    dir = []
    # ставим робота в левый нижний угол
    set(Sud, West, dir)

    flag = true
    side = Ost
    while flag
        draw_line(side)
        move!(r, Nord)
        side = next(side, 2)
        if isborder(r, Nord)
            flag = false
        end
    end
end

solve()