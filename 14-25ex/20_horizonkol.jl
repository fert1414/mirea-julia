# r - робот
# изначально он находится в левом нижнем углу. Я не создаю его в файле, чтобы расставить перегородки
# внешние перегородки робот не считает считает

function change(side, kol)
    return HorizonSide((Int(side) + kol) % 4)
end

function move_and_kol(side, kol)
    flag = false
    count = 0
    while !isborder(r, side) 
        if (isborder(r, change(side, kol)) && !flag)
            flag = true
            count += 1
        elseif !isborder(r, change(side, kol))
            flag = false
        end
        move!(r, side)
    end
    return count
end

function solve() 
    side = Ost
    n = 1
    count = 0
    while !isborder(r, Nord)
        count += move_and_kol(side, n)
        side = change(side, 2)
        n = (n + 2) % 4
        move!(r, Nord)
    end
    println(count)
end

solve()