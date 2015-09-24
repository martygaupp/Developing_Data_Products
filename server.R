library(manipulate)
library(ggplot2)
mu0 = 30

shinyServer(
  function(input, output) {
    output$newGraph <- renderPlot({
      sigma <- input$sigma
      mua <- input$mua
      n <- input$n
      alpha <- input$alpha
      xitc = mu0 + qnorm(1 - alpha) * sigma / sqrt(n)
      xvals <- seq(27, 36, .001)
      mu0yvals <- dnorm(xvals, mu0, sigma/sqrt(n))
      mu0Data <- data.frame(x=xvals,y=mu0yvals)
      ShadeRed <- rbind(c(xitc,0), subset(mu0Data, x > xitc), c(mu0Data[nrow(mu0Data), "X"], 0))
      muayvals <- dnorm(xvals, mua, sigma/sqrt(n))
      muaData <- data.frame(x=xvals,y=muayvals)
      ShadeBlue <- rbind(c(xitc,0), subset(muaData, x < xitc), c(muaData[nrow(muaData), "X"], 0))
      
      g = ggplot(data.frame(mu = c(27, 36)), aes(x = mu))
      g = g + stat_function(fun=dnorm, geom = "line", 
                            args = list(mean = mu0, sd = sigma / sqrt(n)), 
                            size = 2, col = "red")
      g = g + stat_function(fun=dnorm, geom = "line", 
                            args = list(mean = mua, sd = sigma / sqrt(n)), 
                            size = 2, col = "blue")
      conf = 100*(1 - alpha)
      g = g + annotate("text", x = 27, y = .35, label = paste("alpha =", format(round(alpha,3), nsmall = 3)), col = "red", hjust = 0)
      g = g + annotate("text", x = 27.25, y = .325, label = paste("confidence =", format(round(conf,1), nsmall = 1), "%"), hjust = 0)
      beta = pnorm(xitc, mean = mua, sd = sigma/sqrt(n), lower.tail = TRUE)
      power = 100*(1 - beta)
      g = g + annotate("text", x = 27, y = .3, label = paste("beta =", format(round(beta,3), nsmall = 3)), col = "blue", hjust = 0)
      g = g + annotate("text", x = 27.25, y = .275, label = paste("power =", format(round(power,1), nsmall = 1), "%"), hjust = 0)
      g = g + geom_vline(xintercept=xitc, size = 3)
      g = g + geom_polygon(data = ShadeRed, aes(x, y), fill = "red", alpha = 0.5)
      g = g + geom_polygon(data = ShadeBlue, aes(x, y), fill = "blue", alpha = 0.5)
      g = g + xlim(27,36)
      g
    })
  }
)
