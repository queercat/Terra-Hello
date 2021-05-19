--[[local C = terralib.includecstring [[
   #include <stdio.h>
]]--

function printValue(test)
	print(test)
end

struct Node {value : int, after : &Node}

terra Node:add(node : &Node)
	var head : &Node = self

	while head.after ~= nil do
		head = head.after
	end

	head.after = node
end

terra Node:get_last()
	var head : &Node = self

	while head.after ~= nil do
		head = head.after
	end

	return head
end

terra Node:reverse() : &Node 
	var head : &Node = self
	var after : &Node = nil
	var last : &Node = nil

	while head ~= nil do
		after = head.after
		head.after = last
		last = head
		head = after
	end

	return last
end

terra Node:print_nodes()
	var head : &Node = self

	while head ~= nil do
		--C.printf("%i\n", head.value)		
		head = head.after
	end
end

terra instantiateNode() : Node
	var node : Node

	node.value = 0
	node.after = nil

	return node
end

node = instantiateNode()
node_two = instantiateNode()
node_three = instantiateNode()

node.value = 1
node_two.value = 2
node_three.value = 3

node.add(node, node_two)
node.add(node, node_three)

print("Node Information")
print("Node 0: ", node)
print("Node 1: ", node_two)
print("Node 2: ", node_three)
print("---------------------------------------------")

node_last = node.get_last(node)

print("Node last: ")
print(node_last)
print("---------------------------------------------")

node.reverse(node)
print("[Reversed nodes!]")

print("Node last: ")
node_last = node.get_last(node)
print(node_last)
print("---------------------------------------------")