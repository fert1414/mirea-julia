# r - робот
# изначально он находится в левом нижнем углу. Я не создаю его в файле, чтобы расставить перегородки

function change(side, kol)
    return HorizonSide((Int(side) + kol) % 4)
end

function go_around(side)
    kol = 0
    while isborder(r, side)
        if !isborder(r, change(side, 1))
            move!(r, change(side, 1))
            kol += 1
        else
            break
        end
    end
    if isborder(r, side)
        for i in 1:kol
            if !isborder(r, change(side, 3))
                move!(r, change(side, 3))
            end
        end
        return false
    else
        move!(r, side)
        while isborder(r, change(side, 3))
            move!(r, side)
        end
        for i in 1:kol
            if !isborder(r, change(side, 3))
                move!(r, change(side, 3))
            end
        end
        return true
    end
end

function move_and_kol(side, kol) 
    flag = false
    ok = true
    count = 0
    while true 
        if (isborder(r, change(side, kol)) && !flag)
            flag = true
            count += 1
        elseif !isborder(r, change(side, kol))
            flag = false
        end
        if (isborder(r, side))
            ok = go_around(side)
        end
        if ok
            if !isborder(r, side)
                move!(r, side)
            end
        else
            break
        end
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