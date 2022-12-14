using code
using Plots
using LaTeXStrings

include("plots/util.jl")
include("plots/bar.jl")

function plot_instances_and_allocations()
    # create and plot random small, medium and large instances
    for (size, name) in CakeSizes()
        instance = Instance(num_agents=3, num_goods=4, cake_size=size)
        plot_instance("$(name) Cake Instance", instance)
        savefig("code/results/plots/instance_$(lowercase(name)).png")
    end

    # create custom individual instance to visualize difference of different algorithms
    instance = Instance([
        1.1 1.2 0.9 6.4
        3.3 1.1 1.2 2.4
        2.3 1.3 1.1 4.3
    ])
    plot_instance("Individual Cake Instance", instance)
    savefig("code/results/plots/instance_individual.png")

    # plot each agents mms allocation
    plot_mms_allocation_for_agents("Each agent's MMS Allocation, Individual Cake", instance)
    savefig("code/results/plots/allocation_all_mms.png")

    # plot the allocation for each algorithm
    alloc = alloc_half_mms(instance)
    plot_allocation_for_agents("Indivisible Algorithm Individual Cake", alloc)
    savefig("code/results/plots/allocation_indivisible.png")

    alloc = alloc_half_mms(instance, instance.num_agents)
    plot_allocation_for_agents("Inidvisible Algorithm with $(L"n") pieces, Individual Cake", alloc)
    savefig("code/results/plots/allocation_n_pieces.png")

    alloc = alloc_half_mms_mixed(instance)
    plot_allocation_for_agents("Mixed Algorithm, Individual Cake", alloc)
    savefig("code/results/plots/allocation_mixed.png")
end
plot_instances_and_allocations()