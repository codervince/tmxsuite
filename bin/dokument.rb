module Dokument

	#put all instance properties common to documents here
	def whoami 
		"#{self.type.name} : #{self.to_s}"	
	end	
# /Users/vincevincent/rails/tmximport/tmxsuite/INPUT/5nebel.tmx

	class TMX
		include Dokument

		def initialize(filename)
			@filepath = filename
			@filename = File.basename(@filepath)
			raise ArgumentError.new("#{@filename} doesn't appear to be an valid TMX") unless valid_tmx?
		end	

		private

		def valid_tmx?
			if ! File.directory?(@filename) && /.*\.tmx$/.match(@filename) 
				return true
			end
			# if File.exists?(@filename)
			# 	#read first two lines
			# 	f = File.open(@filename)

			# 	xmlbanner = 2.times{f.gets}
			# 	puts xmlbanner
			# 	return true unless xmlbanner == "<tmx version='1.4'>" 
			# else
			
			# 	return false	
			# end	
      
    	end



	end	

end	