
server <- function(input,output,session){
  
  rec_text <- eventReactive(input$detector,{
    input$username_
  })
  
  observeEvent(input$detector,{
    if(input$agreed == FALSE){
      showModal(modalDialog("Please read and check the terms & condition first"))
    } else{
      
      show_modal_spinner(spin = "fading-circle",color = "#2faef7",text = "Please Wait")
      
      valuebot <- boter(rec_text())
      
      bot_stat <- reactive({
        valuebot$display_scores %>% 
          unlist() %>% as.data.frame() %>% 
          setNames("value") %>% 
          mutate(variable = rownames(.)) %>% 
          mutate(cat = ifelse(str_detect(variable,"english"),"english","universal")) %>% 
          mutate(varname = str_replace_all(variable,paste(cat,".",sep = ""),"")) %>% 
          select(varname, cat, value) %>% 
          `rownames<-`(NULL)
      })
      
      output$botgg <- renderGauge({
        gauge(value = bot_stat() %>% filter(cat == input$bot_lg) %>%
                filter(varname == "overall") %>% pull(value),
              min = 0,max = 5,
              sectors = gaugeSectors(success = c(0.1, 2),
                                     warning = c(2, 3.5),
                                     danger = c(3.5, 4)))
      })
      
      output$searched_u <- renderUI({
        
        # Profil box ========
        crt <- valuebot$user$user_data$created_at %>% 
          str_split(" ") %>% unlist()
        
        crt <- paste(crt[2],crt[3],crt[6],sep="-") %>% 
          mdy()
        
        lasttw <- valuebot$user$user_data$status$created_at %>% 
          str_split(pattern = " ") %>% unlist()
        
        lasttw <- paste(lasttw[2],lasttw[3],lasttw[6],lasttw[4]) %>% 
          mdy_hms()
        
        descx <- ifelse(is.null(valuebot$user$user_data$description),"",valuebot$user$user_data$description)
        lctx <- ifelse(is.null(valuebot$user$user_data$location),"",valuebot$user$user_data$location)
        urlx <- ifelse(is.null(valuebot$user$user_data$url),"",valuebot$user$user_data$url)
        
        
        fluidRow(
          userBox(width = 4,
                  title = userDescription(title = valuebot$user$user_data$screen_name,
                                          subtitle = paste("Followings: ",comma(valuebot$user$user_data$friends_count,big.mark = "."),"  Followers: ",comma(valuebot$user$user_data$followers_count,big.mark = "."),sep = ""),
                                          image = valuebot$user$user_data$profile_image_url_https,
                                          backgroundImage = valuebot$user$user_data$profile_banner_url
                  ),status = "info",headerBorder = T,collapsible = F,closable = F,footer = paste("Searched at: ",ymd_hms(Sys.time())),
                  br(),
                  tags$p(tags$b("Display Name: "),valuebot$user$user_data$name),
                  tags$p(tags$b("Description: "),descx),
                  tags$p(tags$b("Location: "),lctx),
                  tags$p(tags$b("URL: "),tags$a(href=urlx,urlx)),
                  tags$p(tags$b("Date Joined: "),crt),
                  tags$p(tags$b("Most Recent Post: "),lasttw),
                  tags$p(tags$b("Most Tweet Language: "),valuebot$user$majority_lang),
                  tags$p(tags$b("Total Tweets: "),comma(valuebot$user$user_data$statuses_count,big.mark = ".")),
                  tags$p(tags$b("Total Likes: "),comma(valuebot$user$user_data$favourites_count,big.mark="."))
          ),
          
          # profil bot status =====
          
          box(width = 8,
              title = paste(valuebot$user$user_data$screen_name,"Bot Status"),
              status = "info",solidHeader = F,collapsible = F,
              sidebar = boxSidebar(id = "boxsdb1",startOpen = F,width = 25,
                                   selectInput("bot_lg",label = "Select Language",
                                               choices = c("english","universal"),selected = "english")
              ),
              
              gaugeOutput("botgg")
          )
          
        )
        
        
        
        
        
      })
      
      
      
      
      
      
      
      remove_modal_spinner(session = getDefaultReactiveDomain())
    }
  })
  
  
}

