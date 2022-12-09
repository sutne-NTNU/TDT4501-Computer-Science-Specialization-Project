"""
Allocate items in the instance randomly to the agents, cakes are allocated randomly between all agents such that the entire cake is allocted
"""
function alloc_random_mixed(instance::Instance)
    allocation = MixedAllocation(instance)

    # allocate items to random agents
    for item in Items(instance)
        # allocate the item randomly
        allocation.assigned[rand(1:instance.num_agents), item] = 1
    end

    # allocate each cake randomly between all agents
    for cake in Cakes(instance)
        remaining = 1
        # while there is something left of the cake
        while remaining > 0
            # randomly choose an agent
            agent = rand(1:instance.num_agents)
            # randomly choose a size for the piece
            piece_size = rand()
            if piece_size > remaining
                piece_size = remaining
            end
            # add the piece to the agent
            allocation.assigned[agent, cake] += piece_size
            remaining -= piece_size
        end
    end

    return allocation
end