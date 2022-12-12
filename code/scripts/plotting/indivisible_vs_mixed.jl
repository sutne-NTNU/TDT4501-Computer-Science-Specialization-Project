using code
using LaTeXStrings
using CSV
using DataFrames

include("plots/util.jl")
include("plots/combination.jl")

function indivisible_vs_mixed()

    data = CSV.read("code/results/data/mms_indivisible_1_pieces_vs_mixed_large.csv", DataFrame)
    compare_mms_diagram("Indivisible vs Mixed, Large Cake",
        data.indivisible, "Indivisible",
        data.mixed, "Mixed",
    )
    savefig("code/results/plots/indivisible_vs_mixed.png")

    for (size, name) in CakeSizes()
        data = CSV.read("code/results/data/mms_indivisible_4_pieces_vs_mixed_$name.csv", DataFrame)
        compare_mms_diagram("$name Cake",
            data.indivisible, "Indivisible with $(L"n") pieces",
            data.mixed, "Mixed",
        )
        savefig("code/results/plots/indivisible_vs_mixed_$(lowercase(name)).png")
    end
end
indivisible_vs_mixed()