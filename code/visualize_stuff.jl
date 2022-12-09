using code
using Revise
using ProgressBars
using LaTeXStrings
using Plots
using Printf


function visualize_mms_and_allocations_with_plots()
    instance = Instance([
        1.0 1.0 1.0 3.0
        1.0 1.0 1.0 4.0
        1.0 1.0 1.0 5.0
    ])
    plot_instance("Agent's valuations for all goods", instance)
    savefig("report/assets/plots/visualize_instance.png")
    plot_mms_allocation_for_agents("Each agent's MMS Allocation", instance)
    savefig("report/assets/plots/visualize_mms_allocation.png")

    alloc = alloc_half_mms(instance)
    plot_allocation("Allocation with indivisible algorithm", alloc)
    savefig("report/assets/plots/visualize_indivisible_allocation.png")

    alloc = alloc_half_mms(instance, instance.num_agents)
    plot_allocation("Allocation with indivisible algorithm, $(L"n") pieces", alloc)
    savefig("report/assets/plots/visualize_indivisible_n_pieces_allocation.png")

    alloc = alloc_half_mms_mixed(instance)
    plot_allocation("Allocation with mixed algorithm", alloc)
    savefig("report/assets/plots/visualize_mixed_allocation.png")
end
visualize_mms_and_allocations_with_plots()
