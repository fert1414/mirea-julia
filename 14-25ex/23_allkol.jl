# r - робот
# изначально он находится в левом нижнем углу. Я не создаю его в файле, чтобы расставить перегородки

function change(side, kol)
    return HorizonSide((Int(side) + kol) % 4)
end

struct get 
    ok1::Bool
    ok2::Bool
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
        str::get
        str.ok1 = false
        str.ok2 = false
        return str
        # return false
    else
        move!(r, side)
        f = false
        while isborder(r, change(side, 3))
            move!(r, side)
            f = true
        end
        for i in 1:kol
            if !isborder(r, change(side, 3))
                move!(r, change(side, 3))
            end
        end
        str::get
        str.ok1 = f
        str.ok2 = true
        return str
        # return true
    end
end

function move_and_kol(side, kol) 
    flag = false
    ok = true
    count = 0
    get_bool::get
    while true 
        if (isborder(r, change(side, kol)) && !flag)
            flag = true
            count += 1
        elseif !isborder(r, change(side, kol))
            flag = false
        end
        if (isborder(r, side))
            get_bool = go_around(side)
        end
        if get_bool.ok2
            if !isborder(r, side)
                move!(r, side)
            end
        else
            break
        end
    end
    return count
end

function kol(side, move_side, ok) 
    flag = true
    count = 0
    n = 1
    if ok
        n = 1
    else
        n = 3
    end
    while !isborder(r, side)
        count += move_and_kol(move_side, n)
        move_side = change(move_side, 2)
        n = (n + 2) % 4
        move!(r, side)
    end
    return count
end


# практически готово, осталось отсечь повторные гпрямоугольники
function solve() 
    count = 0
    count += kol(Nord, Ost, true)
    while !isborder(r, Sud)
        move!(r, Sud)
    end
    count += kol(Ost, Nord, false)
    println(count)
end

solve()