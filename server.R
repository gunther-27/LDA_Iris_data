library(MASS)
library(ggplot2)
shinyServer(function(input, output, session) {
    
    # Combine the selected variables into a new data frame
    selectedData <- reactive({
        iris[, c(input$xcol, input$ycol,'Species')]
    })
    
    # lda_model <- reactive({
    #     lda(Species ~ input$xcol + input$ycol, data = iris)
    # })
    output$scatter_plot <- renderPlot({
        # Create a scatter plot based on user-selected variables
        
        xcol <- input$xcol
        ycol <- input$ycol
        df <- selectedData()
        
        # plot(df[, 1], df[, 2], col = df$Species, pch = 19,
        #      xlab = xcol, ylab = ycol,
        #      main = "Scatter Plot with LDA Decision Boundaries")
        gg <- ggplot(df, aes_string(x = xcol, y = ycol, color = "Species")) +
            geom_point() +
            labs(x = input$x_var, y = input$y_var) +
            theme_minimal()
        
        # Get LDA model
        
        # Assuming you've defined xcol, ycol, df, and lda_mod as you did earlier
        colnames(df)<- c('xcol','ycol','Species')
        # Create the formula dynamically
        # formula <- as.formula(paste("Species ~", xcol, "+", ycol))
        
        # Fit the LDA model using the formula
        lda_mod <- lda(Species ~., data = df)
        
        # Create the grid for prediction
        grid <- expand.grid(xcol = seq(min(df[,1]), max(df[, 1]), length.out = 100),
                            ycol = seq(min(df[, 2]), max(df[, 2]), length.out = 100))
        
        # Predict the classes for the grid
        predicted_classes <- predict(lda_mod, newdata = grid)$class
         gg <- gg + geom_point(data = grid, aes(x = xcol, y = ycol, color = predicted_classes), alpha = 0.05)
        # 
        #  # Add legend for decision boundaries
         gg <- gg + scale_color_manual(values = c("setosa" = "blue", "versicolor" = "green", "virginica" = "red"),
                                       name = "Species")

         print(gg)
    })
    
})
