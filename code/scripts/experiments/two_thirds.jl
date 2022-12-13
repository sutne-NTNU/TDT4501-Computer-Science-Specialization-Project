using code
using CSV
using DataFrames
using ProgressBars

function two_thirds_experiment()
    num_agents = 4
    num_goods = 8
    num_pieces = num_agents
    num_instances = 250 # per cake size

    dataframe = DataFrame(cake_size=[], mms=[])
    for (size, name) in CakeSizes()
        println("2/3 Algorithm with $(name) cake")
        for _ in ProgressBar(1:num_instances, width=UInt(75))
            instance = Instance(num_agents=num_agents, num_goods=num_goods, cake_size=size)
            alloc = alloc_two_thirds_mms(instance, num_pieces)
            mms = minimum(calc_mms_values(alloc))
            push!(dataframe, [size, mms])
        end
    end
    CSV.write("code/results/data/two_thirds.csv", dataframe)
end
two_thirds_experiment()