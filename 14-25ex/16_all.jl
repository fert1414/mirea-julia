# r - робот
# не создаю в файле, чтобы расставить прегородки

dir = []

function next(side, kol)
    return HorizonSide((Int(side) + kol) % 4)
end

function set(side1, side2)
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

function goAround(side)
    num = 0
    kol = 0
    while (isborder(r, side) && !isborder(r, next(side, 1)))
        move!(r, next(side, 1))
        push!(dir, next(side, 1))
        kol += 1
    end
    if !isborder(r, side)
        move!(r, side)
        push!(dir, side)
        num += 1
        while isborder(r, next(side, 3))
            move!(r, side)
            push!(dir, side)
            num += 1
        end
    end
    for i = 1:kol
        move!(r, next(side, 3))
        push!(dir, next(side, 3))
    end
    return num
end

function drawLine(side)
    num = 0
    while true
        if !isborder(r, side)
            putmarker!(r)
            move!(r, side)
            push!(dir, side)
            num += 1
        else
            putmarker!(r)
            num += goAround(side)
        end
        if (num == 11 || (isborder(r, side) && isborder(r, next(side, 1))))
            break
        end
    end
    putmarker!(r)
end

function f()
    set(Sud, West)

    side = Ost
    while true
        drawLine(side)
        if isborder(r, Nord)
            break
        end
        move!(r, Nord)
        push!(dir, Nord)
        side = next(side, 2)
    end
    while length(dir) > 0
        move!(r, next(pop!(dir), 2))
    end
end

f()