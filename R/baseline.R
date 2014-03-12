train.features <- read.csv("../data/processed/train_features.csv")
test.features <- read.csv("../data/processed/test_features.csv")

train.likes <- read.csv("../data/processed/train_likes_count.csv")

train.data <- merge(train.likes, train.features, by = "post_id", all = TRUE)

train.data$likes[is.na(train.data$likes)] <- 0

linear.model <- lm(likes ~. - post_id, train.data)
summary(linear.model)

linear.predict.test <- predict(linear.model, test.features)
linear.predict.test[linear.predict.test < 0] <- 0

submission <- data.frame(post_id = test.features$post_id, predict = linear.predict.test)

dir.create("../data/submit", recursive = TRUE)

write.csv(submission, "../data/submit/baseline.csv", row.names = FALSE)
