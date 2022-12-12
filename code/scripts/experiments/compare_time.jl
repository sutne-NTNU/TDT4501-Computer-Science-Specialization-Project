using code



function compare_time(
    num_agents::Int=4,
    num_goods::Int=8,
    num_instances::Int=100,
)
    dataframe = DataFrame(
        cake_size=[],
        mixed_approximate=[],
        mixed_exact=[],
        indivisible=[],
    )

    for (size, name) in CakeSizes()
        # create the random instances
        instances = []
        for _ in 1:num_instances
            instance = Instance(
                num_agents=num_agents,
                num_goods=num_goods,
                cake_size=size,
            )
            push!(instances, instance)
        end


        # dry run to compile algorithms before timing them
        alloc_half_mms_mixed(instances[1], approximate=false)
        alloc_half_mms_mixed(instances[1], approximate=true)
        alloc_half_mms(instances[1], instances[1].num_agents)


        # take time of mixed algorithm using approximate MMS (PROP)
        println("Mixed Approximate, $name Cake")
        time_mixed_approximate = @elapsed for instance in ProgressBar(instances, width=UInt(75))
            alloc_half_mms_mixed(instance, approximate=true)
        end
        # take time of mixed algorithm using exact mms calculation
        println("Mixed Exact, $name Cake")
        time_mixed_exact = @elapsed for instance in ProgressBar(instances, width=UInt(75))
            alloc_half_mms_mixed(instance, approximate=false)
        end
        # take time for indivisible algorithm
        println("Indivisible, $name Cake")
        time_indivisible = @elapsed for instance in ProgressBar(instances, width=UInt(75))
            alloc_half_mms(instance, instance.num_agents)
        end

        average_time_ms(seconds) = round(1000 * seconds / num_instances, sigdigits=3)
        push!(dataframe, [
            cake_sizes[size],
            average_time_ms(time_mixed_approximate),
            average_time_ms(time_mixed_exact),
            average_time_ms(time_indivisible),
        ])
    end

    CSV.write("code/results/data/time.csv", dataframe)
end

compare_time()