# Implementation of RAKE - Rapid Automtic Keyword Exraction algorithm
# as described in:
# Rose, S., D. Engel, N. Cramer, and W. Cowley (2010). 
# Automatic keyword extraction from indi-vidual documents. 
# In M. W. Berry and J. Kogan (Eds.), Text Mining: Applications and Theory.unknown: John Wiley and Sons, Ltd.

import re
import operator
import nltk
import string
from nltk.stem.wordnet import WordNetLemmatizer
from string import punctuation	
import numpy as np
debug = False
test = True


def is_number(s):
    try:
        float(s) if '.' in s else int(s)
        return True
    except ValueError:
        return False


def load_stop_words(stop_word_file):
    """
    Utility function to load stop words from a file and return as a list of words
    @param stop_word_file Path and file name of a file containing stop words.
    @return list A list of stop words.
    """
    stop_words = []
    for line in open(stop_word_file):
        if line.strip()[0:1] != "#":
            for word in line.split():  # in case more than one per line
                stop_words.append(word)
    return stop_words


def separate_words(text, min_word_return_size):
    """
    Utility function to return a list of all words that are have a length greater than a specified number of characters.
    @param text The text that must be split in to words.
    @param min_word_return_size The minimum no of characters a word must have to be included.
    """
    splitter = re.compile('[^a-zA-Z0-9_\\+\\-/]')
    words = []
    for single_word in splitter.split(text):
        current_word = single_word.strip().lower()
        #leave numbers in phrase, but don't count as words, since they tend to invalidate scores of their phrases
        if len(current_word) > min_word_return_size and current_word != '' and not is_number(current_word):
            words.append(current_word)

    return words


def split_sentences(text):
    """
    Utility function to return a list of sentences.
    @param text The text that must be split in to sentences.
    """
    sentence_delimiters = re.compile(u'[.!?,;:\t\\\\"\\(\\)\\\'\u2019\u2013]|\\s\\-\\s')
    sentences = sentence_delimiters.split(text)
    return sentences


def build_stop_word_regex(stop_word_file_path):
    stop_word_list = load_stop_words(stop_word_file_path)
    stop_word_regex_list = []
    for word in stop_word_list:
        word_regex = r'\b' + word + r'(?![\w-])'  # added look ahead for hyphen
        stop_word_regex_list.append(word_regex)
    stop_word_pattern = re.compile('|'.join(stop_word_regex_list), re.IGNORECASE)
    return stop_word_pattern


def generate_candidate_keywords(sentence_list, stopword_pattern):
    phrase_list = []
    for s in sentence_list:
        tmp = re.sub(stopword_pattern, '|', s.strip())
        phrases = tmp.split("|")
        for phrase in phrases:
            phrase = phrase.strip().lower()
            if phrase != "":
                phrase_list.append(phrase)
    return phrase_list


def calculate_word_scores(phraseList):
    word_frequency = {}
    word_degree = {}
    for phrase in phraseList:
        word_list = separate_words(phrase, 0)
        word_list_length = len(word_list)
        word_list_degree = word_list_length - 1
        #if word_list_degree > 3: word_list_degree = 3 #exp.
        for word in word_list:
            word_frequency.setdefault(word, 0)
            word_frequency[word] += 1
            word_degree.setdefault(word, 0)
            word_degree[word] += word_list_degree  #orig.
            #word_degree[word] += 1/(word_list_length*1.0) #exp.
    for item in word_frequency:
        word_degree[item] = word_degree[item] + word_frequency[item]

    # Calculate Word scores = deg(w)/frew(w)
    word_score = {}
    for item in word_frequency:
        word_score.setdefault(item, 0)
        word_score[item] = word_degree[item] / (word_frequency[item] * 1.0)  #orig.
    #word_score[item] = word_frequency[item]/(word_degree[item] * 1.0) #exp.
    return word_score


def generate_candidate_keyword_scores(phrase_list, word_score):
    keyword_candidates = {}
    for phrase in phrase_list:
        keyword_candidates.setdefault(phrase, 0)
        word_list = separate_words(phrase, 0)
        candidate_score = 0
        for word in word_list:
            candidate_score += word_score[word]
        keyword_candidates[phrase] = candidate_score
    return keyword_candidates
    

def unicodetoascii(text): # decode from unicode to ascii

    uni2ascii = {
            ord('\xe2\x80\x99'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\x9c'.decode('utf-8')): ord('"'),
            ord('\xe2\x80\x9d'.decode('utf-8')): ord('"'),
            ord('\xe2\x80\x9e'.decode('utf-8')): ord('"'),
            ord('\xe2\x80\x9f'.decode('utf-8')): ord('"'),
            ord('\xc3\xa9'.decode('utf-8')): ord('e'),
            ord('\xe2\x80\x9c'.decode('utf-8')): ord('"'),
            ord('\xe2\x80\x93'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x92'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x94'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x94'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x98'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\x9b'.decode('utf-8')): ord("'"),

            ord('\xe2\x80\x90'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x91'.decode('utf-8')): ord('-'),

            ord('\xe2\x80\xb2'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb3'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb4'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb5'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb6'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb7'.decode('utf-8')): ord("'"),

            ord('\xe2\x81\xba'.decode('utf-8')): ord("+"),
            ord('\xe2\x81\xbb'.decode('utf-8')): ord("-"),
            ord('\xe2\x81\xbc'.decode('utf-8')): ord("="),
            ord('\xe2\x81\xbd'.decode('utf-8')): ord("("),
            ord('\xe2\x81\xbe'.decode('utf-8')): ord(")"),
            ord('\xC2\xB0'.decode('utf-8')): ord("r"),
            ord('\xC6\x92'.decode('utf-8')): ord("f"),
            ord('\xC2\xB1'.decode('utf-8')): ord(" "),
            ord('\xC2\xA5'.decode('utf-8')): ord("s"),
            ord('\xC5\xBF'.decode('utf-8')): ord("f"),
			ord('\xC2\xB6'.decode('utf-8')): ord(" "),
            ord('\xC2\xAF'.decode('utf-8')): ord("-"),
            ord('\xC3\x9F'.decode('utf-8')): ord("B"), 
            ord('\xE2\x9D\xA7'.decode('utf-8')): ord(" "), 
            ord('\xE2\x86\x92'.decode('utf-8')): ord(" "),
            ord('\xE2\x88\xA3'.decode('utf-8')): ord(" "), 
            ord('\xC2\xA6'.decode('utf-8')): ord(" "),
            ord('\xCC\x84'.decode('utf-8')): ord("-"),
            ord('\xE2\x80\xA2'.decode('utf-8')): ord("."),
            ord('\xE2\x86\x90'.decode('utf-8')): ord(" "),
            ord('\xE2\x96\xAA'.decode('utf-8')): ord(" "),
            ord('\xE2\x80\xA6'.decode('utf-8')): ord(" "),
            ord('\xC3\xA1'.decode('utf-8')): ord("a"),
            ord('\xE3\x80\x88'.decode('utf-8')): ord(" "),
            ord('\xCA\x90'.decode('utf-8')): ord("z"),
            ord('\xE3\x80\x89'.decode('utf-8')): ord(" "),
            ord('\xE2\x97\x8A'.decode('utf-8')): ord(" "),
            ord('\xC3\xB4'.decode('utf-8')): ord("o"),
            ord('\xC2\xB7'.decode('utf-8')): ord(" "),
            
            
             
            
            
            
                            }
    return text.decode('utf-8').translate(uni2ascii).encode('ascii')

#print unicodetoascii("weren\xe2\x80\x99t")




class Rake(object):
    def __init__(self, stop_words_path):
        self.stop_words_path = stop_words_path
        self.__stop_words_pattern = build_stop_word_regex(stop_words_path)

    def run(self, text):
        sentence_list = split_sentences(text)

        phrase_list = generate_candidate_keywords(sentence_list, self.__stop_words_pattern)

        word_scores = calculate_word_scores(phrase_list)

        keyword_candidates = generate_candidate_keyword_scores(phrase_list, word_scores)

        sorted_keywords = sorted(keyword_candidates.iteritems(), key=operator.itemgetter(1), reverse=True)
        return sorted_keywords
        
x = raw_input("")

if test:
    with open(x,'r') as myfile:
    	text=myfile.read().replace('\n', ' ')
    	"""for token in text:
    		if token in string.punctuation:
    			text.strip(token)"""
    			
    	text=unicodetoascii(text) #decodes from unicode to ascii for punctuation
    	
    	
    	
    	"""strips of punctuation"""
    	text=text.translate(string.maketrans("",""), string.punctuation)
    	text=text.lstrip("\r")
    
    	
    			 	
    	

				
    # Split text into sentences
    sentenceList = split_sentences(text)
    #stoppath = "FoxStoplist.txt" #Fox stoplist contains "numbers", so it will not find "natural numbers" like in Table 1.1
    stoppath = "SmartStoplist.txt"  #SMART stoplist misses some of the lower-scoring keywords in Figure 1.5, which means that the top 1/3 cuts off one of the 4.0 score words in Table 1.1
    stopwordpattern = build_stop_word_regex(stoppath)

    # generate candidate keywords
    phraseList = generate_candidate_keywords(sentenceList, stopwordpattern)

    # calculate individual word scores
    wordscores = calculate_word_scores(phraseList)

    # generate candidate keyword scores
    keywordcandidates = generate_candidate_keyword_scores(phraseList, wordscores)
    if debug: print keywordcandidates

    sortedKeywords = sorted(keywordcandidates.iteritems(), key=operator.itemgetter(1), reverse=True)
    if debug: print sortedKeywords

    totalKeywords = len(sortedKeywords)
    if debug: print totalKeywords
  

    #rake = Rake("SmartStoplist.txt")
    #keywords = rake.run(text)
   
    #print sortedKeywords
finalList=([key for (key, value) in sorted(keywordcandidates.iteritems(),key=operator.itemgetter(1), reverse=True)])
"""prints keys or key words by order of their value"""

def returnList(list):	
	if list > 20:
		list=list[0:20]
	array= np.asarray(list)
	return list	

print(returnList(finalList))
    
	
	
    
   # print (sortedKeywords.key)

	#print phraseList #prints total key words alone
    #print phraseList [0:(totalKeywords / 3)] #This prints the top 1/3 key words alone
	#print len(phraseList)
    #print len(text)
 	
	
	
	
	
	
	
	
	

   
  
    

