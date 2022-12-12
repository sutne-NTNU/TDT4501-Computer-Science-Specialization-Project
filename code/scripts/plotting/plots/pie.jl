include("util.jl")

function plot_mms_pie_percentages(x, xlabel, y, ylabel)
    x_wins = count(x .> y)
    y_wins = count(y .> x)
    equal = count(x .== y)
    n = length(x)

    if n != (x_wins + y_wins + equal)
        error("n != (x_wins + y_wins + equal)")
    end

    x_win_percentage = @sprintf("%02.1f", 100 * x_wins / n)
    y_win_percentage = @sprintf("%02.1f", 100 * y_wins / n)
    equal_percentage = @sprintf("%02.1f", 100 * equal / n)

    return pie(
        ["$x_win_percentage% $xlabel"; "$y_win_percentage% $ylabel:"; "$equal_percentage% Equal"],
        [x_wins, y_wins, equal],
        legend=:topleft,
    )
end