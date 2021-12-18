# r - робот
# не создаю его в файле, чтобы расставить перегородки

function next(side, kol)
    return HorizonSide((Int(side) + kol) % 4)
end

function go_around(side, dir::AbstractArray)
    kol = 0
    flag = true
    while (isborder(r, side) && !isborder(r, next(side, 1)))
        move!(r, next(side, 1))
        kol += 1
        push!(dir, next(side, 1))
    end
    if !isborder(r, side)
        move!(r, side)
        push!(dir, side)
    else
        flag = false
    end
    if flag
        while isborder(r, next(side, 3))
            move!(r, side)
            push!(dir, side)
        end
        for i in 1:kol
            move!(r, next(side, 3))
            push!(dir, (next(side, 3)))
        end
    end
end

function go_to_border_and_draw(side)
    dir = []
    while true
        if !isborder(r, side)
            putmarker!(r)
            move!(r, side)
            push!(dir, side)
        else
            putmarker!(r)
            # обхожу препятствие, если оно есть
            go_around(side, dir)
        end
        if (isborder(r, side) && isborder(r, next(side, 1)))
            break
        end
    end
    # возвращаю в исходное положение
    while length(dir) > 0
        move!(r, next(pop!(dir), 2))
    end
end

function solve()
    for i in [Nord, West, Sud, Ost]
        go_to_border_and_draw(i)
    end
end

solve()