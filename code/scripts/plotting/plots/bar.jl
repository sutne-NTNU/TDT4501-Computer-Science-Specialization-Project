include("util.jl")

function plot_instance(title::String, instance::Instance)
    return groupedbar(
        instance.valuations,
        title=title,
        bar_width=0.8,
        legend=:topleft,
        size=(600, 300),
        xticks=(Agents(instance), get_agent_labels(instance)),
        label=get_good_labels(instance),
    )
end


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
        label=get_good_labels(allocation.instance),
        yaxis=:none,
        xticks=(Agents(allocation.instance), get_agent_labels(allocation.instance)),
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
        label=get_good_labels(allocation.instance),
        xticks=(Agents(allocation.instance), get_agent_labels(allocation.instance)),
    )
end




""" 
Plot how each agent sees the given allocation by highlighting the agent, and using that agents valuation profile 
to find that agents value of the other agent's bundle's. Useful to see how "fair" that agent's own bundle is compared to the others.
"""
function plot_allocation_for_agents(title::String, allocation::MixedAllocation)
    plots = []
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
            yaxis=:none,
            bar_position=:stack,
            bar_width=0.8,
            alpha=alphas,
            legend=agent == 1,
            label=get_good_labels(allocation.instance),
            xticks=(Agents(allocation.instance), get_agent_labels(allocation.instance)),
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
    return plot(plots..., size=(700, 300), layout=(1, instance.num_agents), plot_title="$title", topmargin=1mm)
end