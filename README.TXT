Rake.py
Rake will ask for user input (text file), which will be the query passage/document from which keywords will be extracted.

Tryy.sh
Uses rake to loop through list of Documents/passages, and runs rake on each file, creating new files with just the extracted key words.

Splitfiles.py
Splits files based on a chunk length of 50/can be changed based on text 

Order-
1. Tryy.sh implements Rake so it should be implemented on a group of textfiles, automatically extracting keywords on each.
2.Splitfiles.py should be used on Documents to create passage files.

1.Python Rake.py ( This will extract the top 20 keywords from a given text document)
2.Bash Tryy.sh (This will loop through directories, the one used here is the Documents Folder, and implement Rake on each given text Document, and will export the resulting keywords to a directory called Raked_Documents.



