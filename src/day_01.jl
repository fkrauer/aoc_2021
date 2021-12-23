# Part 1
data = open(f->read(f, String), "data/day_01.txt") |> f->split(f, "\n") |> a->map(s->parse(Int, s), a)
sum(diff(data).>0)

# Part 2
windows(data, window) = [view(data, i:(i + window - 1)) for i in 1:(length(data) - window + 1)]
(windows(data, 3)
|> x -> map(sum, x)
|> x -> sum(diff(x) .> 0))

