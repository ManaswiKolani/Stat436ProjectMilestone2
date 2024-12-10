library(shiny)
library(tidyverse)
library(viridisLite)

# Load the dataset
data <- read_csv("./data.csv")

# UI
ui <- fluidPage(
  titlePanel("ESG Score Industry Summary"),
  
  mainPanel(
    wellPanel(
      h4("About ESG Investing"),
      p("Environmental, Social, and Governance (ESG) criteria are a set of standards for a company's operations that socially conscious investors use to screen potential investments. Companies with high ESG scores are often seen as less risky and more sustainable investments."),
      p("ESG ratings are expressed using letter grades, which provide a quick reference to the relative performance of companies in these areas. The grading system generally follows this structure:"),
      tags$ul(
        tags$li("A: Excellent"),
        tags$li("BB: Medium-High"),
        tags$li("B: Medium"),
        tags$li("BBB: High"),
        tags$li("D: Poor"),
        tags$li("DD: Very Poor"),
        tags$li("CCC: Very Low"),
        tags$li("C: Low")
      ),
      p("The scores are numeric values that provide a more granular understanding of a company's ESG performance. For instance, a company with a total ESG score of 1500 demonstrates a significantly better performance compared to one with a score of 600. Higher scores indicate better practices in environmental, social, and governance factors."),
      selectInput("industry_input", "Select Industry:", 
                  choices = unique(data$industry), selected = unique(data$industry)[1])
    ),
    
    wellPanel(
      fluidRow(
        column(6, 
               plotOutput("industrySummaryPlot"),
               tags$ul(
                 tags$li(style = "color: green4;", "A"),
                 tags$li(style = "color: green3;", "BBB"),
                 tags$li(style = "color: yellow3;", "BB"),
                 tags$li(style = "color: orange;", "B")
               )), 
        column(6, 
               plotOutput("esgHeatmapPlot")      
        )),
      verbatimTextOutput("statisticsText")),
    
    tableOutput("comparisonTable")
  )
)

# Server
server <- function(input, output, session) {
  
  # Summary statistics output
  output$statisticsText <- renderPrint({
    filtered_data <- subset(data, industry == input$industry_input)
    
    highest_score <- filtered_data[which.max(filtered_data$total_score), ]
    lowest_score <- filtered_data[which.min(filtered_data$total_score), ]
    
    cat("Statistics for Industry:", input$industry_input, "\n")
    cat("Company with Highest Score:\n")
    cat("Name:", highest_score$name, "\n")
    cat("Total ESG Score:", highest_score$total_score, "\n")
    cat("Grade:", highest_score$total_grade, "\n\n")
    
    cat("Company with Lowest Score:\n")
    cat("Name:", lowest_score$name, "\n")
    cat("Total ESG Score:", lowest_score$total_score, "\n")
    cat("Grade:", lowest_score$total_grade, "\n")
  })
  
  # Table output
  output$comparisonTable <- renderTable({
    filtered_data <- subset(data, industry == input$industry_input)
    filtered_data %>%
      select(name, total_score, total_grade, industry) %>%
      arrange(desc(total_score))
  })
  
  # Bar plot output
  output$industrySummaryPlot <- renderPlot({
    filtered_data <- subset(data, industry == input$industry_input) 
    
    filtered_data <- filtered_data %>%
      mutate(grade_color = case_when(
        total_grade == "A" ~ "green4",
        total_grade == "BBB" ~ "green3",
        total_grade == "BB" ~ "yellow3",
        total_grade == "B" ~ "orange",
        TRUE ~ "grey"
      ))
    
    ggplot(filtered_data, aes(x = reorder(name, -total_score), y = total_score, fill = grade_color)) +
      geom_bar(stat = "identity") +
      scale_fill_identity() +
      labs(title = paste("ESG Scores of Companies in", input$industry_input), 
           x = "Company", 
           y = "ESG Score",
           caption = "Bar colors represent the total_grade: A (green), BBB (light green), BB (yellow), B (orange)") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Heatmap output
  output$esgHeatmapPlot <- renderPlot({
    heatmap_data <- data %>%
      filter(industry == input$industry_input) %>%
      select(name, environment_score, social_score, governance_score) %>%
      pivot_longer(cols = c(environment_score, social_score, governance_score), 
                   names_to = "criteria", values_to = "score") %>%
      mutate(name = reorder(name, score, mean))
    
    ggplot(heatmap_data, aes(x = criteria, y = name, fill = score)) +
      geom_tile() +
      scale_fill_viridis_c() +
      labs(title = paste("ESG Scores Heatmap for", input$industry_input), 
           x = "ESG Criteria", y = "Company",
           caption = "Heatmap displays the scores for Environmental, Social, and Governance criteria.") +
      theme_minimal() +
      theme(axis.text.y = element_text(size = 8))
  })
}

# Run the app
shinyApp(ui = ui, server = server)
