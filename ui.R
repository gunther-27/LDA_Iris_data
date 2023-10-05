# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable

library(ggplot2)
library(MASS)
library(shiny)
vars <- setdiff(names(iris), "Species")

pageWithSidebar( 
    headerPanel('Iris Linear Discrimnant Analysis'),
    sidebarPanel(
        selectInput('xcol', 'X Variable', vars),
        selectInput('ycol', 'Y Variable', vars, selected = vars[[2]]),
        HTML("<p>This is app is based off of the <a href='https://search.r-project.org/CRAN/refmans/MVTests/html/iris.html' target='_blank'>Iris dataset</a> contained within r.
             In order to use the app, please select two variables from the dropdown menus.  The graph will automatically update, plotting both the Iris data variables that you chose
             and the areas predicted from a linear discriminant analysis to see how well the species can be separated into groups based on sepal and petal sizes.</p>")
    ),
    mainPanel(
        plotOutput('scatter_plot')
    )
)

