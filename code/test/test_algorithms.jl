using code
using Revise

function test_algorithms()
    instance = Instance(
        num_agents=3,
        num_goods=4,
        cake_size=3,
    )
    visualize(instance)

    println("\nRandom Mixed")
    alloc = alloc_random_mixed(instance)
    visualize(alloc)

    println("\nRound Robin")
    alloc = alloc_round_robin_mixed(instance)
    visualize(alloc)

    println("\nRound Robin - n pieces")
    alloc = alloc_round_robin_mixed(instance, instance.num_agents)
    visualize(alloc)

    println("\nHalf MMS - Allocations")
    alloc = alloc_half_mms(instance)
    visualize(alloc)

    println("\nHalf MMS - Allocations - n Pieces")
    alloc = alloc_half_mms(instance, instance.num_agents)
    visualize(alloc)

    println("\nHalf MMS - Mixed")
    alloc = alloc_half_mms_mixed(instance)
    visualize(alloc)
end
test_algorithms()