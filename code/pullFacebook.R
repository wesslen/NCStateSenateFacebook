library(Rfacebook)

## To get access to the Facebook API, you need an OAuth code.
## You can get yours going to the following URL:

## https://developers.facebook.com/tools/explorer

## Once you're there:
## 1) Click on "Get Access Token"
## 2) Copy the long code ("Access Token") and paste it here:

fb_oauth <- "xxx"

userData <- read.csv("./data/FacebookUserData.csv", stringsAsFactors = F)

users <- userData$id

pageData <- pageData[0,]

for (i in users){
  pageData <- rbind(getPage(i, token=fb_oauth, n = 2500),pageData)
}

write.csv(pageData, file = "facebookPosts.csv", row.names = F)

#likes <- likes[0,]
#comments <- comments[0,]

#berger <- subset(model, from_id %in% c("56158390063","245711905631405"))

for (i in model$id[1:4000]){
  tmp <- getPost(i, token=fb_oauth, n=13000)
  

  repl <- tmp$likes
  
  if(nrow(repl)!=0){
  repl$ord_id <- i
  likes <- rbind(repl,likes)
  }
  
  crepl <- tmp$comments
  
  if(nrow(crepl)!=0){
    crepl$org_id <- i
    comments <- rbind(crepl,comments)
  } 
  
}


# This is how you can view those comments:
# comments <- post$comments
# head(comments)

#write.table(comments, file = "comments.tsv", sep = "/t", row.names = F)
#write.csv(likes, file = "likes.csv", row.names = F)

# likes2 <- merge(likes[1:50000,],model[,c("id","Party")], x.by = "ord_id", y.by = "id")


