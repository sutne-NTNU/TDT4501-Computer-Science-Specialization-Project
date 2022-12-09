"""
Each agents chooses their best avaiable item in turn until there is no more items. 
Each cake is cut `num_cuts` times such that an agent can at any point choose a slice of cake of size `1/num_cuts`.
"""
function alloc_round_robin_mixed(instance::Instance, num_pieces::Int=1)
    if num_pieces < 1
        throw(ArgumentError("num_pieces must be greater than 0"))
    end

    allocation = MixedAllocation(instance)

    # while there is still an unassigned good
    while !is_valid(allocation)
        for agent in Agents(instance)
            # find good of most value for agent
            best_value = 0.0
            best_good = 0
            portion = 1.0
            for good in Goods(instance)
                # check if good is already fully allocated
                if sum(allocation.assigned[:, good]) == 1
                    continue
                end

                if good in Cakes(instance)
                    # if the good is a cake, we need to cut it up
                    value = instance.valuations[agent, good] / num_pieces
                    if best_value < value
                        best_value = value
                        best_good = good
                        portion = 1.0 / num_pieces
                    end
                else
                    # good is an item
                    value = instance.valuations[agent, good]
                    if best_value < value
                        best_value = value
                        best_good = good
                        portion = 1.0
                    end
                end
            end
            if best_good == 0
                # no more goods to allocate
                break
            end
            # assign good to agent
            allocation.assigned[agent, best_good] += portion
        end
    end
    return allocation
end