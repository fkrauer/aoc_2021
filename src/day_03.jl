using CSV
using DataFrames

# Part 1
data = open(f->read(f, String), "data/day_03.txt") |> f->split(f, "\r\n") 
data = DataFrame(split.(data, ""), :auto)
data[!,:] = tryparse.(Int64, data[:,:])
data = DataFrame(permutedims(Matrix(data)), :auto)

colsums = sum.(eachcol(data))
gamma = join(ifelse.(colsums .> size(data,1)/2, 1, 0))
epsilon = join(ifelse.(colsums .< size(data,1)/2, 1, 0))

parse(Int, gamma; base=2) * parse(Int, epsilon; base=2)

# Part 2
function bitfilter!(data, target_bit)
    data_ = data
    # Oxygen generator rating
    if target_bit == "majority" 
        for i in 1:size(data_,1)
            colsum = sum(data_[:,i])
            if colsum > size(data_,1)/2 
                data_ = subset(data_, i => ByRow(==(1)))
            elseif colsum < size(data_,1)/2 
                data_ = subset(data_, i => ByRow(==(0)))
            else
                data_ = subset(data_, i => ByRow(==(1)))
            end
            if size(data_,1)==1
                return join(data_[1,:])
            end
        end
    end

    # CO2 scrubber rating
    if target_bit == "minority" 
        for i in 1:size(data_,1)
            colsum = sum(data_[:,i])
            if colsum < size(data_,1)/2 
                data_ = subset(data_, i => ByRow(==(1)))
            elseif colsum > size(data_,1)/2 
                data_ = subset(data_, i => ByRow(==(0)))
            else
                data_ = subset(data_, i => ByRow(==(0)))
            end
            if size(data_,1)==1
                return join(data_[1,:])
            end
        end
    end
end

oxygen = bitfilter!(data, "majority")
co2 = bitfilter!(data, "minority")

parse(Int, oxygen; base=2) * parse(Int, co2; base=2)


