# r - робот
# не создаю его в файле, чтобы расставить перегородки и установить маркер

function next(side, kol)
    return HorizonSide((Int(side) + kol) % 4)
end

function move_to_side(side, kol)
    for i in 1:kol
        move!(r, side)
    end
end

function go_around(side)
    n = 1
    kol1 = 0
    kol2 = 0
    dir_side = Nord
    while isborder(r, side)
        if (n % 2 == 0)
            move_to_side(next(side, 1), n)
            dir_side = next(side, 1)
            kol1 += 1
        else
            move_to_side(next(side, 3), n)
            dir_side = next(side, 3)
            kol2 += 1
        end
        n += 1
    end
    move!(r, side)
    if dir_side == next(side, 1)
        for i in 1:kol1
            move!(r, next(dir_side, 2))
        end
    else
        for i in 1:kol2
            move!(r, next(dir_side, 2))
        end
    end
end

function move_line(side, kol)
    for i in 1:kol
        if ismarker(r)
            break
        end
        if !isborder(r, side)
            move!(r, side)
        else
            go_around(side)
        end
    end
end

function solve()
    a = 1
    side = Nord
    while !ismarker(r)
        move_line(side, a)
        side = next(side, 3)
        a += 1
    end
end

solve()