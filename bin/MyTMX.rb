# **********************************************************************
# @file MyTMX.rb
# @author Felix Voituret (felix.voituret@univ-avignon.fr)

# Resolving dependencies.
require 'nokogiri'
require_relative 'TU'
require 'json'

# ***********************************************************************
# Custom XML parser for TMX file.
# @see Nokogiri::XML::SAX::Document
# @author Felix Voituret (felix.voituret@univ-avignon.fr)
class MyTMX < Nokogiri::XML::SAX::Document

	# ***********************************************************************
	# Default constructor
	def initialize(filename, options)
		@filename = filename
		@tags = options[:t]

		@start, @stop = nil, nil
		@elapsed = nil
		@isseg = false
		@fileinfo = {}
		@log = Logger.new('logfile.log', 5, 1024000)
		@counter = 1
		@content = {}
		@lang
		@thisseg
	end	

	# ***********************************************************************
	# Override Nokogiri::XML::SAX::Document::start_document event method.
	def start_document
		@start = Time.now
		@elapsed = @start
		@log.info "document started at #{@start}"
	end

	# ***********************************************************************
	# Override Nokogiri::XML::SAX::Document::end_document event method.
	def end_document
		@stop = Time.now
		@elapsed = @stop - @elapsed 
		@log.info "document ended and took #{@elapsed} secs to process"
		@log.info "document has source lang -  #{@fileinfo[:sourcelang]}"
		@log.info @content.size
		# @log.info @content['1'].sourceToString
	end
	
	# ***********************************************************************
	# Override Nokogiri::XML::SAX::Document::start_element event method.
	def start_element(name, attrs = [])
		if name == "header"
			@fileinfo[:sourcelang] = Hash[attrs]['srclang']
		elsif name == "tu"
		elsif name == "tuv"
			@lang =  Hash[attrs]['xml:lang']		
		elsif name == "seg"
			@isseg = true	
		end
	end
	
	# ***********************************************************************
	# Override Nokogiri::XML::SAX::Document::end_element event method.
	def end_element(name, attrs= [])
		if name == "seg"
			@isseg = false
		elsif name == "tu"
			@counter += 1	
		end		
	end	

	# ***********************************************************************
	# Override Nokogiri::XML::SAX::Document::characters event method.
	# @param string The character read from the parser.
	def characters(string)
		if @isseg and !string.empty?
			if $DEBUG
				@log.info string
				@log.info @counter
				@log.info @lang
				@log.info string
			end
			TU.new(@counter, @lang, string)
			if @fileinfo[:sourcelang] == @lang
				#create new TU
				@thisseg = TU.new(@counter, @lang, string)
				@content[@counter.to_s] = @thisseg
			else  
				#thisseg exists 
				@thisseg = @content[@counter.to_s]
				@thisseg.setTarget(@lang, string)
				@content[@counter.to_s] = @thisseg
			end	 				
		end	
	end

	# ***********************************************************************
	# Cast the given
	def toYAML
		# Initialize buffer with metadata.
		@buffer = "Document {\n"
		@buffer += "\tfilename: '#{@filename}',\n"
		@buffer += "\tsourcelang: '#{@fileinfo[:sourcelang]}',\n"
		@buffer += "\tsegments: [\n"
		# Fill segment part
		@content.each do |name, segment|
			@buffer += "\t\t" + segment.toYAML()
		end
		@buffer += "\t]\n}"
		return @buffer
	end

	def toJSON

		@segslist = @content.map do |name, u|
  			{ :id => u.getid, u.getSourceLang.to_sym => u.getSourceContent, u.getTargetLang.to_sym => u.getTargetContent}
		end
		return JSON.generate @segslist
		# @buffer = "Document {\n"
		# @buffer += "\tfilename: '#{@filename}',\n"
		# @buffer += "\tsourcelang: '#{@fileinfo[:sourcelang]}',\n"
		# @buffer += "\tsegments: [\n"

		# @content.each do |name, segment|
		# 	@buffer += segment.toJSON()
		# end
		
	end 		
	
end