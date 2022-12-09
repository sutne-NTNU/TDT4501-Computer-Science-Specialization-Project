module code

using Allocations
import JuMP
using JuMP: Model, optimizer_with_attributes, objective_value, @variable,
    @objective, @constraint, fix, optimize!, termination_status, MOI, set_binary

using Printf
using Plots
using StatsPlots
using Revise


include("structs/instance.jl")
include("structs/mixed_allocation.jl")

include("mms/mms.jl")
include("mms/mms_mixed.jl")

include("algorithms/half_mms_mixed.jl")
include("algorithms/half_mms.jl")
include("algorithms/random_mixed.jl")
include("algorithms/round_robin_mixed.jl")

include("utils/formatting.jl")
include("utils/visualize.jl")

include("plotting/instance.jl")
include("plotting/allocation.jl")
include("plotting/comparison.jl")


export
    Instance,
    CloneInstance,
    Agents,
    Cakes,
    Items,
    Goods,
    CakeSize,
    MixedAllocation,
    alloc_half_mms_mixed,
    alloc_half_mms,
    alloc_random_mixed,
    alloc_round_robin_mixed,
    mms,
    mms_mixed,
    calc_mms_values,
    visualize,
    plot_bundles,
    plot_allocation,
    plot_allocation_for_agents,
    plot_mms_allocation_for_agents,
    plot_instance,
    plot_mms_scatter_comparison,
    plot_mms_histogram_comparison

end