class Node
	attr_accessor :val, :left, :right

	def initialize(val)
		@val = val
		@left = nil
		@right = nil
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
			puts cur.val
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

# traversal techniques
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

def dfs(root, arr)
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
		dfs(root.left,arr)
	end
	if root.right != nil
		dfs(root.right,arr)
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

while true 
	puts "enter 1 to initialise BST and 0 to quit"
	@choice = gets.chomp
	if "0" == @choice
		break
	elsif "1" == @choice
		@root_node = nil
		puts "initialised BST"
		while true
			puts "insert operation number"
			operation = gets.chomp
			case
			when "0" == operation
				@choice = 0
				temp_arr = @root_node.level_order
				file = File.open("bst.txt", 'w')
				file.write(temp_arr.join(','))
				file.close
				break
			when "1" == operation
				@ele_arr = []
				puts "Do you want to create tree from file enter Y or N"
				file_choice = gets.chomp
				if 'Y' == file_choice
					file = File.open("bst.txt", 'r')
					content = file.read
					@ele_arr = content.split(',')
				else			
					puts "Enter element to insert seperated by commas"
					ele = gets.chomp
					@ele_arr = ele.split(',')
				end
				@ele_arr.each { |elem| print "#{elem} ," }
				for cur_ele in @ele_arr
					if nil == @root_node
						@root_node = BST.new(cur_ele.to_i)
					else
						@root_node.insert(cur_ele.to_i)
					end
				end
			when "2" == operation
				print_largest(@root_node.root)
			when "3" == operation
				print_smallest(@root_node.root)
			when "4" == operation
				puts "\nLevelorder : "
				@root_node.level_order
				puts "\nInorder : "
				inorder_traversal(@root_node.root)
				puts "\nPreorder : "
				preorder_traversal(@root_node.root)
				puts "\nPostorder : "
				postorder_traversal(@root_node.root)
				puts "\n"
			when "5" == operation
				puts "Enter element to search :"
				ele = gets.chomp.to_i
				search(@root_node.root, ele)
			when "6" == operation
				puts "Enter element to delete :"
				ele = gets.chomp.to_i
				delete(@root_node.root, ele)
			when "7" == operation
			 	puts "printing all paths"
				arr = []
				dfs(@root_node.root, arr)
			end
		end
	end
end
