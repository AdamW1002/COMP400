
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


import json





new_policy = mixed_precision.Policy('mixed_float16', loss_scale=1024)


data = json.loads(open("/home/aweiss13/comp400/COMP400/bug_urls/transformed_data.json", "r").read())

data_points = []

for k in data.keys():
    data_points.append([data[k]['body'], int(data[k]['priority'])])

random.shuffle(data_points)
data_points = np.array(list(map(lambda x : [text_to_word_sequence(x[0]), x[1]], data_points )))
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
embedding_vector_length = 512
model = Sequential()
model.add(Embedding(1000, embedding_vector_length, input_length=max_review_length))
#model.add(LSTM(512, dropout=0.2, recurrent_dropout=0.2, return_sequences=True))
model.add(LSTM(256, dropout=0.2, recurrent_dropout=0.2, return_sequences=True))
model.add(LSTM(128, dropout=0.2, recurrent_dropout=0.2))
#model.add(Dense(16, activation='sigmoid'))
model.add(Dense(1, activation = 'relu'))
model.compile(loss='binary_crossentropy', optimizer='Adagrad', metrics=['accuracy'])

History = model.fit(train,targets, epochs=20, batch_size=128, validation_split= .2)
with open("rnn_training.txt", 'w') as f:
    np.savetxt(f, model.summary() + " \n " +  History.history['val_accuracy'], delimiter= ',')
print(model.summary())



print()









quit()

# load the dataset but only keep the top n words, zero the rest
top_words = 5000
(X_train, y_train), (X_test, y_test) = imdb.load_data(num_words=top_words)
# truncate and pad input sequences
max_review_length = 500
X_train = sequence.pad_sequences(X_train, maxlen=max_review_length)
X_test = sequence.pad_sequences(X_test, maxlen=max_review_length)
# create the model
embedding_vecor_length = 32
model = Sequential()
model.add(Embedding(top_words, embedding_vecor_length, input_length=max_review_length))
model.add(LSTM(128, dropout=0.2, recurrent_dropout=0.2))
model.add(Dense(1, activation='sigmoid'))
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
print(model.summary())
model.fit(X_train, y_train, epochs=5, batch_size=128)
# Final evaluation of the model
scores = model.evaluate(X_test, y_test, verbose=0)
print("Accuracy: %.2f%%" % (scores[1]*100))