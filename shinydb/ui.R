ui <- navbarPage(title = "TwiBot",
                 header = tagList(
                   useShinydashboard()),
                 #theme = bslib::bs_theme(version = 3,bootswatch = "flatly"),
                 
                 # Page 1 Profiler ============================== 
                 tabPanel("Bot Profiler",
                          fluidPage(
                            fluidRow(
                              br(),
                              div(align = "center",img(src = "twtlg.png",height = 90, width = 90)),
                              div(h1("Twitter-Bot Detection"),align="center"),
                              br(),
                              div("Check the activity of Twitter account to detect if the account is bot or not." ,tags$br(),"The Bot detection using machine learning provided by",
                                  tags$a(href = "https://botometer.osome.iu.edu/","Botometer",target = "_blank"),
                                  align = "center",style = "font-size: 130%;"),
                              br(),
                              div(textInputAddon(inputId = "username_",label = "",addon = icon("at"),
                                                 placeholder = "Insert Twitter username here",width = "35%"),
                                  align = "center"),
                              br(),
                              div(prettyCheckbox(
                                inputId = "agreed",
                                label = "By clicking detect you agree to our terms and condition",
                                icon = icon("check"),
                                status = "success",
                                animation = "smooth"),align = "center")
                              # box(width = 6,title = "Application Terms",collapsible = T,collapsed = T,
                              #     status = "info",solidHeader = T,closable = T,
                              #     p("- These terms apply to all visitors, users, and others who access or use the service"),
                              #     p(strong("- Our service are provided for information and entertainment purposes only and for no other purpose.")),
                              #     p("- We make no claims or representations in relation to the emotional, health or commercial benefits of using our Products and the information provided on the Website is no substitute for professional medical or psychiatric advice where applicable."),
                              #     p("- You must be over the age of 13 years (or above the relevant age of consent in your country) to use the service and most importantly the Twitter itself."),
                              #     p("- By accessing this service you agree to be bound by these terms. If you disagree with any part of these terms but do the predict anyway then probably you are not reading this but that's ok since i can't do anything"),
                              #     p("- Our service should not be regarded as or relied upon as being a comprehensive opinion or assessment concerning your psychological well-being."),
                              #     p("- By clicking 'Predict!' you are agreed to help to improve this app by let us save your Twitter data and the personality results"),
                              #     p("- Your Twitter data will be used for this app model improvement only and not to be shared publicly")
                              # ),
                              # box(width = 6,title = "Detect Condition",collapsible = T,collapsed = T,
                              #     status = "info",solidHeader = T,closable = T,
                              #     p("The Twitter account need to meet this criteria for the best experience:"),
                              #     p("- The tweets must be written in english"),
                              #     p("- The Twitter account need to be set in public"),
                              #     p("- The Twitter account need to have at least 300 tweets"),
                              #     p("- The big 5 personality traits and Myer-Briggs Type Indicator (also known as MBTI) result may not accurate for you since the real test is using creadibile research and mostly not by text")
                              # )
                            ),
                            br(),
                            fluidRow(
                              div(actionBttn(inputId = "detector",label = "Detect!",
                                             style = "fill",color = "primary",icon = icon("search")),align = "center")
                            ),
                            tags$hr(),
                            uiOutput(outputId = "searched_u")
                            
                            
                          )
                 ),
                 
                 
                 # Page 2 Network ============================== 
                 tabPanel("Network",
                          fluidRow(
                            div(h1("Coming Soon!",align = "center"))
                          )),
                 
                 
                 # Page 3 About ============================== 
                 tabPanel("About",
                          fluidRow(
                            div(h1("Coming Soon!",align = "center"))
                          )),
                 
                 # Extra page More ============================== 
                 navbarMenu("More",
                            tabPanel(tags$a(href = "https://jojoecp.shinyapps.io/Twitter-text_personality_prediction/",
                                            "Twitter Personality Prediction")),
                            tabPanel("Coming Soon!"))
)


