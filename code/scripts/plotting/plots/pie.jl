using code
using Printf

include("util.jl")

function plot_mms_pie_percentages(x, xlabel, y, ylabel)
    x_wins = count(x .> y)
    y_wins = count(y .> x)
    equal = count(x .== y)
    n = length(x)

    if n != (x_wins + y_wins + equal)
        error("n != (x_wins + y_wins + equal)")
    end

    to_percent(x) = lpad(@sprintf("%.1f", 100 * x / n), 4, "0")

    return pie(
        [
            "$(to_percent(x_wins))% - $xlabel"
            "$(to_percent(y_wins))% - $ylabel"
            "$(to_percent(equal))% - Equal"
        ],
        [x_wins, y_wins, equal],
        legend=:topleft,
    )
end