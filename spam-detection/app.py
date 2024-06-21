import streamlit as st
import pickle

# Clean the corpus
import re
import string 

import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import SnowballStemmer

stop_words = stopwords.words('english')
stop_words.extend(['u', 'im', 'c'])
stemmer = SnowballStemmer('english')

def clean_text(text):

    '''Make text lowercase,
    Remove text in sequare brackets, remove links, remove punctuation
    and remove words containing numbers.
    '''
    text = str(text).lower()
    text = re.sub('\[.*?]', '', text)
    text = re.sub('https?://\S+|WWW\.\S+', '', text)
    text = re.sub('<.*?>+', '', text)
    text = re.sub('[%s]' % re.escape(string.punctuation), '', text)
    text = re.sub('\n', '', text)
    text = re.sub('\w*\d\w*', '', text)

    # Remove stopwords
    text = " ".join([word for word in text.split(' ') if word not in stop_words])
    text = " ".join(stemmer.stem(word) for word in text.split(' '))

    return text


# Load pickle files
tf_idfvectorizer = pickle.load(open('../Models/tf_idfvectorizer.pkl', 'rb'))
tfidf_transformer = pickle.load(open('../Models/tfidf_transformer.pkl', 'rb'))
model = pickle.load(open('../Models/mnb_model.pkl', 'rb'))

st.title("SMS Spam Dectection Classifier")

# Get Input Message
msg = st.text_area("Enter Your Message Here:")

if st.button('Predict'):

    # Clean Text 
    clean_msg = clean_text(msg)

    # Vectorized the text
    vector_msg = tf_idfvectorizer.transform([clean_msg])

    # Transform Text
    transform_msg = tf_idfvectorizer.transform([clean_msg])

    # Predict
    result = model.predict(transform_msg)[0]

    if result == 1:
        st.header("Spam")
    else:
        st.header("Not Spam")























