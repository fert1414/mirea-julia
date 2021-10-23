# r - робот
# не создаю его в файле, чтобы установить маркеры на поле

function rev(side)
    return HorizonSide((Int(side) + 2) % 4)
end

function solve()
    temp = 0
    kol = 0
    side = Ost
    flag = false
    while !flag
        while !isborder(r, side)
            if ismarker(r)
                temp += temperature(r)
                kol += 1
            end
            move!(r, side)
        end
        side = rev(side)
        flag = isborder(r, Nord)
        if !flag
            move!(r, Nord)
        end
    end
    if kol != 0
        println(temp / kol)
    else
        println(0)
    end
end 

solve()