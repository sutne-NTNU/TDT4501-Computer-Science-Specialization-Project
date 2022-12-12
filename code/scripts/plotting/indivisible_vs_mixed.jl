using CSV
using DataFrames
using Plots
using Plots.PlotMeasures
using StatsPlots
using LaTeXStrings


include("plots/util.jl")
include("plots/combination.jl")
include("plots/histogram.jl")

function indivisible_vs_mixed()

    data = CSV.read("code/results/data/mms_indivisible_1_pieces_vs_mixed_large.csv", DataFrame)
    compare_mms_diagram("Indivisible vs Mixed, Large Cake",
        data.indivisible, "Indivisible",
        data.mixed, "Mixed",
    )
    savefig("code/results/plots/indivisible_vs_mixed.png")

    sizes = ["small", "medium", "large", "variable"]
    for size in 1:4
        data = CSV.read("code/results/data/mms_indivisible_4_pieces_vs_mixed_$(sizes[size]).csv", DataFrame)
        compare_mms_diagram("Indivisible $(L"n") pieces vs Mixed, $(sizes[size]) Cake",
            data.indivisible, "Indivisible",
            data.mixed, "Mixed",
        )
        savefig("code/results/plots/indivisible_vs_mixed_$(sizes[size]).png")
    end
end
indivisible_vs_mixed()