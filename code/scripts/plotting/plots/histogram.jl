using code

include("util.jl")

function plot_mms_histogram_comparison(x, xlabel::String, y, ylabel::String)
    bin_start = 0
    bin_width = 0.025
    bin_end = 1.5
    bins = bin_start:bin_width:bin_end

    fig = plot(xlabel="Achieved MMS", ylabel="Number of Instances", legend=:topleft)
    fig = histogram!(x, label=xlabel, bins=bins, alpha=0.5)
    fig = histogram!(y, label=ylabel, bins=bins, alpha=0.5)
    return fig
end