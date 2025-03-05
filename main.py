#!/usr/bin/env python3
# -*- coding : utf-8 -*-

"""
@author : GhostManTech
""" 

class DFA:
	def __init__(self, Q, Sigma,delta, q0,F):
		self.Q = Q #set of states
		self.Sigma = Sigma # set of symbols
		self.delta = delta # transition function
		self.q0 = q0 # initial state
		self.F = F # Final states

	def __repr__(self):
		return f"Sigma : {self.Sigma}\t\nQ : {self.Q}\t\nq0 : {self.q0}\t\nDelta : {self.delta}\t\nF : {self.F}\n"

	def __str__(self):
		return f"Sigma : {self.Sigma}\t\nQ : {self.Q}\t\nq0 : {self.q0}\t\nDelta : {self.delta}\t\nF : {self.F}\n"

	def add_state(self, s, key : int):
		if s not in Q:
			self.Q.add(s)
			if key:
				self.F.add(s)

	def add_link(self, start, label, end):
		if start in self.Q and end in self.Q:
			if (start, label) not in self.delta.keys():
				if label in self.Sigma:
					self.delta[(start, label)]=end
				else:
					self.Sigma.add(label)
					self.delta[(start, label)]=end
			else:
				raise OSError("End and start node must be in the set of states.")

	def run(self,w):
		q = self.q0
		while w != "":
			q = self.delta[(q,w[0])]
			w = w[1:]
		return q in self.F

if __name__ == "__main__":
	D0 = DFA({0,1,2}
		, {"a", "b"}, 
		{(0, "a"):0, (0, "b"):1, (1, "a") : 2, (1, "b") : 1, (2, "a") : 2, (2, "b") : 2}
		, 0
		, {0,1})
	print(D0)
	print(D0.run("aba"))
	D0.add_link(0, "c", 0)
	print(D0)

