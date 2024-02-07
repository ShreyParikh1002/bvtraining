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
		if prev.nil?
			puts "Element found at position 0"
		elsif prev.next.nil?
			puts "Element #{val} not found"
		else
			puts "Element found"
		end
	end

	def delete(val)
		if @head.val == val
			return @head.next
		end
		prev = search_prev_LL(@head, val)
		if prev.next.nil?
			puts "Can't be deleted as element not found"
		else
			prev.next = prev.next.next
			puts "Element #{val} deleted"
		end

		@head;
	end

	def print_ll
		cur = @head
		while !cur.nil?
			print "#{cur.val} "
			cur = cur.next
		end
	end

	def reverse_ll
		cur = @head
		nxt = nil
		prev = nil
		while !cur.nil?
			nxt = cur.next
			cur.next = prev
			prev = cur
			cur = nxt
		end
		@head = prev
		puts "Reversed"
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
	
		cur_level
	end

	def preorder_traversal(cur = @root)
		if nil == cur
			return
		end
		print "#{cur.val} "
		preorder_traversal(cur.left)
		preorder_traversal(cur.right)
	end

	def inorder_traversal(cur = @root)
		if nil == cur
			return
		end
		inorder_traversal(cur.left)
		print "#{cur.val} "
		inorder_traversal(cur.right)
	end

	def postorder_traversal(cur = @root)
		if nil == cur
			return
		end
		postorder_traversal(cur.left)
		postorder_traversal(cur.right)
		print "#{cur.val} "
	end

	def all_paths(root = @root)
		arr = []
		dfs_helper(root, arr)
	end

	def delete(cur_node = @root, val)
		if cur_node.nil? 
			return cur_node
		end
		if val > cur_node.val
			cur_node.right = delete(cur_node.right, val)
		elsif val < cur_node.val
			cur_node.left = delete(cur_node.left, val)
		else

			if cur_node.left.nil?
				return cur_node.right
			elsif cur_node.right.nil?
				return cur_node.left
			else
				cur = cur_node.right
				while !cur.left.nil?
					cur = cur.left
				end
				cur_node.val = cur.val
				cur_node.right = delete(cur_node.right, cur_node.val)
			end
		end
	
		cur_node
	end

	def print_largest
		cur = @root
		while cur != nil
			largest = cur.val
			cur = cur.right
		end
		puts "Largest element is #{largest}"
	end

	def print_smallest
		cur = @root
		while cur != nil
			smallest = cur.val
			prev = cur
			cur = cur.left
		end
		puts "Smallest element is #{smallest}"	
	end

	def search(val)
		cur = @root
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

def search_prev_LL(root, val)
	cur = root
	prev = nil
	while !cur.nil?
		if val == cur.val
			return prev
		end
		prev = cur
		cur = cur.next
	end
	
	prev
end

def not_null?(node)
	if node.val.nil?
		puts "Empty"
		return false
	end
	true
end

def main
	while true 
		puts "Welcome to BlogVault training\nEnter quit to exit\nEnter 1 to initialise a BST\nEnter 2 to initialise a Linked List"
		case gets.chomp
		when "quit"
			break
		when "1"
			bst = BST.new(nil)
			puts "Initialised BST"
			while true
				puts "Insert operation number"
				case gets.chomp
				when "quit"
					file_arr = []
					if !bst.root.val.nil?
						file_arr = bst.level_order
					end
					file = File.open("bst.txt", 'w')
					file.write(file_arr.join(','))
					file.close
					break
				when "1"
					puts "Do you want to create tree from file enter Y or N"
					file_choice = gets.chomp
					element_arr = []
					if 'Y' == file_choice
						puts "Enter file path "
						file_path = gets.chomp
						if File.exist?(file_path)
							file = File.open(file_path, 'r')
							content = file.read
							element_arr = content.split(',')
						else
							puts "Invalid path"
						end
					else			
						puts "Enter elements to be inserted, seperated by commas"
						element_arr = gets.chomp.split(',')
					end
					for cur_element in element_arr
						if nil == bst.root.val
							bst.root.val = cur_element.to_i
						else
							bst.insert(cur_element.to_i)
						end
					end
				when "2" 
					if not_null?(bst.root)
						bst.print_largest
					end
				when "3" 
					if not_null?(bst.root)
						bst.print_smallest
					end
				when "4" 
					if not_null?(bst.root)
						puts "\nLevelorder : "
						bst.level_order
						puts "\nInorder : "
						bst.inorder_traversal
						puts "\nPreorder : "
						bst.preorder_traversal
						puts "\nPostorder : "
						bst.postorder_traversal
						puts "\n"
					end
				when "5" 
					if not_null?(bst.root)
						puts "Enter element to search :"
						element = gets.chomp.to_i
						bst.search( element)
					end
				when "6" 
					if not_null?(bst.root)
						puts "Enter element to delete :"
						element = gets.chomp.to_i
						bst.root = bst.delete(element)
						if bst.root.nil?
							bst = BST.new(nil)
						end
					end
				when "7" 
					if not_null?(bst.root)
						puts "Printing all paths"
						bst.all_paths
					end
				end
			end
		when "2"
			linked_list = LinkedList.new(nil)
			puts "Initialised linked list"
			while true
				puts "\nInsert operation number"
				case gets.chomp
				when "quit"
					break
				when "1"
					if not_null?(linked_list.head)
						puts "Enter element to search :"
						element = gets.chomp.to_i
						linked_list.search(element)
					end
				when "2" 			
					puts "Enter elements to be inserted, seperated by commas"
					element_arr = gets.chomp.split(',')
					for cur_element in element_arr
						if nil == linked_list.head.val
							linked_list.head.val = cur_element.to_i
						else
							linked_list.insert(cur_element.to_i)
						end
					end
				when "3"
					if not_null?(linked_list.head)
						puts "Enter element to be deleted :"
						element = gets.chomp.to_i
						linked_list.head = linked_list.delete(element)
						if linked_list.head.nil?
							linked_list = LinkedList.new(nil)
						end
					end
				when "4" 
					if not_null?(linked_list.head)
						linked_list.reverse_ll
					end
				when "5" 
					if not_null?(linked_list.head)
						linked_list.print_ll
					end
				end
			end
		end
	end
end
main
