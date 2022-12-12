using code
using LaTeXStrings
using CSV
using DataFrames

include("plots/util.jl")
include("plots/combination.jl")

function indivisible_vs_mixed()

    data = CSV.read("code/results/data/other_experiments.csv", DataFrame)
    compare_mms_diagram("Indivisible vs Mixed, Other Experiments",
        data.indivisible, "Indivisible",
        data.mixed, "Mixed",
    )
    savefig("code/results/plots/other_experiments.png")
end
indivisible_vs_mixed()