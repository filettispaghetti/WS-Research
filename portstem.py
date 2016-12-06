from nltk.stem import PorterStemmer
from nltk.tokenize import sent_tokenize, word_tokenize

ps = PorterStemmer()

example_words = ["Obedient","Helpful","Endevour","Beat","Fear","God",
"Head","Thereby","Compelled","Learn","Duty","Dying","Death",
"Advantage","Brother's","Blood","Thirsty","Earth","Drunk",
"Whet","Furious","Peers","Blessed","Peacemakers","Earth","Go","Get","Some",
"Water","Wash","Filthy","Witness","Hand","Name","Blotted","Book","Life"]

for w in example_words:
    print(ps.stem(w))