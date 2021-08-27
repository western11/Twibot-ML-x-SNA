library(shiny)
library(shinyWidgets)
library(shinydashboardPlus)
library(shinyjs)
library(shinybusy)
library(flexdashboard)
library(bslib)
library(dplyr)
library(stringr)
library(httr)
library(lubridate)
library(scales)
library(DT)
library(highcharter)
library(echarts4r)

# api endpoint

users_url = "https://api.twitter.com/1.1/users/show.json?screen_name="
statuses_url = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name="
search_url = "https://api.twitter.com/1.1/search/tweets.json?q=%40"
opts = "&count=200&include_rts=true"
opts2 = "&count=100&include_rts=true"
bearer <- "Bearer xxxx"


boter <- function(x){
  # value caller
  # API call to get user
  userdata <-  GET(paste0(users_url,x,opts), 
                 add_headers(Authorization = bearer))
  
  # API call to get tweets
  tweets <-  GET(paste0(statuses_url,x,opts), 
               add_headers(Authorization = bearer))
  
  # API call to get mentions
  mentions <-  GET(paste0(search_url,x,opts2), 
                 add_headers(Authorization = bearer))
  
  # convert to list
  body = list(
    timeline = content(tweets, type="application/json"),
    mentions = content(mentions, type="application/json"),
    user = content(userdata, type="application/json")
  )
  
  body_json <-  RJSONIO::toJSON(body, auto_unbox = T, pretty = T)
  
  # Make the API request
  result <- POST(url = "https://botometer-pro.p.rapidapi.com/4/check_account",
                 encode = "json",
                 add_headers(`x-rapidapi-key` = "xxxx",
                             `x-rapidapi-host` = "botometer-pro.p.rapidapi.com"),
                 body = body_json)
  
  result <- content(result, as = "parsed")
  
  return(result)
}




source("ui.R")
source("server.R")

shinyApp(ui,server)