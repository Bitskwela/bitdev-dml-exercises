[
  {
    "id": 1,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Writing explicit if-else rules for every possible input" },
      { "id": "b", "text": "A subset of AI where systems learn patterns from data without being explicitly programmed for every case" },
      { "id": "c", "text": "A type of computer hardware that processes data faster" },
      { "id": "d", "text": "A database system for storing large volumes of training data" }
    ],
    "question": "Machine Learning is best defined as:"
  },
  {
    "id": 2,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Supervised, Unsupervised, and Reinforcement Learning" },
      { "id": "b", "text": "Classification, Regression, and Clustering" },
      { "id": "c", "text": "Training, Validation, and Testing" },
      { "id": "d", "text": "Linear, Logistic, and Neural Learning" }
    ],
    "question": "Which correctly lists the three main categories of Machine Learning?"
  },
  {
    "id": 3,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Unsupervised learning requires labeled training data (targets/labels) to find patterns."
  },
  {
    "id": 4,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Supervised learning requires a dataset where each example has both input features and a correct output label."
  },
  {
    "id": 5,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The most complex algorithm available for the problem" },
      { "id": "b", "text": "A simple rule like predicting the mean or most common class — the 'do nothing smart' benchmark" },
      { "id": "c", "text": "The output of the best-known published algorithm for the task" },
      { "id": "d", "text": "A model with no parameters that always outputs zero" }
    ],
    "question": "What is a baseline model used for in machine learning?"
  },
  {
    "id": 6,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "A classification model predicts a discrete class label (such as 'busy' or 'not busy') rather than a continuous number."
  },
  {
    "id": 7,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The output column the model is trained to predict" },
      { "id": "b", "text": "The rows of the dataset, each representing one observation" },
      { "id": "c", "text": "The input columns used as evidence for making predictions" },
      { "id": "d", "text": "The evaluation metrics used to score the model after training" }
    ],
    "question": "In a machine learning dataset, 'features' are:"
  },
  {
    "id": 8,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "In ML terminology, the 'label' or 'target' is the column the model is trained to predict."
  },
  {
    "id": 9,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "To train the model on the most difficult examples" },
      { "id": "b", "text": "To tune hyperparameters before final training" },
      { "id": "c", "text": "To give a final, unbiased estimate of model performance on unseen data" },
      { "id": "d", "text": "To validate that the CSV data loaded correctly" }
    ],
    "question": "What is the purpose of a held-out test set?"
  },
  {
    "id": 10,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "It is acceptable to tune hyperparameters directly against the test set as long as you only do it once."
  },
  {
    "id": 11,
    "type": "FIB",
    "answer": "pd",
    "points": 1,
    "question": "The standard alias used when importing the pandas library is `import pandas as ______`."
  },
  {
    "id": 12,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Writing model weights to a file on disk" },
      { "id": "b", "text": "Wrapping an inline CSV string so it can be read like a file by pandas" },
      { "id": "c", "text": "Downloading datasets from the internet at runtime" },
      { "id": "d", "text": "Encoding text as bytes for network transmission" }
    ],
    "question": "What is `io.StringIO` used for in sandbox-safe ML code?"
  },
  {
    "id": 13,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "`np.dot(X, y)`" },
      { "id": "b", "text": "`np.linalg.solve(X.T @ X, X.T @ y)`" },
      { "id": "c", "text": "`np.gradient(X, y)`" },
      { "id": "d", "text": "`np.polyfit(X, y, 1)`" }
    ],
    "question": "The closed-form normal equation for linear regression is computed in numpy as:"
  },
  {
    "id": 14,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "The from-scratch LinearRegressionScratch in this course uses gradient descent (iterative updates) to find its weights."
  },
  {
    "id": 15,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The square root of the average squared error between predictions and actuals" },
      { "id": "b", "text": "The average of the absolute differences between predicted and actual values" },
      { "id": "c", "text": "The maximum single-prediction error across the test set" },
      { "id": "d", "text": "The sum of correct predictions divided by total predictions" }
    ],
    "question": "Mean Absolute Error (MAE) is calculated as:"
  },
  {
    "id": 16,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The mean and standard deviation of all predictions" },
      { "id": "b", "text": "A table of True Positives, False Positives, True Negatives, and False Negatives" },
      { "id": "c", "text": "Training accuracy and test accuracy displayed side by side" },
      { "id": "d", "text": "The feature importance ranking for each input column" }
    ],
    "question": "A confusion matrix for binary classification contains:"
  },
  {
    "id": 17,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Underfitting — the model is too simple to capture the signal" },
      { "id": "b", "text": "Well-calibrated — a gap between train and test is always expected" },
      { "id": "c", "text": "Overfitting — the model memorized training data and fails to generalize" },
      { "id": "d", "text": "A regression model behaving normally" }
    ],
    "question": "A model that scores 99% on training data but only 60% on test data is exhibiting:"
  },
  {
    "id": 18,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Increasing a model's complexity (for example, adding more tree depth) always improves test set performance."
  },
  {
    "id": 19,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Compresses numerical columns into a smaller value range" },
      { "id": "b", "text": "Converts a categorical text column into binary (0/1) indicator columns — one per category" },
      { "id": "c", "text": "Normalizes numerical features to have mean 0 and standard deviation 1" },
      { "id": "d", "text": "Removes duplicate rows from the dataset" }
    ],
    "question": "One-hot encoding is used to:"
  },
  {
    "id": 20,
    "type": "FIB",
    "answer": "get_dummies",
    "points": 1,
    "question": "The pandas function that generates one-hot encoded columns from a categorical Series is `pd.______`."
  },
  {
    "id": 21,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "-1 to 1" },
      { "id": "b", "text": "0 to 1" },
      { "id": "c", "text": "0 to infinity" },
      { "id": "d", "text": "-infinity to infinity" }
    ],
    "question": "The sigmoid function maps any real number to which output range?"
  },
  {
    "id": 22,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A continuous numeric value such as tomorrow's revenue in pesos" },
      { "id": "b", "text": "The probability that an input belongs to a particular class" },
      { "id": "c", "text": "The next value in a time series" },
      { "id": "d", "text": "The number of clusters that exist in the dataset" }
    ],
    "question": "Logistic regression is used to predict:"
  },
  {
    "id": 23,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The depth of the tree at a given node" },
      { "id": "b", "text": "How mixed the class labels are in a node — 0 means all one class, 0.5 means a 50/50 split" },
      { "id": "c", "text": "The number of training examples that reached a node" },
      { "id": "d", "text": "The prediction accuracy at a leaf node" }
    ],
    "question": "In a decision tree, Gini impurity measures:"
  },
  {
    "id": 24,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "A decision tree trained without any depth limit will tend to memorize the training data (overfit)."
  },
  {
    "id": 25,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Sampling the test set to create a separate validation split" },
      { "id": "b", "text": "Selecting a random subset of features to consider at each split" },
      { "id": "c", "text": "Drawing N samples with replacement from N training rows to create each tree's dataset" },
      { "id": "d", "text": "Downloading additional training data from the internet" }
    ],
    "question": "Bootstrap sampling in a Random Forest means:"
  },
  {
    "id": 26,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Each tree in the forest is deeper than a single standalone tree" },
      { "id": "b", "text": "The uncorrelated errors of individual trees average out, reducing overall variance" },
      { "id": "c", "text": "Random Forests use gradient descent while single decision trees do not" },
      { "id": "d", "text": "Random Forests automatically remove outliers before training" }
    ],
    "question": "Why does a Random Forest often outperform a single deep decision tree?"
  },
  {
    "id": 27,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Supervised classification — it requires class labels for each row" },
      { "id": "b", "text": "Supervised regression — it predicts a continuous numeric value" },
      { "id": "c", "text": "Unsupervised clustering — it finds groups in data with no label column needed" },
      { "id": "d", "text": "Reinforcement learning — it learns from an environment reward signal" }
    ],
    "question": "K-Means belongs to which type of machine learning?"
  },
  {
    "id": 28,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "K-Means clustering requires a labeled target column in the training data."
  },
  {
    "id": 29,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "`np.linalg.inv`" },
      { "id": "b", "text": "`np.linalg.det`" },
      { "id": "c", "text": "`np.linalg.solve`" },
      { "id": "d", "text": "`np.linalg.svd`" }
    ],
    "question": "Which numpy function does the from-scratch PCA implementation rely on to decompose the mean-centered data matrix?"
  },
  {
    "id": 30,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Principal components are assigned randomly at each run" },
      { "id": "b", "text": "PC1 captures the most variance, PC2 the second most, and so on in decreasing order" },
      { "id": "c", "text": "Principal components are ordered alphabetically by the feature they correlate with most" },
      { "id": "d", "text": "The last principal component always captures the most variance" }
    ],
    "question": "How are principal components ordered in PCA output?"
  },
  {
    "id": 31,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "The weights (w) in a linear regression model — learned during training" },
      { "id": "b", "text": "The decision tree's split thresholds — determined by the data during training" },
      { "id": "c", "text": "`max_depth` in a DecisionTreeScratch — set by the user before training begins" },
      { "id": "d", "text": "The intercept (bias) term in logistic regression — learned during training" }
    ],
    "question": "Which of the following is a hyperparameter (set before training) rather than a parameter (learned during training)?"
  },
  {
    "id": 32,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It is too computationally expensive and slow" },
      { "id": "b", "text": "It leaks test-set information into modeling decisions, making the final accuracy score optimistically biased" },
      { "id": "c", "text": "Hyperparameters cannot be evaluated using classification metrics" },
      { "id": "d", "text": "The test set is always too small to provide meaningful hyperparameter signals" }
    ],
    "question": "Why should you never tune hyperparameters against the test set?"
  },
  {
    "id": 33,
    "type": "FIB",
    "answer": "5",
    "points": 1,
    "question": "The industry-default value of K in K-fold cross validation is ______."
  },
  {
    "id": 34,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It is faster to run than a single train/test split" },
      { "id": "b", "text": "It produces a mean accuracy and standard deviation, giving a more reliable estimate of generalization" },
      { "id": "c", "text": "It eliminates the need for a separate held-out test set entirely" },
      { "id": "d", "text": "It automatically selects the best hyperparameters without a grid search" }
    ],
    "question": "What is the main advantage of K-fold cross validation over a single train/test split?"
  },
  {
    "id": 35,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "It encrypts the test data so the preprocessing step cannot read it" },
      { "id": "b", "text": "It fits preprocessing steps (e.g., scaler) only on training data, then applies the same fitted transform to both sets" },
      { "id": "c", "text": "It removes all preprocessing steps to avoid any possibility of contamination" },
      { "id": "d", "text": "It uses the test set's mean and std to normalize both sets consistently" }
    ],
    "question": "How does an ML pipeline prevent data leakage during preprocessing?"
  },
  {
    "id": 36,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A sequence of word embeddings that preserves sentence order" },
      { "id": "b", "text": "A vector of word counts for each document, with word order discarded" },
      { "id": "c", "text": "A compressed binary encoding of the full document" },
      { "id": "d", "text": "A translation of the text into a sequence of integer tokens" }
    ],
    "question": "Bag-of-Words (BOW) text representation produces:"
  },
  {
    "id": 37,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "TF-IDF down-weights words that appear in many documents (common words) and up-weights rare, informative words."
  },
  {
    "id": 38,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A `.pkl` file saved to the current working directory" },
      { "id": "b", "text": "A `bytes` object stored in memory — no disk write required" },
      { "id": "c", "text": "A JSON string representation of the model's weights" },
      { "id": "d", "text": "A compressed zip archive of all model parameters" }
    ],
    "question": "What does `pickle.dumps(model)` return?"
  },
  {
    "id": 39,
    "type": "MCQ",
    "answer": "d",
    "points": 1,
    "choices": [
      { "id": "a", "text": "At the very beginning of the script to verify the data loaded correctly" },
      { "id": "b", "text": "During each hyperparameter tuning iteration to pick the best setting" },
      { "id": "c", "text": "Inside every cross-validation fold alongside training" },
      { "id": "d", "text": "Exactly once at the end, after model selection and hyperparameter tuning are complete" }
    ],
    "question": "In a real-world ML workflow script, when should the held-out test set be evaluated?"
  },
  {
    "id": 40,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A deep neural network — more layers means more accuracy on any data" },
      { "id": "b", "text": "Classical ML such as logistic regression or random forest — tabular + small data is ML's home turf" },
      { "id": "c", "text": "A large language model (GPT) — LLMs generalize to any task type" },
      { "id": "d", "text": "K-Means clustering — it works without any labels and is always the safest default" }
    ],
    "question": "For a 30-row tabular dataset, which is the recommended starting algorithm choice?"
  }
]
