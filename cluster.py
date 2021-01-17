import json
from sklearn.feature_extraction.text import  TfidfVectorizer
from sklearn.cluster import  KMeans
import  matplotlib.pyplot as plt

import  sklearn.decomposition

data = json.loads(open("bug_urls/transformed_data.json").read())
documents = list(map(lambda x : data[x]["body"], data))



vectorizer = TfidfVectorizer(stop_words = {'english'})
vectorized = vectorizer.fit_transform(documents)


SVD= sklearn.decomposition.TruncatedSVD(n_components = 3)

result = SVD.fit_transform(vectorized)

fig = plt.figure()
ax = plt.axes(projection = '3d')

ax.scatter3D(result[:,0], result[:,1], result[:,2] )
plt.show()




Sum_of_squared_distances = []
K = range(2,20)
for k in K:
   km = KMeans(n_clusters=k, max_iter=200, n_init=10)
   #km = km.fit(vectorized)
   km = km.fit(result)
   Sum_of_squared_distances.append(km.inertia_)

plt.plot(K, Sum_of_squared_distances, 'bx-')
plt.xlabel('k')
plt.ylabel('Sum_of_squared_distances')
plt.title('Elbow Method For Optimal k')
plt.show()




print()