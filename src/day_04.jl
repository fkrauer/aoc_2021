using CSV, DataFrames

draws = CSV.read("data/day_04.txt", NamedTuple; 
        header=0, transpose=true, select=[1])[1]

boards = Matrix(CSV.read("data/day_04.txt", DataFrame; 
        header=0, skipto=3, delim=" ", ignorerepeated=true, ignoreemptyrows=true))

results = deepcopy(boards)

for d in moo[1]
    foo = boards .- d
    rowsum = sum(foo, dims=2)
    
    # row with zero rowsum
    zerorows = findall(x -> x==0, rowsum)
    if !(zerorows==[])
        row_out = boards[zerorows[1,],:]
    end

end