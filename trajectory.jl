struct Trajectory
	label :: Int64
	start :: Vector{Float64}
	ending :: Vector{Float64}
	points :: Vector{Vector{Float64}}
end


import Base: length, iterate

function length(trajectory::Trajectory)
    return length(trajectory.points)
end

function iterate(trajectory::Trajectory, state  = 1)
	if state > length(trajectory.points)
		return nothing
	else
		return (trajectory.points[state], state+1)
	end
end


function display_trajectory(trajectory::Trajectory)
	a = "label: $(trajectory.label)"
	b = "\nfrom $(trajectory.start) to $(trajectory.ending)"
	c = "\npoints:"
	n = length(trajectory.points)
	m = [length(a), length(b), length(c)]
	d = []
	for k = 1:n
		temp = "$(trajectory.points[k])" 
		push!(d, temp)
		push!(m, length(temp))
	end
	ma = maximum(m)
	println(repeat("#", ma))
	println(a)
	println(b)
	println(c)
	for k = 1:n 
		println(d[k])
	end
	println(repeat("#", ma))
	return true
end
