# **********************************************************************
# @file TU.rb
# @author 

# ***********************************************************************
# Model class. Represent a TU node into a TMX file.

class TU

	# ***********************************************************************
	# Default constructor
	# @param id
	# @param sourceLang Source language used.
	# @param srctext Source text content.
	def initialize(id, lang, text)
		@id = id
		@sourceLang = lang
		@sourceText = text
	end	



	# ***********************************************************************
	# Target setter.
	# @param lang Target language.
	# @param text Target text content. 
	def setTarget(lang, text)
		@targetLang = lang	
		@targetText = text
	end	

	# ***********************************************************************
	# Cast source data to string.
	# @return Source data as string.
	def getSourceLang
		"#{@sourceLang}"
	end
	def getSourceContent	  
		"#{@sourceText}"
	end	
	
	# ***********************************************************************
	# Cast target data to string.
	# @return target data as string.
	def getTargetLang
		"#{@targetLang}"
	end	

	def getTargetContent
		"#{@targetText}"
	end	

	def getid
		"#{@id}"
	end	

	# ***********************************************************************
	# Compute number of word.
	# @return Number of word into the source text.
	def getWordCount
		@sourceText.gsub(/[^-a-zA-Z]/, ' ').split.size
	end	

	# ***********************************************************************
	# ?
	def isTerm
		if @sourceText == ""
			return false
		else
			return getWordCount() < 4 && getWordCount() > 0
		end 	
	end
	
	# ***********************************************************************
	# Cast the given object to YAML string.
	# @return YAML string representing this object.
	def toYAML()
		@buffer = "{source: {lang: '#{@sourceLang}', content:'#{@sourceText}'}, target: {lang: '#{@targetLang}', content: '#{@targetText}'}},\n"
		return @buffer
	end

	def toJSON()
		@buffer = "{source: {lang: '#{@sourceLang}', content:'#{@sourceText}'}, target: {lang: '#{@targetLang}', content: '#{@targetText}'}},\n"	
	end	


	
end