function alloc_half_mms_mixed(instance::Instance, ; approximate::Bool=false)
    allocation = MixedAllocation(instance)

    # find expected MMS (bundle value) for all agents
    if approximate
        # approximate mms by finding the PROP of each agents valuation.
        mms_values = [sum(instance.valuations[agent, :]) / instance.num_agents for agent in 1:instance.num_agents]
    else
        # exact value (sepcified in pseudo code for the algroithm), very slow
        mms_values = [mms_mixed(instance, agent).maximin for agent in 1:instance.num_agents]
    end

    # Phase 1
    # give items with value >= 0.5 to agents where possible and remove them from further consideration
    for (agent, mms) in enumerate(mms_values)
        for item in Items(instance)
            if sum(allocation.assigned[:, item]) == 1
                continue # item already assigned
            end
            value = instance.valuations[agent, item]
            if value >= 0.5 * mms
                allocation.assigned[agent, item] = 1
                mms_values[agent] = -1 # -1 signifies gents no longer wanting anything
                break
            end
        end
    end



    # Phase 2
    # while there is more than 1 agent remaining for consideration
    while count(value -> (value != -1), mms_values) > 1
        # create empty bundle
        bundle = zeros(instance.num_goods) # values from 0 to 1 of how much the bundle contains of each good
        # repeatedly add items to the bundle until value of bundle is >= 0.5 of an agents MMS
        for item in Items(instance)
            if sum(allocation.assigned[:, item]) == 1
                continue # item already assigned
            end
            bundle[item] = 1 # add item to bundle

            # check if any agent values the bundle over (1-0.5) MMS
            bundle_full = false
            for agent in Agents(instance)
                agents_bundle_value = 0
                for (good, size) in enumerate(bundle)
                    agents_bundle_value += size * instance.valuations[agent, good]
                end
                if agents_bundle_value >= (1 - 0.5) * mms_values[agent]
                    bundle_full = true
                    break
                end
            end
            if bundle_full
                break
            end
        end
        # now find which agent requies the least amount of cake to get 0.5 of their MMS (with the bundle)
        cake_required = ones(instance.num_agents)
        for agent in Agents(instance)
            if mms_values[agent] == -1
                continue
            end
            agents_bundle_value = 0
            for (good, size) in enumerate(bundle)
                agents_bundle_value += size * instance.valuations[agent, good]
            end
            for cake in Cakes(instance)
                if agents_bundle_value >= 0.5 * mms_values[agent]
                    cake_required[agent] = 0
                    break
                end
                cake_required[agent] = ((0.5 * mms_values[agent]) - agents_bundle_value) / instance.valuations[agent, cake]
            end
        end
        agent = findmin(cake_required)[2]
        # give the bundle to this agent, and remove the items from further consideration
        for (good, assigned) in enumerate(bundle)
            allocation.assigned[agent, good] += assigned
        end
        # give the cake to this agent
        for cake in Cakes(instance)
            allocation.assigned[agent, cake] += cake_required[agent]
        end
        mms_values[agent] = -1
    end

    # give remaining items to last agent
    for agent in Agents(instance)
        if mms_values[agent] == -1 && agent != instance.num_agents
            continue # skip all finished agents
        end
        for good in Goods(instance)
            allocation.assigned[agent, good] += 1 - sum(allocation.assigned[:, good])
        end
    end

    return allocation
end