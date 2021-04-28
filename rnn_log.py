
# LSTM with dropout for sequence classification in the IMDB dataset
import numpy as np
import random
import sys
from keras.datasets import imdb
from keras.models import Sequential
from keras.layers import Dense
from keras.layers import LSTM
from keras.layers.embeddings import Embedding


from keras.preprocessing import sequence
from keras.preprocessing.text import text_to_word_sequence
from tensorflow.keras.mixed_precision import experimental as mixed_precision
from keras.preprocessing.text import Tokenizer
from keras.callbacks import CSVLogger
from tensorflow import convert_to_tensor







new_policy = mixed_precision.Policy('mixed_float16', loss_scale=1024)


files = list(map( lambda x : "z3logs/" + x ,open("/home/aweiss13/comp400/COMP400/z3logs/index.txt").readlines())) #list of all files

parts = list(map( lambda x : x.split("\n")[0].split("-")   , files  ))


parts = list(filter(lambda x : len(x)  == 3, parts  ))

priorties = list(map(  lambda x : int(x[1])  , parts)) #priorities

content = list(map(   lambda x : open(f"/home/aweiss13/comp400/COMP400/{x[0:len(x)-1]}").read()        , files  ))

data_points = np.array(list(zip(content, priorties))) #join them

texts = data_points[:,0]
targets = data_points[:,1]


tokenizer = Tokenizer()

tokenizer.fit_on_texts(texts)

train = tokenizer.texts_to_matrix(texts)

train = convert_to_tensor(train)
targets = convert_to_tensor(targets.astype('float32'))

max_review_length = 500
train = sequence.pad_sequences(train, maxlen=max_review_length)

np.random.seed(123)

# create the model
embedding_vector_length = 4096
model = Sequential()
model.add(Embedding(4096, embedding_vector_length, input_length=max_review_length))
model.add(LSTM(512, dropout=0.2, recurrent_dropout=0.2, return_sequences=True))
model.add(LSTM(256, dropout=0.2, recurrent_dropout=0.2, return_sequences=True))
#model.add(LSTM(128, dropout=0.2, recurrent_dropout=0.2))
model.add(Dense(16, activation='sigmoid'))
model.add(Dense(1, activation = 'relu'))
model.compile(loss='binary_crossentropy', optimizer='Adagrad', metrics=['accuracy'])


model.fit(train,targets, epochs=20, batch_size=128, validation_split= .2)
#with open("rnn_training_logging.txt", 'w') as f:
#    np.savetxt(f, model.summary() + " \n " +  History.history['val_accuracy'], delimiter= ',')
print(model.summary())



print()