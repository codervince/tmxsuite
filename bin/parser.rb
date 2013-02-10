module Parser

	require "logger"
	require 'English'
	require 'pathname'
	require_relative 'MyTMX'
	require 'json'


	# require_relative 'MyTMX'
	$LOG_PATH = File.expand_path(File.dirname(__FILE__))+ "/logs"
	$LOG_FILE = "parselog.log"
	$p1 = Pathname.new($LOG_FILE).realpath


	#checks YAML file to see if memory has been handled
	#checks number of segments total and import time
	#if identical warning message
	## FIRST fix TXT to YAML 

	def seenbefore?(options)



	end	

	# def logfile?
	# 	if Dir[$LOG_PATH] == nil
	# 		command = "cd $p1 && mkdir logs && cd logs && touch #{$LOG_FILE}"
	# 		system(command)
	# 		unless $CHILD_STATUS.exitstatus == 0
	# 			raise "There was a problem running '#{command}'"
	# 			exit 1
	# 		end		
	# 	end
	# end	

	class TMXMultiParser

		include Parser

		def initialize(options)
			# logfile?
				# seenbefore? (options)
				@log = Logger.new($p1, 'daily')
				@log.info "Starting parsing"
				
				options[:xpath] ?  xpathparse(options) : saxparse(options)

		end	


		def saxparse(options)

			@log.info "Parsing using SAX into #{options[:format]}, #{options[:memorycount]} memories"
			options[:files].each do |f|

					# FELIX SAX
					serializer = MyTMX.new(f, options) 
					parser = Nokogiri::XML::SAX::Parser.new(serializer)
					parser.parse(File.open(f, encoding: Encoding::UTF_8))  

				case options[:format]             
              	when 'json'
                	#output file and wring to
                	 out = "#{f}.json"
					File.open(out, 'w') { |file| file.write(serializer.toJSON()) } 
                when 'yaml'  
                	out = "#{f}+1231+.yaml" 
                	File.open(out, 'w') { |file| file.write(serializer.toYAML()) }
              	when 'csv'
                  	@log.info "creating xls"
                when 'db'
					@log.info "uploading to database- config in external config files"
                else
                	raise "format error"
                end		
					
			end	

		end	

		def xpathparse(options)
			
				

		end	

	

	end	



end
