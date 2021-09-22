# r - робот
# я не создаю его в этом файле, чтобы расставить границы

x = [0, 0, 0, 0, 0, 0, 0, 0]
y = [0, 0, 0, 0, 0, 0, 0, 0]
kolx = 1
koly = 1

# функция, которая выводит робота в левый верхний угол
function go_to_angle()
    while (!isborder(r, Nord) || !isborder(r, West))
        while !isborder(r, Nord)
            move!(r, Nord)
            x[kolx] += 1
        end
        while !isborder(r, West)
            move!(r, West)
            y[koly] += 1
        end
        global kolx += 1
        global koly += 1
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

if (x[kolx - 1] == 0)
    global kolx -= 1
end
if (y[koly - 1] == 0)
    global koly -= 1
end

kol = -1

if (kolx > koly)
    kol = kolx
else
    kol = koly
end

for i in 1:(kol - 1)
    if (i == kol - 1 && kolx > koly)
        for j in 1:x[kolx - 1 - i + 1]
            move!(r, Sud)
        end
    elseif (i == kol - 1 && koly > kolx)
        for k in 1:y[koly - 1 - i + 1]
            move!(r, Ost)
        end
    else 
        for j in 1:x[kolx - 1 - i + 1]
            move!(r, Sud)
        end
        for k in 1:y[koly - 1 - i + 1]
            move!(r, Ost)
        end
    end
end