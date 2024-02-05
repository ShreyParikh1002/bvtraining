class Node
	attr_accessor :val, :left, :right

	def initialize(val)
		@val = val
		@left = nil
		@right = nil
	end
end

class LinkedListNode < Node
	attr_accessor :next

	def initialize(val)
		@val = val
		@next = nil
	end
end

class LinkedList
	attr_accessor :head

	def initialize(val=nil)
		@head = LinkedListNode.new(val)
	end

	def insert(val)
		cur = @head
		while !cur.nil?
			prev = cur
			cur = cur.next
		end
		prev.next = LinkedListNode.new(val)
	end
	
	# have created a function search_prev_LL which returns the node
	# just before the required element to improve code reusability
	def search(val)
		prev = search_prev_LL(@head, val)
		if prev.next.nil?
			puts "Element #{val} not found"
		else
			puts "Element found"
		end
	end

	def delete(val)
		if @head.val == val
			@head = @head.next
			return
		end
		prev = search_prev_LL(@head, val)
		if prev.next.nil?
			puts "Can't be deleted as element not found"
		else
			prev.next = prev.next.next
			puts "Element #{val} deleted"
		end
		return @head;
	end

	def print_ll
		cur = @head
		while !cur.nil?
			print "#{cur.val} "
			cur = cur.next
		end
	end

end

class BST
	attr_accessor :root
	
	def initialize(val=nil)
		@root = Node.new(val)
	end

	def insert(val)
		cur = @root
		while cur != nil
			prev = cur
			if val > cur.val
				cur = cur.right
			else
				cur = cur.left
			end
		end
		if val > prev.val
			prev.right = Node.new(val)
		else
			prev.left = Node.new(val)
		end
		puts "inserted #{val}"
	end
 
	def level_order
		traverse = Queue.new
		traverse.enq(root)
		cur_level = []
		while !traverse.empty?
			cur = traverse.deq
			cur_level.push(cur.val)
			if cur.left != nil
				traverse.enq(cur.left)
			end
			if cur.right != nil
				traverse.enq(cur.right)
			end
		end
		cur_level.each { |elem| print "#{elem} " }
		return cur_level
	end
end

def inorder_traversal(root)
	if nil == root
		return
	end
	inorder_traversal(root.left)
	print "#{root.val} "
	inorder_traversal(root.right)
end

def postorder_traversal(root)
	if nil == root
		return
	end
	postorder_traversal(root.left)
	postorder_traversal(root.right)
	print "#{root.val} "
end

def preorder_traversal(root)
	if nil == root
		return
	end
	print "#{root.val} "
	preorder_traversal(root.left)
	preorder_traversal(root.right)
end

def all_paths(root)
	arr = []
	dfs_helper(root, arr)
end

def dfs_helper(root, arr)
	if nil == root
		arr.each { |elem| print "#{elem} " }
		puts "\n"
		return
	end

	arr << root.val
	if !root.left && !root.right
		arr.each { |elem| print "#{elem} " }
		puts "\n"
	end

	if root.left != nil
		dfs_helper(root.left, arr)
	end

	if root.right != nil
		dfs_helper(root.right, arr)
	end
	arr.pop()
end

def print_largest(root)
	cur = root
	while cur != nil
		largest = cur.val
		cur = cur.right
	end
	puts "Largest element is #{largest}"
end

def print_smallest(root)
	cur = root
	prev = cur
	while cur != nil
		smallest = cur.val
		prev = cur
		cur = cur.left
	end
	puts "Smallest element is #{smallest}"
	return prev	
end

def search(root, val)
	cur = root
	while cur != nil
		if val == cur.val
			puts "Element #{val} found in BST"
			return cur
		elsif cur.val > val
			prev = cur
			cur = cur.left
		else 
			prev = cur
			cur = cur.right
		end
	end
	puts "Element #{val} not present in BST"
end

def delete(root, val)
	if root.nil? 
		return root
	end
	if val > root.val
		root.right = delete(root.right, val)
	elsif val < root.val
		root.left = delete(root.left, val)
	else

		if root.left.nil?
			return root.right
		elsif root.right.nil?
			return root.left
		else
			cur = root.right
			while !cur.left.nil?
				cur = cur.left
			end
			root.val = cur.val
			root.right = delete(root.right, root.val)
		end

	end
	return root
end

def search_prev_LL(root, val)
	cur = root
	prev = LinkedListNode.new(-1)
	prev.next = root
	while !cur.nil?
		if val == cur.val
			return prev
		end
		prev = cur
		cur = cur.next
	end
	return prev
end

def reverse_ll(head)
	cur = head
	nxt = nil
	prev = nil
	while !cur.nil?
		nxt = cur.next
		cur.next = prev
		prev = cur
		cur = nxt
	end
	puts "Reversed"
	return prev
end

def not_null_check(node)
	if node.nil?
		puts "Empty"
		return false
	end
	return true
end

def main
	while true 
		puts "Welcome to BlogVault training\nEnter 0 to quit\nEnter 1 to initialise a BST\nEnter 2 to initialise a Linked List"
		@choice = gets.chomp
		case
		when "0" == @choice
			break

		when "1" == @choice
			@root_node = nil
			puts "initialised BST"
			while true
				puts "insert operation number"
				operation = gets.chomp
				case
				when "0" == operation
					@choice = 0
					file_arr = []
					if !@root_node.nil?
						file_arr = @root_node.level_order
					end
					file = File.open("bst.txt", 'w')
					file.write(file_arr.join(','))
					file.close
					break

				when "1" == operation
					puts "Do you want to create tree from file enter Y or N"
					file_choice = gets.chomp
					if 'Y' == file_choice
						file = File.open("bst.txt", 'r')
						content = file.read
						element_arr = content.split(',')
					else			
						puts "Enter elements to be inserted, seperated by commas"
						elements = gets.chomp
						element_arr = elements.split(',')
					end

					element_arr.each { |element| print "#{element} ," }
					for cur_element in element_arr
						if nil == @root_node
							@root_node = BST.new(cur_element.to_i)
						else
							@root_node.insert(cur_element.to_i)
						end
					end

				when "2" == operation
					flag = not_null_check(@root_node)
					if flag
						print_largest(@root_node.root)
					end

				when "3" == operation
					flag = not_null_check(@root_node)
					if flag
						print_smallest(@root_node.root)
					end

				when "4" == operation
					flag = not_null_check(@root_node)
					if flag
						puts "\nLevelorder : "
						@root_node.level_order
						puts "\nInorder : "
						inorder_traversal(@root_node.root)
						puts "\nPreorder : "
						preorder_traversal(@root_node.root)
						puts "\nPostorder : "
						postorder_traversal(@root_node.root)
						puts "\n"
					end

				when "5" == operation
					flag = not_null_check(@root_node)
					if flag
						puts "Enter element to search :"
						element = gets.chomp.to_i
						search(@root_node.root, element)
					end
				when "6" == operation
					flag = not_null_check(@root_node)
					if flag
						puts "Enter element to delete :"
						element = gets.chomp.to_i
						delete(@root_node.root, element)
					end
				when "7" == operation
					puts "printing all paths"
					flag = not_null_check(@root_node)
					if flag
						all_paths(@root_node.root)
					end
				end
			end
		when "2" == @choice

			@linked_list = nil
			puts "initialised linked list"
			while true
				puts "\nInsert operation number"
				operation = gets.chomp
				case
				when "0" == operation
					break
				when "1" == operation
					flag = not_null_check(@linked_list)
					if flag
						puts "Enter element to search :"
						element = gets.chomp.to_i
						@linked_list.search(element)
					end

				when "2" == operation			
					puts "Enter elements to be inserted, seperated by commas"
					elements = gets.chomp
					element_arr = elements.split(',')
					for cur_element in element_arr
						if nil == @linked_list
							@linked_list = LinkedList.new(cur_element.to_i)
						else
							@linked_list.insert(cur_element.to_i)
						end
					end

				when "3" == operation
					flag = not_null_check(@linked_list)
					if flag
						puts "Enter element to be deleted :"
						element = gets.chomp.to_i
						@linked_list.delete(element)
					end
				when "4" == operation 
					flag = not_null_check(@linked_list)
					if flag
						@linked_list.head = reverse_ll(@linked_list.head)
					end
				when "5" == operation
					flag = not_null_check(@linked_list)
					if flag
						@linked_list.print_ll
					end
				end
			end
		end
	end
end
main
