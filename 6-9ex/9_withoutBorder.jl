# r - робот
# не создаю робота в файле, чтобы установить маркер и убрать границы

function next(side)
    return HorizonSide((Int(side) + 3) % 4)
end

a = 1
side = Nord
while !ismarker(r)
    for i in 1:a
        if ismarker(r)
            break
        end
        move!(r, side)
    end
    global side = next(side)
    for i in 1:a
        if ismarker(r)
            break
        end
        move!(r, side)
    end
    if ismarker(r)
        break
    end
    global side = next(side)
    global a += 1
end