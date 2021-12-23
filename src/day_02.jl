using CSV
using DataFrames

data = CSV.read("data/day_02.txt", header=0, DataFrame) 

# Part 1
forward = (data 
            |> x -> filter(:Column1 => ==("forward"), x) 
            |> x -> sum(x.Column2))

up = (data 
        |> x -> filter(:Column1 => ==("up"), x) 
        |> x -> -sum(x.Column2))

down = (data 
        |> x -> filter(:Column1 => ==("down"), x) 
        |> x -> sum(x.Column2))

forward * (up + down)

# Part 2
insertcols!(data, 3, :aim => fill(0,size(data,1)))

aim = 0
horizontal = 0
depth = 0

for i in 1:size(data,1)
    direction = data.Column1[i]
    if direction=="up" 
        aim = aim - data.Column2[i]
    end
    if direction=="down" 
        aim = aim + data.Column2[i]
    end
    if direction=="forward" 
        horizontal = horizontal + data.Column2[i]
        depth = depth + aim * data.Column2[i]
    end
end

horizontal * depth

