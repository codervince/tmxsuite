tmxsuite -- import/export your tmx memories to a database friendly format  and keep a track of previous imports
================================================================================


## SYNOPSIS

_use a different memory list, import using xpath two memories_

tmxsuite.rb --memorylist 'mymemorylist.yaml' import -X -f "mem1.tmx" "mem2.tmx" "mem3.tmx" 
tmxsuite.rb -m

tmxsuite.rb --export <directory><br>
tmxsuite.rb -e


_import a directory using SAX include some tags_

tmxsuite.rb import -f "memdir" --tags MECHENG, DOCU 

_import files using SAX include some tags_

tmxsuite.rb import --tags MECHENG, DOCU -f "mem1.tmx" -f "mem2.tmx"

_use initconfig to configure the GLOBAL configuration options (see below)

tmxsuite --tmxtemplates 'PATH/TO/TMXTEMPLATES'--username='me' initconfig


## DESCRIPTION

**tmxsuite** is a simple command line tool for importing tmx memory exchange files into a format suitable for
import into a database (JSON) and for use by Ajax.

**TMXSUITE** extracts source/target segment information from memories as well as some header information such as 
X,Y and Z, merges this information with import-specific options such as domain tags for the memory (what categories it can be assigned to, 
e.g. Mechanical Engineering, Documentation)

The Tags are kept in a localized namespace. E.g. if the source language of the memory is "DE", the tags will be assumed to beling to the "DE" 
language namespace.

**TMXSUITE** keeps a track through a list of memories of each import and prevents re-import of memories unless the number of segments has been updated.

**TMXSUITE** list function calls up the list of memories and allows you to sort by various criteria such as date_imported and name and a tag

**TMXSUITE** export takes a JSON file of segments and memory information such as source language and Y and Z and creates a TMX compliant memory
containing those segments, by writing to an existing empty TMX file template. 

Make sure the TMX templates work for Trados, MemoQ and Across?
May need separate templates and a flag for each.

Useful for creating lists of queries.
Add a JSON writer feature later.



How can we use cron to do a daily import?


## OPTIONS




## EXAMPLES

Import a directory - globals as per defaults
 
    $ tmxsuite import "mymemories" -m MECHENG,DOCU


To create this docu

     $ ronn man/tmxsuite.1.ronn

To read the man page!

     $ ronn man/tmxsuite.1.ronn

## FILES

list of files used by the app


## ENVIRONMENT

* uses this ENV variable

## BUGS




## AUTHOR

(codervince)[mailto:publicvince102@gmail.com]


## COPYRIGHT


## SEE ALSO

github page
front facing website
backend TUMBLR blog



