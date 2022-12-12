using code

"""
Takes a comma seperated list of strings and return a correctly formatted matrix 
to use these as labels in plots.
"""
function to_label_list(comma_seperated_list)
    return reshape(comma_seperated_list, 1, length(comma_seperated_list))
end

function get_agent_labels(instance::Instance)
    return to_label_list(["Agent $a" for a in Agents(instance)])
end

function get_bundle_labels(instance::Instance)
    return to_label_list(["Bundle $a" for a in Agents(instance)])
end

function get_good_labels(instance::Instance)
    labels = [
        if g in Items(instance)
            "Item $g"
        else
            "Cake"
        end for g in Goods(instance)
    ]
    return to_label_list(labels)
end