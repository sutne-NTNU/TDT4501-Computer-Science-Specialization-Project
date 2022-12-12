using code




function compare_approximation(;
    num_agents::Int=4,
    num_goods::Int=8,
    num_instances::Int=10000
)
    dataframe = DataFrame(approximate=[], exact=[])

    for (size, name) in CakeSizes()
        for _ in ProgressBar(1:(num_instances/4), width=UInt(75))
            # create random instance
            instance = Instance(num_agents=num_agents, num_goods=num_goods, cake_size=size)

            # allocate with both algorithms
            alloc_exact = alloc_half_mms_mixed(instance, approximate=false)
            alloc_approximate = alloc_half_mms_mixed(instance, approximate=true)

            # find lowest mms values
            exact_mms_result = minimum(calc_mms_values(alloc_exact))
            approximate_mms_result = minimum(calc_mms_values(alloc_approximate))

            # add lowest mms values to dataframe
            push!(dataframe, [approximate_mms_result, exact_mms_result])
        end
    end

    CSV.write("code/results/data/mms_approximate_vs_exact.csv", dataframe)
end
compare_approximation()