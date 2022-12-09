using code
using Revise
using ProgressBars
using LaTeXStrings
using Plots
using Printf




"""
Create `num_instances` random instances and then time how long each algorithm uses on average for all of them.

return time in milliseconds for indivisible and mixed algorithm.
"""
function run_instances_for_time(num_instances)
    println("Comparing Running Time")
    average_time_ms(seconds) = round(1000 * seconds / num_instances, sigdigits=3)

    sizes = ["Small", "Medium", "Large", "Variable"]
    for size in 1:4
        instances = []
        for _ in 1:num_instances
            # create random Instances and add to list
            instance = Instance(
                num_agents=4,
                num_goods=8,
                cake_size=size,
            )
            push!(instances, instance)
        end

        # dry run to compile algorithms before timing them
        for i in 1:10
            alloc_half_mms(instances[i], instances[i].num_agents)
            alloc_half_mms_mixed(instances[i], approximate=true)
            alloc_half_mms_mixed(instances[i], approximate=false)
        end

        # take time for indivisible algorithm
        time_indivisible = @elapsed for instance in ProgressBar(instances, width=UInt(100))
            alloc_half_mms(instance, instance.num_agents)
        end
        # take time of mixed algorithm
        time_mixed_exact = @elapsed for instance in ProgressBar(instances, width=UInt(100))
            alloc_half_mms_mixed(instance, approximate=false)
        end
        # take time of mixed algorithm
        time_mixed_approximate = @elapsed for instance in ProgressBar(instances, width=UInt(100))
            alloc_half_mms_mixed(instance, approximate=true)
        end

        println("Average Time, $(sizes[size]) Cake:")
        println("\tIndivisible n Pieces: $(average_time_ms(time_indivisible)) ms/alloc")
        println("\tMixed Exact:          $(average_time_ms(time_mixed_exact)) ms/alloc")
        println("\tMixed Approximation:  $(average_time_ms(time_mixed_approximate)) ms/alloc")
    end
end

run_instances_for_time(100)
