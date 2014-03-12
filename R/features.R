basic.text.statistics <- function(text.data){  
  n_chars <- nchar(text.data)
  n_words <- sapply(gregexpr("[\\W ]+", text.data), length) 
  avg_word <- n_chars/n_words
  data.frame(n_chars=n_chars, n_words=n_words, avg_word=avg_word)
}

extract.features <- function(input, output) {
  data <- read.csv(input, stringsAsFactors = FALSE, encoding = "UTF-8", strip.white = TRUE)
  features <- basic.text.statistics(data$text)
  training.data.features <- cbind(data[,-4], features)
  write.csv(training.data.features, output, row.names = FALSE)  
}

extract.features("../data/processed/train_content.csv", "../data/processed/train_features.csv")
extract.features("../data/processed/test_content.csv", "../data/processed/test_features.csv")
