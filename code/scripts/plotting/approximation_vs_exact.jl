include("plots/util.jl")
include("plots/combination.jl")



function compare_approximation()
    data = CSV.read("code/results/data/mms_approximate_vs_exact.csv", DataFrame)
    compare_mms_diagram("Approximated MMS vs Exact MMS, All Cake Variations",
        data.approximate, "Using Approximated MMS",
        data.exact, "Using Exact MMS",
    )
    savefig("code/results/plots/approximate_vs_exact.png")
end
compare_approximation()