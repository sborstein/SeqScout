## app.R ##
library(shinydashboard)
library(rotl)
library(rentrez)
library(devtools)
#devtools::install_github("phylotastic/rphylotastic")
library(rphylotastic)


ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 250), textOutput("taxon")),
      
      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50),
        textInput("taxon", "Enter Name of taxon")
      )
    )
  )
)

# 
# ui <- dashboardPage(
#   dashboardHeader(title = "Basic dashboard"),
#   dashboardSidebar(),
#   dashboardBody(
#     # Boxes need to be put in a row (or column)
#     fluidRow(
#       box(
#         title = "Controls",
#         #textInput("taxon", "Enter Name of taxon"),
#       )
#     )
#   )
# )

server <- function(input, output) {
  
  # stuff to get info on opentree
  # input$taxon <- "Homo"
  #reactive({clade.info <- tnrs_match_names(input$taxon)})
  clade.name <- reactive({
    clade.info <- tnrs_match_names(input$taxon)
    clade.name <- clade.info$unique_name[1]
    })
  # clade.name <- clade.info$unique_name[1]
  # id <- clade.info$ott_id[1]
  # node.info <- tol_node_info(id)
  # relevant.studies <- studies_find_trees(property="ot:ottTaxonName", value=clade.name)
  # tree.info <- data.frame()
  # all.trees <- list_trees(relevant.studies)
  # for (study.index in sequence(nrow(relevant.studies))) {
  #   study.info <- get_publication(get_study_meta(relevant.studies$study_ids[study.index]))
  #   for (tree.index in sequence(length(all.trees[study.index]))) {
  #     phy <- NULL
  #     try(phy <- get_study_tree(study_id=relevant.studies$study_ids[study.index], tree_id = gsub('tree/', '',all.trees[[study.index]][tree.index])))
  #     local.result <- NULL
  #     if(!is.null(phy)) {
  #       try(local.result <- data.frame(Year=relevant.studies$study_year[study.index], Ntax=Ntip(phy), Pub=study.info[1], DOI=attr(study.info, "DOI")))
  #     } else {
  #       try(local.result <- data.frame(Year=relevant.studies$study_year[study.index], Ntax=NA, Pub=study.info[1], DOI=attr(study.info, "DOI")))
  #     }
  #     if(!is.null(local.result)) {
  #       if(nrow(tree.info)==0) {
  #         tree.info <- local.result
  #       } else {
  #         tree.info <- rbind(tree.info, local.result)
  #       }
  #     }
  #     
  #   }
  # }
  # 
  # genbank.species.query <- paste0(clade.name, '[subtree] AND species[rank] AND specified[prop]')
  # genbank.species.count <-  entrez_search(db="taxonomy", genbank.species.query, use_history=TRUE)$count
  # 
  # focal.genes <- c("COI", "18S", "28S", "matk", "rbcl")
  # GetNucCount <- function(gene, taxon=clade.name) {
  #   gene.query <- paste0(taxon, '[organism] AND ',gene)
  #   Sys.sleep(3) #just to make sure we stay nice
  #   return(entrez_search(db="nuccore", gene.query, use_history=TRUE)$count)
  # }
  # gene.count <- sapply(focal.genes, GetNucCount, taxon=clade.name) #make sure not to do mclapply or similar lest you violate NCBI terms of service
  # 
  # pubmed.query <- paste0(clade.name, ' AND phylogeny')
  # pubmed.result <- entrez_search(db="pubmed", pubmed.query, use_history=TRUE)
  # 
  # pubmed.summaries <- entrez_summary(db="pubmed", id=pubmed.result$id)
  # pubmed.df <- data.frame(Date=extract_from_esummary(pubmed.summaries, elements=c("sortpubdate")), FirstAuthor=extract_from_esummary(pubmed.summaries, elements=c("sortfirstauthor")), Journal=extract_from_esummary(pubmed.summaries, elements=c("fulljournalname")), Title=extract_from_esummary(pubmed.summaries, elements=c("title")), row.names=NULL)
  # 
  # 
  # 
  
  #### OLD STUFF
  
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(100)]
    hist(data)
  })
  output$taxon <- renderText({  
    paste("My taxon is:",clade.name())
  }) 
}

shinyApp(ui, server)
