
# Email/SMS Message Spam Detection System

## Table of Contents
1. [Objective](#objective)
2. [Dataset](#dataset)
3. [Preprocessing](#preprocessing)
4. [Methodology](#methodology)
5. [Results](#results)
6. [Streamlit app](#streamlit-app)
7. [Installation](#installation)

## Objective
The objective of this project is to develop a system capable of classifying email and SMS messages as either spam or ham (not spam). This can help in filtering out unwanted messages and ensuring important communications are not missed.

## Dataset
The dataset used for this project is sourced from Kaggle, titled "SMS Spam Collection Dataset." It contains 5,572 labeled SMS messages. The dataset has two columns:
- `label`: Indicates whether the message is "spam" or "ham."
- `message`: The actual text content of the message.

## Preprocessing
### Exploratory Data Analysis (EDA)
1. **Message Length Analysis**:
   - Analyzed the length of the messages to gain insights into the characteristics of spam and ham messages.
   - Used statistical methods (`describe`) to understand the distribution and variation in message lengths.
   - Visualized the data with histograms, finding that spam messages tend to be shorter on average compared to ham messages.

### Data Cleaning
2. **Text Normalization**:
   - Converted all text to lowercase to ensure uniformity.
   - Removed special characters, puctuations, and URLs from the messages.
   - Removed stopwords (common words that add little value to text analysis) using the NLTK library.
   - Applied stemming using the Snowball Stemmer to reduce words to their root form, helping to standardize the vocabulary.

### Vectorization
3. **Feature Extraction**:
   - Experimented with Count Vectorizer and TF-IDF (Term Frequency-Inverse Document Frequency) Vectorizer.
   - TF-IDF Vectorizer was chosen as it performed better in capturing the importance of words in the messages.

4. **Data Transformation**:
   - Transformed the text data into numerical format using `TfidfTransformer`, making it suitable for machine learning models.

### Imbalanced Data
5. **Class Imbalance**:
   - Noted that the dataset is imbalanced, with more ham messages than spam messages.

## Methodology
1. **Algorithms Tested**:
   Compare the model performance of following classifiers to select the best model.
   - Linear Model (LogisticRegression)
   - Naive Bayes (MultinomialNB, GaussianNB, BernoulliNB)
   - Decision Trees
   - Ensembels (RandomForest, ExtraTrees, AdaBoost, GradientBoost, Bagging)
   - XGBoost
   - KNearest Neighbors
   - Support Vector Machine (SVM)

2. **Model Evaluation**:
   - Compared models based on precision and accuracy.
   - Precision and accuracy were given higher importance to reduce false positives and ensure reliable spam detection.

3. **Best Performing Model**:
   - Multinomial Naive Bayes emerged as the best-performing model with:
     - Precision Score: 1.0
     - Accuracy: 0.97

## Results
- **Confusion Matrix**: Displayed to show the true positives, true negatives, false positives, and false negatives.

## Streamlit App
A Streamlit web application was created to provide an interactive interface for the spam detection system.

**Features:**

User Input: Users can input a message to be classified.
Prediction: The app displays whether the message is spam or ham.

## Installation
To run this project, ensure you have Python installed along with the following libraries:
- pandas
- numpy
- scikit-learn
- nltk
- matplotlib
- seaborn

Install the required libraries using:
```bash
pip install pandas numpy scikit-learn nltk matplotlib
```


**Example Code**:
   Here's an example of how to use the model to predict whether a message is spam or ham:
   ```python
   from spam_detection import predict_spam

   message = "Congratulations! You've won a free ticket to Bahamas. Call now!"
   result = predict_spam(message)
   print(f'The message is: {result}')
   ```
