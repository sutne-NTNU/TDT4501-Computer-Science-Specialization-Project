""" 
    plot_allocation(allocation) -> StatsPlots.Plot

Visualize the the value each agent gives their own bundle.
"""
function plot_allocation(title::String, allocation::MixedAllocation)
    return groupedbar(
        allocation.assigned,
        title=title,
        bar_position=:stack,
        bar_width=0.8,
        legend=false,
        label="Good",
    )
end

""" 
    plot_allocation(allocation) -> StatsPlots.Plot

Visualize the the value each agent gives their own bundle.
"""
function plot_bundles(title::String, allocation::MixedAllocation)
    bundle_sizes = allocation.instance.valuations .* allocation.assigned
    return groupedbar(
        bundle_sizes,
        title=title,
        bar_position=:stack,
        bar_width=0.8,
        legend=false,
        label="Good",
    )
end




""" 
Plot how each agent sees the given allocation by highlighting the agent, and using that agents valuation profile 
to find that agents value of the other agent's bundle's. Useful to see how "fair" that agent's own bundle is compared to the others.
"""
function plot_allocation_for_agents(title::String, allocation::MixedAllocation)
    plots = []
    labels = [
        if g in Items(allocation.instance)
            "Item $g"
        else
            "Cake"
        end for g in 1:allocation.instance.num_goods
    ]
    for agent in Agents(allocation.instance)
        alphas = [
            if a == agent
                1.0
            else
                0.5
            end for a in 1:allocation.instance.num_agents
        ]
        valuation = allocation.instance.valuations[agent, :]
        bundle_sizes = valuation' .* allocation.assigned
        agent_plot = groupedbar(
            title="Agent $agent",
            bundle_sizes,
            bar_position=:stack,
            bar_width=0.8,
            alpha=alphas,
            legend=agent == 1,
            label=["Item 1" "Item 2" "Item 3" "Cake"],
        )
        push!(plots, agent_plot)
    end
    return plot(plots..., layout=allocation.instance.num_agents, plot_title=title)
end


function plot_mms_allocation_for_agents(title::String, instance::Instance)
    # Plotting each agents MMS allocation
    plots = []
    for agent in 1:instance.num_agents
        result = mms_mixed(instance, agent)
        fig = plot_bundles("Agent $agent", result.allocation)
        push!(plots, fig)
    end
    return plot(plots..., layout=instance.num_agents, plot_title=title)
end