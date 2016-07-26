Rake.py
Rake will ask for user input (text file), which will be the query passage/document from which keywords will be extracted.

Tryy.sh
Uses rake to loop through list of files/passages, and runs rake on each file, creating new files with just the extracted key words.

Splitfiles.py
Splits files based on a chunk length of 50

Order-
1. Tryy.sh implements Rake so it should be implemented on a group of textfiles, automatically extracting keywords on each.
2.Splitfiles.py should be used on Documents to create passage files.


