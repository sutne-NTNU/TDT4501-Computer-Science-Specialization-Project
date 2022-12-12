using StatsPlots

include("plots/util.jl")


function plot_time()
    data = CSV.read("code/results/data/time.csv", DataFrame)
    println(data)

    groupedbar(
        [data.mixed_approximate data.mixed_exact data.indivisible],
        bar_width=0.8,
        yaxis=:log,
        # bar_position=:dodge,
        label=["Mixed Approximate" "Mixed Exact" "Indivisible"],
        legend=:topleft,
        xticks=([1, 2, 3, 4], ["Small Cake" "Medium Cake" "Large Cake" "Variable Cake"]),
        ylabel="Time (ms)",
    )
    savefig("code/results/plots/time.png")
end
plot_time()