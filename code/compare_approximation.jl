using code
using Revise
using ProgressBars
using LaTeXStrings
using Plots
using Printf


"""
Runs both algorithms on the same instances and saves their lowest MMS value for each instance in two lists that are returned.
"""
function run_instances_to_compare_approximation(; num_agents::Int, num_goods::Int, num_instances::Int)
    approximate, exact = [], []
    for size in 1:4
        for _ in ProgressBar(1:(num_instances/4), width=UInt(100))
            # create random instance
            instance = Instance(num_agents=num_agents, num_goods=num_goods, cake_size=size)
            # allocate with both algorithms
            alloc_exact = alloc_half_mms_mixed(instance, approximate=false)
            alloc_approximate = alloc_half_mms_mixed(instance, approximate=true)
            # add lowest mms value to respective list
            push!(approximate, minimum(calc_mms_values(alloc_approximate)))
            push!(exact, minimum(calc_mms_values(alloc_exact)))
        end
    end
    return (approximate, exact)
end



function main()
    println("Approximate vs Exact Mixed Algorithm")
    (approximate, exact) = run_instances_to_compare_approximation(
        num_agents=4,
        num_goods=8,
        num_instances=1000,
    )
    plot_mms_scatter_comparison("Approxmation vs Exact, All Cake Variations",
        approximate, "Approximate",
        exact, "Exact",
    )
    savefig("report/assets/plots/scatter_approximate_vs_exact.png")
    plot_mms_histogram_comparison("Approxmation vs Exact, All Cake Variations",
        approximate, "Approximate",
        exact, "Exact",
    )
    savefig("report/assets/plots/histogram_approximate_vs_exact.png")

end
main()