count.likes <- function(input.location, output.location) {
  # ===============================================
  # Part I: preparation for reading a big file
  # ===============================================
  merge.tables <- function(a, b){
    n <- intersect(names(a), names(b)) 
    res <- c(a[!(names(a) %in% n)], b[!(names(b) %in% n)], a[n] + b[n])
    res[order(names(res))] # sort the results
  }
  
  like.list <- list()
  read.size <- 500000
  # ===============================================
  # Part II: read likes from a file in chunks
  # ===============================================
  
  like.connection <- file(input.location, open = "r")
  
  likes <- read.table(like.connection, header = FALSE, sep = "\t", nrows = read.size)
  like.list <- table(likes[,2])
  
  while( nrow(likes) == read.size ) {
    likes <- read.csv(like.connection, header = FALSE, sep = "\t", nrows = read.size)	
    current.table <- table(likes[,2]) 	
    like.list <- merge.tables(like.list, current.table )
  }
  
  close(like.connection)
  
  # ===============================================
  # Part III: save likes to a new file
  # ===============================================
  likes.data <- data.frame(post_id = names(like.list), likes = like.list)
  
  write.csv(likes.data, output.location, row.names = FALSE)
 
}

process.content <- function(input, output) {
  data.src <- readLines(input, n = -1L, ok = TRUE, warn = TRUE, encoding = "unknown")
  data.split <- strsplit(data.src, "\t")
  data.len <- sapply(data.split, length)
  bad.ones <- which(data.len != 4)
  data.split <- strsplit(data.src[-bad.ones], "\t")
  data.df <- data.frame(do.call(rbind, lapply(data.split, rbind)), stringsAsFactors = FALSE)
  colnames(data.df) <- c("group_id", "post_id", "timestamp", "text")
  data.df$group_id <- as.numeric(data.df$group_id)
  data.df$post_id <- as.numeric(data.df$post_id)
  data.df$timestamp <- as.numeric(data.df$timestamp)
  write.csv(data.df, file=output, row.names=FALSE)
  
}

dir.create("../data/processed", recursive=TRUE)
process.content("../data/src/train_content.csv", "../data/processed/train_content.csv")
process.content("../data/src/test_content.csv", "../data/processed/test_content.csv")
count.likes("../data/src/train_likes.csv", "../data/processed/train_likes_count.csv")
