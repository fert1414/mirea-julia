# r - робот
# не создаю робота в программе, чтобы создать линию и убрать внешние перегородки

function move_to_side(side, kol)
    for i in 1:kol
        move!(r, side)
    end
end

n = 1
while isborder(r, Nord)
    if (n % 2 == 0)
        move_to_side(West, n)
    else
        move_to_side(Ost, n)
    end
    global n += 1
end