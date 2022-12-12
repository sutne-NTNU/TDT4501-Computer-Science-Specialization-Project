module code

using Revise

using Allocations
import JuMP
using JuMP: Model, optimizer_with_attributes, objective_value, @variable,
    @objective, @constraint, fix, optimize!, termination_status, MOI, set_binary

using Printf
using CSV
using DataFrames
using ProgressBars
using Plots
using Plots.PlotMeasures
using StatsPlots
using LaTeXStrings

include("structs/instance.jl")
include("structs/mixed_allocation.jl")
include("utils/formatting.jl")
include("utils/visualize.jl")
include("mms/mms.jl")
include("mms/mms_mixed.jl")
include("algorithms/half_mms_mixed.jl")
include("algorithms/half_mms.jl")
include("algorithms/random_mixed.jl")
include("algorithms/round_robin_mixed.jl")

export
    Instance,
    CloneInstance,
    Agents,
    Cakes,
    Items,
    Goods,
    CakeSizes,
    MixedAllocation,
    alloc_half_mms_mixed,
    alloc_half_mms,
    alloc_random_mixed,
    alloc_round_robin_mixed,
    mms,
    mms_mixed,
    calc_mms_values,
    visualize

end