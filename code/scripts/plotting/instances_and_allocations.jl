using CSV
using DataFrames
using Plots
using Plots.PlotMeasures
using StatsPlots
using LaTeXStrings

include("plots/util.jl")

function visualize_mms_and_allocations_with_plots()
    sizes = ["Small", "Medium", "Large", "Variable"]
    for size in 1:4
        instance = Instance(num_agents=3, num_goods=4, cake_size=size)

        plot_instance("$(sizes[size]) Cake Instance", instance)
        savefig("$(plot_dir)visualize_instance_$(sizes[size])_cake.png")
        plot_mms_allocation_for_agents("Each agent's MMS Allocation, $(sizes[size]) Cake", instance)
        savefig("$(plot_dir)visualize_mms_allocation_$(sizes[size])_cake.png")

        alloc = alloc_half_mms(instance)
        plot_allocation("Indivisible Algorithm $(sizes[size]) Cake", alloc)
        savefig("$(plot_dir)visualize_indivisible_allocation_$(sizes[size])_cake.png")

        alloc = alloc_half_mms(instance, instance.num_agents)
        plot_allocation("Inidvisible Algorithm $(L"n") pieces, $(sizes[size]) Cake", alloc)
        savefig("$(plot_dir)visualize_indivisible_n_pieces_allocation_$(sizes[size])_cake.png")

        alloc = alloc_half_mms_mixed(instance)
        plot_allocation("Mixed Algorithm, $(sizes[size]) Cake", alloc)
        savefig("$(plot_dir)visualize_mixed_allocation_$(sizes[size])_cake.png")
    end
end