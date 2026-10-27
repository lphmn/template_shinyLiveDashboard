# Shiny Dashboard
# Hastag (# ---------------------------------------------------------------) means Primary Header
# Hastag (### *** Definition ###) means Secondary Header
# Hold  alt o to collapse all
# Hold shift alt o to expand all

# Load Packages ---------------------------------------------------------------
library(shiny)
library(shinydashboard)
library(shinyjs)

# Loading data since this is a template, no data is actually pulled from somewhere.

# Create the data frame
df <- data.frame(
  # id can represent something like a region and var1 can represent something like a county (1 to many relationship)
  # By referencing the region in the var1 label than there is no confusion as to what "county" belongs to what "region"
  id = c(1, 1, 1, 2, 2, 2, 3, 3),
  var1 = c("a (1)", "b (1)", "c (1)", "d (2)", "e (2)", "f (2)", "g (3)", "h (3)")
)

# User Interface ----------------------------------------------------------
ui <- dashboardPage(
  dashboardHeader(
    title = tags$span("Basic Dashboard Setup", style = "color: #ffffff; font-weight: 700;"),
    titleWidth = 400
    # disable = TRUE # uncomment if the header should be hid
  ),
  dashboardSidebar(
    width = 350,
    tags$div(class = "sr-only", "Main navigation and filters"),
    checkboxInput(
      inputId = "parGlobal_hideTabPanel",
      label = tags$span("HIDE TAB PANEL MENU ONE", style = "font-weight: 600; color: #111111;"),
      value = FALSE
    ),
    checkboxInput(
      inputId = "parGlobal_hideNarrative",
      label = tags$span("HIDE NARRATIVE MENU TWO", style = "font-weight: 600; color: #111111;"),
      value = FALSE
    ),

    # Other input elements...
    selectInput(
      "parGlobal_inputOne",
      label = tags$span("Select Letter of Interest", style = "font-weight: 600; color: #111111;"),
      choices = sort(unique(df$var1)),
      selected = "c",
      multiple = FALSE,
      width = 350
    ),
    # The following two parameters are set in the server based on the previous parameter (parGlobal_inputOne)
    selectInput(
      "parGlobal_casscadeFromInputOneRestrictive",
      label = tags$span("Select Cascade Prompt (Restrictive Options)", style = "font-weight: 600; color: #111111;"),
      choices = NULL,
      selected = NULL,
      multiple = FALSE,
      width = 350
    ),
    selectInput(
      "parGlobal_casscadeFromInputOneNonRestrictive",
      label = tags$span("Select Cascade Prompt (Non Restrictive Options)", style = "font-weight: 600; color: #111111;"),
      choices = NULL,
      selected = NULL,
      multiple = FALSE,
      width = 350
    ),
    selectInput(
      "parGlobal_casscadeFromInputOneOneOption",
      label = tags$span("Select Cascade Prompt (Only Dependent Option)", style = "font-weight: 600; color: #111111;"),
      choices = NULL,
      selected = NULL,
      multiple = FALSE,
      width = 350
    ),
    # Sidebar is required to have sub menus because it requires the tabName to reference
    sidebarMenu(
      menuItem(text = "Menu One", tabName = "tn_menuOne"),
      menuItem(text = "Menu Two", tabName = "tn_menuTwo")
    )
  ),
  dashboardBody(
    tags$head(
      tags$style(HTML(" 
        :root {
          color-scheme: light;
        }
        body {
          background-color: #ffffff;
          color: #111111;
          line-height: 1.5;
        }
        .content-wrapper,
        .right-side,
        .main-sidebar {
          background-color: #f5f5f5;
        }
        .main-sidebar .sidebar-menu > li > a,
        .main-header .logo,
        .main-header .navbar,
        .main-header .navbar-static-top,
        .main-header .navbar-nav > li > a {
          color: #111111;
        }
        .main-header {
          background-color: #0d4f8b;
          border-bottom: 3px solid #083f6b;
        }
        .box,
        .box-body,
        .box-header {
          border: 1px solid #d0d0d0;
          color: #111111;
        }
        .nav-tabs > li > a,
        .nav-tabs > li.active > a,
        .nav-tabs > li.active > a:hover,
        .nav-tabs > li.active > a:focus {
          color: #111111;
        }
        .form-control,
        .selectize-input,
        .selectize-dropdown {
          border: 2px solid #4d4d4d;
          min-height: 38px;
          color: #111111;
          background-color: #ffffff;
        }
        .form-control:focus,
        .selectize-input:focus,
        .selectize-input.focus,
        .sidebar-menu > li > a:focus,
        .nav-tabs > li > a:focus,
        .btn:focus,
        input:focus,
        select:focus,
        button:focus,
        a:focus {
          outline: 3px solid #005fcc !important;
          outline-offset: 3px;
          box-shadow: 0 0 0 3px rgba(0, 95, 204, 0.25) !important;
        }
        .checkbox,
        .radio,
        label,
        .shiny-input-container {
          color: #111111;
        }
        .sr-only {
          position: absolute;
          width: 1px;
          height: 1px;
          padding: 0;
          margin: -1px;
          overflow: hidden;
          clip: rect(0, 0, 0, 0);
          white-space: nowrap;
          border: 0;
        }
        h1, h2, h3, h4, h5, h6, p {
          color: #111111;
        }
        .box-title {
          color: #111111;
          font-weight: 700;
        }
      ")),
      tags$script(HTML(" 
        $(document).ready(function() {
          $('.sidebar-menu a').attr('aria-label', function() {
            return $(this).text().trim();
          });
          $('.nav-tabs a').attr('aria-label', function() {
            return $(this).text().trim();
          });
        });
      "))
    ),
    shinyjs::useShinyjs(),
    fluidRow(
      column(
        12,
        tabItems(
          tabItem(
            tabName = "tn_menuOne",
            tabsetPanel(
              id = "tspID_hideTabPanel",
              tabPanel(
                "Menu One Tab Panel (Hide Tab Panel)",
                fluidRow(
                  column(
                    width = 4,
                    h1("Small header"),
                    h2("Bigger Header"),
                    h3("Bigger Header"),
                    h4("Bigger Header"),
                    h5("Bigger Header"),
                    h6("Largest Header"),
                    p("smaller font"),
                    tags$hr(style = "border-top: 2px solid #4d4d4d; margin-top: 20px; margin-bottom: 20px;")
                  ),
                  column(
                    width = 4,
                    p("Refer to menuTwo R code to see why it is important to put the line below the narrative"),
                    tags$hr(style = "border-top: 2px solid #4d4d4d; margin-top: 20px; margin-bottom: 20px;")
                  ),
                  column(
                    width = 4,
                    p("The line is not consistent due to it being applied on each column"),
                    tags$hr(style = "border-top: 2px solid #4d4d4d; margin-top: 20px; margin-bottom: 20px;")
                  )
                ),
                fluidRow(
                  h3("Another row")
                )
              ),
              tabPanel(
                "Menu One Tab Panel (Will Not Hide Tab Panel)",
                fluidRow(
                  column(
                    width = 12,
                    h3(HTML("Using HTML to change font color from black to <font color=red>red</font> as well as <b>bolding</b> text."))
                  )
                )
              )
            )
          ),
          tabItem(
            tabName = "tn_menuTwo",
            tabsetPanel(
              tabPanel(
                "Menu Two Tab Panel (Hide Narrative)",
                fluidRow(
                  column(
                    width = 1,
                    selectInput(
                      "tpID_parLocal_hideNarrative",
                      label = tags$span("This is a local narrative", style = "font-weight: 600; color: #111111;"),
                      choices = c("Local", "Options"),
                      selected = NULL,
                      multiple = FALSE
                    )
                  ),
                  column(
                    width = 11,
                    id = "tpID_hideNarrative",
                    h1("Wide Border")
                  )
                ),
                fluidRow(
                  tags$hr(style = "border-top: 2px solid #4d4d4d; margin-top: 20px; margin-bottom: 20px;"),
                  box(h3("Another row")),
                  box(h3("Another row"))
                )
              ),
              tabPanel(
                "Menu Two Tab Panel (Hide Narrative)",
                fluidRow(
                  column(
                    width = 1,
                    selectInput(
                      "tpID_parLocal_WillNotHideNarrative",
                      label = tags$span("This is a local narrative", style = "font-weight: 600; color: #111111;"),
                      choices = c("Local", "Options"),
                      selected = NULL,
                      multiple = FALSE
                    )
                  ),
                  column(
                    width = 11,
                    id = "tpID_hideNarrative",
                    h1("Wide Border")
                  )
                ),
                fluidRow(
                  tags$hr(style = "border-top: 2px solid #4d4d4d; margin-top: 20px; margin-bottom: 20px;"),
                  box(h3("Another row")),
                  box(h3("Another row"))
                )
              )
            )
          )
        )
      )
    )
  )
)

# To improve performance load items once and don't run them every time in the server. This is my understanding as of 4/4/2024 --------
# Although this is a simple example, it can be and should be applied to more complex calculations that occur only once

server <- function(input, output, session) {

  # When parGlobal_inputOne changes, this will return a non-restrictive list (User can still change options)
  # Use Case could be results shown by a region shouldn't just be based on the county selected
  # Utilized MS Copilot AI to get this to work
  observeEvent(input$parGlobal_inputOne, {
    if (input$parGlobal_inputOne %in% df$var1) {
      # What the following is doing is taking the df id values and ordering them in the same order based on the selection
      updateSelectInput(
        session,
        "parGlobal_casscadeFromInputOneRestrictive",
        choices = unique(df$id[order(df$var1 == input$parGlobal_inputOne, decreasing = TRUE)]),
        selected = unique(df$id[order(df$var1 == input$parGlobal_inputOne, decreasing = TRUE)])[1]
      )
    } else {
      updateSelectInput(
        session,
        "parGlobal_casscadeFromInputOneRestrictive",
        choices = "",
        selected = ""
      )
    }
  })

  # When parGlobal_inputOne changes, this will return a restrictive list
  # Worked with MS Copilot AI to get this to work
  observeEvent(input$parGlobal_inputOne, {
    if (input$parGlobal_inputOne %in% df$var1) {
      orderedallIds <- df$id[order(df$var1 == input$parGlobal_inputOne, decreasing = TRUE)]
      orderedVar1 <- df$var1[order(df$var1 == input$parGlobal_inputOne, decreasing = TRUE)]
      labeledOptions <- paste0(orderedVar1, " (extra label because the label is included in orginal par (", orderedallIds, ") )")

      updateSelectInput(
        session,
        "parGlobal_casscadeFromInputOneNonRestrictive",
        choices = labeledOptions,
        selected = labeledOptions[1]
      )
    } else {
      updateSelectInput(
        session,
        "parGlobal_casscadeFromInputOneNonRestrictive",
        choices = "",
        selected = ""
      )
    }
  })

  # Cascading prompt that only shows dependent result
  observeEvent(input$parGlobal_inputOne, {
    if (input$parGlobal_inputOne %in% df$var1) {
      updateSelectInput(
        session,
        "parGlobal_casscadeFromInputOneOneOption",
        choices = df$id[df$var1 == input$parGlobal_inputOne],
        selected = df$id[df$var1 == input$parGlobal_inputOne]
      )
    } else {
      updateSelectInput(
        session,
        "parGlobal_casscadeFromInputOneOneOption",
        choices = "",
        selected = ""
      )
    }
  })

  # Hide Tab when checkbox is selected
  # https://stackoverflow.com/questions/60054418/shiny-tab-hide-show
  observeEvent(
    input$parGlobal_hideTabPanel,
    ignoreNULL = FALSE,
    ignoreInit = TRUE,
    {
      if (isTRUE(input$parGlobal_hideTabPanel)) {
        hideTab(inputId = "tspID_hideTabPanel", target = "Menu One Tab Panel (Hide Tab Panel)")
      } else {
        showTab(inputId = "tspID_hideTabPanel", target = "Menu One Tab Panel (Hide Tab Panel)")
      }
    }
  )

  # Observe the input value of the checkbox
  # shinyjs has a function called hide, show, and toggle. Toggle is suppose to work as hide and show but I couldn't get it to function correctly with a checkbox
  # Js stands for javascript
  observeEvent(
    input$parGlobal_hideNarrative,
    ignoreNULL = FALSE,
    ignoreInit = TRUE,
    {
      if (isTRUE(input$parGlobal_hideNarrative)) {
        shinyjs::hide("tpID_parLocal_hideNarrative")
        shinyjs::hide("tpID_hideNarrative")
      } else {
        shinyjs::show("tpID_parLocal_hideNarrative")
        shinyjs::show("tpID_hideNarrative")
      }
    }
  )
}

shinyApp(ui = ui, server = server)
