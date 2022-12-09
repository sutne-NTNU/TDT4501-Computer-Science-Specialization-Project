using code
using Plots
using ProgressBars
using Revise

function test_plots()
    instance = Instance(
        num_agents=3,
        num_goods=4,
        cake_size=2,
    )
    visualize(instance)

    # plot the instance
    plot_instance("Instance", instance)
    savefig("code/test/plots/instance.png")

    # Plot the MMS allocation for each agent
    plot_mms_allocation_for_agents("MMS for Agents", instance)
    savefig("code/test/plots/mms_allocation_for_agents.png")

    # plot allocation using different algorithms
    allocation = alloc_half_mms(instance)
    visualize(allocation)
    plot_allocation("1/2MMS", allocation)
    savefig("code/test/plots/allocation_half_mms.png")
    plot_allocation_for_agents("Indivisible", allocation)
    savefig("code/test/plots/allocation_half_mms_agents.png")

    allocation = alloc_half_mms(instance, instance.num_agents)
    visualize(allocation)
    plot_allocation("1/2MMS n pieces", allocation)
    savefig("code/test/plots/allocation_half_mms_n_pieces.png")
    plot_allocation_for_agents("1/2MMS n pieces", allocation)
    savefig("code/test/plots/allocation_half_mms_n_pieces_agents.png")

    allocation = alloc_half_mms_mixed(instance)
    visualize(allocation)
    plot_allocation("1/2MMS Mixed", allocation)
    savefig("code/test/plots/allocation_half_mms_mixed.png")
    plot_allocation_for_agents("1/2MMS MIxed", allocation)
    savefig("code/test/plots/allocation_half_mms_mixed_agents.png")

    # Plot algorithm comparisons
    alg_1_mms, alg_2_mms = [], []
    for _ in ProgressBar(1:100, width=UInt(100))
        instance = Instance(num_agents=3, num_goods=6, cake_size=1)
        allocation = alloc_half_mms(instance, 1)
        push!(alg_1_mms, minimum(calc_mms_values(allocation)))
        allocation = alloc_half_mms_mixed(instance)
        push!(alg_2_mms, minimum(calc_mms_values(allocation)))
    end

    plot_mms_scatter_comparison(
        alg_2_mms, "Algorithm 1",
        alg_1_mms, "Algorithm 2",
    )
    savefig("code/test/plots/comparison_scatter.png")

    plot_mms_histogram_comparison(
        alg_2_mms, "Algorithm 1",
        alg_1_mms, "Algorithm 2",
    )
    savefig("code/test/plots/comparison_histogram.png")
end
test_plots()