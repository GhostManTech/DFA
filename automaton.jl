include("node.jl");
include("trajectory.jl");
using Test;

struct Automaton
	q0 :: Node
	F :: Vector{Node}
	delta :: Dict{Tuple{Node, Trajectory}, Node}
	Q :: Vector{Node}
	sigma :: Vector{Trajectory}
end


function display_automaton(v :: Automaton)
	n::Int64 = length(v.Q)
	println("States :")
	for k = 1:n 
		println("$(v.Q[k])")
	end

	println("\nInitial state:")
	println("q_0 : $(v.q0.label)")
	n = length(v.F)
	println("\nFinal states:")
	for k = 1:n
		println("$(v.F[k].label)")
	end

	println("\nTransitions:")
	for (i,j) in keys(v.delta)
		println("$(i.label) => $(v.delta[(i,j)].label)");
	end

	n = length(v.sigma)
	println("\nAlphabet of trajectories:")
	for k = 1:n 
		println("$(v.sigma[k].label)")
	end
	return true
end


function run_automaton(v :: Automaton, w :: Vector{Trajectory})
	q = v.q0
	while length(w) > 0
		println(w)
		if !((q, w[1]) in keys(v.delta))
			return false
		end
		q = v.delta[(q,w[1])]
		w = w[2:length(w)]
	end
	return q in v.F
end

function add_link_automaton!(v::Automaton, start::Node, trajectory::Trajectory, ending::Node)
	if !(start in v.Q) || !(ending in v.Q)
		error("Start node and end node must be in the automaton state set.")
	else
		if !((start, trajectory) in keys(v.delta))
			if trajectory in v.sigma
				v.delta[(start, trajectory)]=ending
			else
				push!(v.sigma, trajectory)
				v.delta[(start, trajectory)]=ending
			end
		end
	end
	return true
end

function add_state_automaton!(v::Automaton, state::Node, key::Bool = false)
	if !(state in v.Q)
		push!(v.Q, state)
		if key
			push!(v.F, state)
		end
	end
	return true
end

node = Node("0", [0.0, 0.0])
node1 = Node("1", [0.0, 1.0])
traj1 = Trajectory(1, [0.0, 0.0], [0.0,0.0], [[0.0, 0.0]])
traj2 = Trajectory(2, [0.0, 0.0], [0.0, 1.0], [[0.0, 0.0], [0.0, 1.0]])
a = Automaton(node, [node], Dict((node,traj1) => node), [node], [traj1, traj2])

@test display_trajectory(traj2)

@test display_automaton(a)

@test add_state_automaton!(a, node1, true)

@test add_link_automaton!(a, node, traj2, node1)

@test display_automaton(a)

@test run_automaton(a, [traj1])