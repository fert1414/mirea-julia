# r - робот
# не создаю в файле, чтобы расставить перегородки

function rev(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function go_straight(side)
    while !isborder(r, side)
        putmarker!(r)
        move!(r, side)
    end
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

function solve()
    # ставлю робота в левый верхнию угол и запоминаю движение
    dir = []
    set(Nord, West, dir)

    # рисуем периметр
    for i in [Sud, Ost, Nord, West]
        go_straight(i)
    end

    # возвращаем робота в исходное положение
    while length(dir) > 0
        move!(r, rev(pop!(dir)))
    end
end

solve()