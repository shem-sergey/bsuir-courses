class FolderParcer

	def initialize(name)
		@name = name
	end
	
	def get_folder
		t = %w()
		Dir.chdir(@name)
			Dir.foreach('.') do |filemane| 
				t = t + FileParcer.new(filemane).get_file if filemane != "." && filemane != ".."
			end
	    #end 
	    t	
	end
end