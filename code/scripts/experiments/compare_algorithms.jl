using code


function run_instances_for_mms(;
    num_agents::Int=4,
    num_goods::Int=8,
    cake_size::Int,
    num_pieces::Int,
    num_instances::Int=10000
)
    (size, name) = CakeSizes()
    println("Comparing with $(name[cake_size]) cake and $(num_pieces) pieces")

    # create empty dataframe to store MMS values
    dataframe = DataFrame(indivisible=[], mixed=[])

    for _ in ProgressBar(1:num_instances, width=UInt(75))
        # create random instance
        instance = Instance(num_agents=num_agents, num_goods=num_goods, cake_size=cake_size)

        # allocate with both algorithms
        alloc_indivisible = alloc_half_mms(instance, num_pieces)
        alloc_mixed = alloc_half_mms_mixed(instance)

        # find lowest mms values 
        indivsible_mms = minimum(calc_mms_values(alloc_indivisible))
        mixed_mms = minimum(calc_mms_values(alloc_mixed))

        # add lowest mms values to dataframe
        push!(dataframe, [indivsible_mms, mixed_mms])
    end

    CSV.write("code/results/data/mms_indivisible_$(num_pieces)_pieces_vs_mixed_$(lowercase(name[cake_size])).csv", dataframe)
end


function compare_algorithms()
    run_instances_for_mms(
        cake_size=3, # large for biggest difference
        num_pieces=1,
    )

    for (size, name) in CakeSizes()
        run_instances_for_mms(
            cake_size=size,
            num_pieces=4,
        )
    end
end
compare_algorithms()