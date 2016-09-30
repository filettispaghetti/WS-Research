How to use :

1.Documents- contains full text documents from Shakespeare's plays to Bibles to Religious texts from the 16th Century.

2.Passages- contains the split passages from Documents as well as shorter passages that may be relevant to Shakespeare. Splitfiles.py was applied to Documents to achieve these files.

3.Documents_Raked: contains the files of extracted keywords from each document in Documents. Tryy.sh was applied to Documents to achieve these files.

4.>python Rake.py
( This will extract the top 20 keywords from a given text document, when prompted, you will need to enter the text file that you would like the keywords to be extracted from.)
OR
5.>echo Documents/$f | python rake.py > Documents_raked/$f
CONTINUE THIS
5.>bash tryy.sh 
(This will loop through directories, the one used here is the Documents Folder, and implement the Rake program on each given text Document, and will export the resulting keywords to a directory called Documents_Raked.)

6.>python Splitfiles.py 
(You will have to enter the name of the text file that you would like to split into the script itself, which will split the document based on a chunk length of 50 lines).

7. run.sh runs the experiment & generates figures

