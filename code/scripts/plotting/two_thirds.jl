using code
using CSV
using Plots
using DataFrames

include("plots/util.jl")


function two_thirds_histogram()
    data = CSV.read("code/results/data/two_thirds.csv", DataFrame)
    bins = 0:0.025:1.5
    histogram(
        data.mmss,
        title="2/3 MMS Values, All Cake Variations",
        label="2/3 MMS Algorithm",
        xlabel="MMS Value",
        ylabel="Number of Instances",
        legend=:topleft,
        bins=bins,
        size=(config.width, 200)
    )
    savefig("code/results/plots/approximate_vs_exact.png")
end
two_thirds_histogram()