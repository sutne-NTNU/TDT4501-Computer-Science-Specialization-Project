using code
using CSV
using DataFrames
using ProgressBars
using LaTeXStrings

function other_experiments()
    # create empty dataframe to store MMS values
    dataframe = DataFrame(indivisible=[], mixed=[])

    num_experiments = 100
    num_instances_per_experiment = 100

    for _ in 1:num_experiments
        # randomly get number of agents, goods and cake size
        num_agents = rand(2:7)
        num_goods = rand(num_agents:(2*num_agents))
        cake_size = rand(1:4)
        cake_name = ["Small", "Medium", "Large", "Individual"][cake_size]

        println("Comparing with: $(cake_name) cake, $(num_agents) agents, $(num_goods) goods")
        for _ in ProgressBar(1:num_instances_per_experiment, width=UInt(75))
            # create random instance
            instance = Instance(num_agents=num_agents, num_goods=num_goods, cake_size=cake_size)

            # allocate with both algorithms
            alloc_indivisible = alloc_half_mms(instance, num_agents)
            alloc_mixed = alloc_half_mms_mixed(instance)

            # find lowest mms values 
            indivisible_mms = minimum(calc_mms_values(alloc_indivisible))
            mixed_mms = minimum(calc_mms_values(alloc_mixed))

            if indivisible_mms < 0.49999 || mixed_mms < 0.49999
                println("MMS was below 0.5! indivisible: $(indivsible_mms), mixed: $(mixed_mms)")
                visualize(instance)
            end

            # add lowest mms values to dataframe
            push!(dataframe, [indivisible_mms, mixed_mms])
        end
    end
    CSV.write("code/results/data/other_experiments.csv", dataframe)
end
other_experiments()