genre <- read_csv("genre_music.csv") 



set.seed(1) 

testSample <- stratified(dataspot, "genre", 500, select = list(genre = c("rap", "pop","r&b", "edm","latin", "rock"))) 

testSample 

dataspot <- testSample 





sum_acousticness <- sum(dataspot$acousticness) 

sum_danceability <- sum(dataspot$danceability) 

sum_duration_s <- sum(dataspot$duration_s) 

sum_energy <- sum(dataspot$energy)  

sum_instrumentalness <- sum(dataspot$instrumentalness) 

sum_key <- sum(dataspot$key) 

sum_liveness <- sum(dataspot$liveness)  

sum_loudness <- sum(dataspot$loudness) 

sum_mode <- sum(dataspot$mode) 

sum_speechiness <- sum(dataspot$speechiness) 

sum_tempo <- sum(dataspot$tempo) 

sum_time_signature <- sum(dataspot$time_signature) 

sum_valence <- sum(dataspot$valence)  

dataspot$acousticness <- dataspot$acousticness/sum_acousticness 

dataspot$danceability <- dataspot$danceability/sum_danceability 

dataspot$duration_s <- dataspot$duration_s/sum_duration_s 

dataspot$energy <- dataspot$energy/sum_energy 

dataspot$instrumentalness <- dataspot$instrumentalness/sum_instrumentalness 

dataspot$key <- dataspot$key/sum_key 

dataspot$liveness <- dataspot$liveness/sum_liveness 

dataspot$loudness <- dataspot$loudness/sum_loudness 

dataspot$mode <- dataspot$mode/sum_mode 

dataspot$speechiness <- dataspot$speechiness/sum_speechiness 

dataspot$tempo <- dataspot$tempo/sum_tempo 

dataspot$time_signature <- dataspot$time_signature/sum_time_signature 

dataspot$valence <- dataspot$valence/sum_valence 

write.csv(dataspot, file = "knn_songs.csv") 



song_factors <- dataspot %>%  
  
  select(3:18) 

head(song_factors) 



new_songs_cor <- round(cor(song_factors), 1) 

songs_norm <- subset(song_factors,select=c("popularity","danceability","speechiness","valence")) 

data.samples <- sample(1:nrow(songs_norm),nrow(songs_norm) * 0.7, replace = FALSE) 

training.data <- songs_norm[data.samples, ] 

test.data <- songs_norm[-data.samples, ] 



#KNN 

#On training data 

training.data$popularity <- as.factor(training.data$popularity) 

classifier <- IBk(popularity ~., data = training.data, control = Weka_control(K = 2, X = TRUE)) 

evaluate_Weka_classifier(classifier, numFolds = 10) 

table(training.data$popularity, classifier$predictions) 

confusionMatrix(classifier$predictions, training.data$popularity) 



#On testing data 

test.data$popularity <- as.factor(test.data$popularity) 

classifier <- IBk(popularity ~., data = test.data, control = Weka_control(K = 2, X = TRUE)) 

evaluate_Weka_classifier(classifier, numFolds = 10) 

table(test.data$popularity, classifier$predictions) 

confusionMatrix(classifier$predictions, test.data$popularity) 







#On total data set 

songs_norm$popularity <- as.factor(songs_norm$popularity) 

classifier <- IBk(popularity ~., data = songs_norm, control = Weka_control(K = 2, X = TRUE)) 

evaluate_Weka_classifier(classifier, numFolds = 10) 

table(songs_norm$popularity, classifier$predictions) 

confusionMatrix(classifier$predictions, songs_norm$popularity) 