struct Node
	label::String
	point::Vector{Float64}
end

import Base: length, iterate

function length(node::Node)
    return length(node.label)
end

function iterate(node::Node, state = 1)
	if state > length(node.point)
		return nothing
	else 
		return (node.point[state], state +1)

	end
end