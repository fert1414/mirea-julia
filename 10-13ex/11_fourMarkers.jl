# r - робот
# я не создаю его в файле, что бы сделать перегородки

x = 0
y = 0

function rev(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function set_angle(side1, side2, directions::AbstractArray)
    while (!isborder(r, side1) || !isborder(r, side2))
        while !isborder(r, side2)
            move!(r, side2)
            push!(directions, side2)
            global x += 1
        end
        while !isborder(r, side1)
            move!(r, side1)
            push!(directions, side1)
            global y += 1
        end
    end
end

function put_markers(side1, side2)
    for i in 1:x
        move!(r, side1)
    end
    putmarker!(r)
    for i in 1:x
        move!(r, rev(side1))
    end

    for i in 1:y
        move!(r, side2)
    end
    putmarker!(r)
    for i in 1:y
        move!(r, rev(side2))
    end
end

# основная функция
function solve(s1, s2, s3, s4)
    global x = 0
    global y = 0
    # ставим робота в угол и запоминаем движение
    directions = []
    set_angle(s1, s4, directions)

    # ставим маркеры
    put_markers(s2, s3)

    while length(directions) > 0
        move!(r, rev(pop!(directions)))
    end
end

solve(Nord, Ost, Sud, West)
solve(Ost, Nord, West, Sud)