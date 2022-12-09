using code
using Revise
using ProgressBars
using LaTeXStrings
using Plots
using Printf


"""
Runs both algorithms on the same instances and saves their lowest MMS value for each instance in two lists that are returned.
"""
function run_instances_for_mms(; num_agents::Int, num_goods::Int, num_instances::Int, cake_size::Int, num_pieces::Int=1)
    indivisible, mixed = [], []
    for _ in ProgressBar(1:num_instances, width=UInt(100))
        # create random instance
        instance = Instance(num_agents=num_agents, num_goods=num_goods, cake_size=cake_size)
        # allocate with both algorithms
        alloc_indivisible = alloc_half_mms(instance, num_pieces)
        alloc_mixed = alloc_half_mms_mixed(instance)
        # add lowest mms value to respective list
        push!(indivisible, minimum(calc_mms_values(alloc_indivisible)))
        push!(mixed, minimum(calc_mms_values(alloc_mixed)))
    end
    return (indivisible, mixed)
end




function main()
    println("Indivisible vs Mixed")
    (indivisible, mixed) = run_instances_for_mms(
        num_agents=4,
        num_pieces=1,
        num_goods=8,
        num_instances=1000,
        cake_size=3,
    )
    plot_mms_scatter_comparison("Indivisible vs Mixed, Large Cake",
        indivisible, "Indivisible",
        mixed, "Mixed",
    )
    savefig("report/assets/plots/scatter_indivisible_mixed.png")
    plot_mms_histogram_comparison("Indivisible vs Mixed, Large Cake",
        indivisible, "Indivisible",
        mixed, "Mixed",
    )
    savefig("report/assets/plots/histogram_indivisible_mixed.png")


    size = ["Small", "Medium", "Large", "Variable"]
    for cake_size in 1:4
        println("Indivisible n Pieces vs Mixed, $(size[cake_size]) Cake")
        (indivisible, mixed) = run_instances_for_mms(
            num_agents=4,
            num_pieces=4,
            num_goods=8,
            num_instances=1000,
            cake_size=cake_size,
        )

        plot_mms_scatter_comparison("$(size[cake_size]) Cake",
            indivisible, "Indivisible, $(L"n") Pieces",
            mixed, "Mixed",
        )
        savefig("report/assets/plots/scatter_indivisible_n_pieces_vs_mixed_$(size[cake_size])_cake.png")

        plot_mms_histogram_comparison("$(size[cake_size]) Cake",
            indivisible, "Indivisible, $(L"n") Pieces",
            mixed, "Mixed",
        )
        savefig("report/assets/plots/histogram_indivisible_n_pieces_vs_mixed_$(size[cake_size])_cake.png")
    end
end
main()