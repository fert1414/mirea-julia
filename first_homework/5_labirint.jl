# r - робот
# я не создаю его в этом файле, чтобы расставить границы

directions = []

function rev(side)
    return HorizonSide((Int(side) + 2) % 4)
end

# функция, которая выводит робота в левый верхний угол
function go_to_angle()
    while (!isborder(r, Nord) || !isborder(r, West))
        while !isborder(r, Nord)
            move!(r, Nord)
            push!(directions, Nord)
        end
        while !isborder(r, West)
            move!(r, West)
            push!(directions, West)
        end
    end
end

function put_marker_to_angle(side)
    while !isborder(r, side)
        move!(r, side)
    end
    putmarker!(r)
end

go_to_angle()
for i in [Sud, Ost, Nord, West]
    put_marker_to_angle(i)
end

while length(directions) > 0
    move!(r, rev(pop!(directions)))
end