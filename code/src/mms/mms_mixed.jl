function mms_mixed(instance::Instance, agent::Int)
    # Let all agents be clones of the agent 
    cloned_instance = CloneInstance(instance, agent=agent)
    # use this instance to find maximin 
    result = alloc_mm_mixed(cloned_instance)

    return result # maximin for this agents is that agents MMS
end



function alloc_mm_mixed(instance::Instance)
    init_mip_mixed(instance) |>
    achieve_mm_mixed |>
    solve_mip_mixed |>
    mm_result_mixed
end



mutable struct MIPMixedContext{Instance,A,M}
    instance::Instance
    variable::A
    model::M
end



function init_mip_mixed(instance::Instance)
    model = Model(Allocations.conf.MIP_SOLVER)

    @variable(model, A[Agents(instance), Goods(instance)], lower_bound = 0.0, upper_bound = 1.0)

    context = MIPMixedContext(instance, A, model)

    # Each good must be fully allocated amongst all agents
    for good in Goods(context.instance)
        @constraint(
            context.model,
            sum(context.variable[agent, good] for agent in Agents(instance)) == 1
        )
    end

    # Each good that is an "item" is indivisble, and thus must be either 1 or 0
    for item in Items(context.instance), agent in Agents(context.instance)
        set_binary(context.variable[agent, item])
    end

    return context
end



function achieve_mm_mixed(context::MIPMixedContext)

    @variable(context.model, v_min)

    for agent in Agents(context.instance)
        @constraint(
            context.model,
            v_min <= sum(context.variable[agent, good] * context.instance.valuations[agent, good] for good in Goods(context.instance))
        )
    end

    @objective(context.model, Max, v_min)

    return context
end



function solve_mip_mixed(context::MIPMixedContext)
    optimize!(context.model)
    @assert termination_status(context.model) in Allocations.conf.MIP_SUCCESS
    return context
end



function mm_result_mixed(context::MIPMixedContext)

    mixed_allocation = MixedAllocation(context.instance)

    for agent in Agents(context.instance), good in Goods(context.instance)
        assigned_value = JuMP.value(context.variable[agent, good])
        # println("Agent: $agent, gets $assigned_value of Good: $good")
        mixed_allocation.assigned[agent, good] = assigned_value
    end

    result = (
        maximin=objective_value(context.model),
        allocation=mixed_allocation,
        model=context.model
    )
    return result
end