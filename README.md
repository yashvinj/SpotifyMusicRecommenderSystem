# SpotifyMusicRecommenderSystem
Spotify Recommender System based on current track popularity and genre

## Purpose 
Classify and predict a song's genre and popularity and build a user-user and item-item collaborative filtering systems

## Objectives
1. Tagged genre of unlabeled tracks using decision tree models
2. Classified songs based on popularity by analyzing music trends
3. Constructed a collaborative filtering recommender system to suggest similar songs

## Methodology
There was a bias in the proportion of songs that were classified as hits
when grouped by genre. Songs classified as pop made up 40% of the dataset while
EDM songs were only about 3.7%. The pop genre was clearly an outlier in the dataset
in terms of the frequency of songs that were classified as hits.  To address
this issue, a sampling technique was used where 500 songs are chosen from each genre
at random. This helped remove the genre bias and get a large enough set of songs
for each genre to be suitable for training. We will use this 3000 song set for our
model building and analysis for popularity classification and genre classification. This
3000 song subset now has each genre equally represented.

The feature selection method we used for
this problem was recursive feature elimination (RFE). It is a backwards selection
method that functions by recursively removing features and building models on those
that remain. It uses the cross-validated model accuracy to identify which combination
of features contribute the most to predicting the target attribute.Here, the RFE
procedure suggests that using the top 7 features in the dataset.

## Results
1. Popularity classification: Random forest, ~76% accurate
2. Genre classification: Random forest, ~95% accurate
3. Current day popularity: Multiple regression, R2 ~0.33
4. UBCF’s accuracy is higher than that of IBCF
