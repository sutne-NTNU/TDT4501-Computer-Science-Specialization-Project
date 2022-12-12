using code
using CSV
using DataFrames
using ProgressBars



function compare_approximation(;
    num_agents::Int=4,
    num_goods::Int=8,
    num_instances::Int=10000
)
    dataframe = DataFrame(approximate=[], exact=[])

    for size in 1:4
        for _ in ProgressBar(1:(num_instances/4), width=UInt(75))
            # create random instance
            instance = Instance(num_agents=num_agents, num_goods=num_goods, cake_size=size)

            # allocate with both algorithms
            alloc_exact = alloc_half_mms_mixed(instance, approximate=false)
            alloc_approximate = alloc_half_mms_mixed(instance, approximate=true)

            # find lowest mms values
            exact_mms = minimum(calc_mms_values(alloc_exact))
            approximate_mms = minimum(calc_mms_values(alloc_approximate))

            # add lowest mms value to respective list
            push!(dataframe, [approximate_mms, exact_mms])
        end
    end

    CSV.write("code/results/data/mms_approximate_vs_exact.csv", dataframe)
end
compare_approximation()