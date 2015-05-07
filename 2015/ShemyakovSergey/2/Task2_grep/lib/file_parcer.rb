class FileParcer

	def initialize(name)
		@name = name
	end
	
	def get_file
		s = File.read(@name)
		t = %w()
        s.each_line{|i| t.push(i)}
      	t
	end
end