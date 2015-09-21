shinyUI(pageWithSidebar(
  headerPanel(HTML("Exploring Type I (&alpha;) and Type II (&beta;) Error")),
  sidebarPanel(
    h4('Note: If there is no graph at the right, just move any slider to force a graphic update'),
    sliderInput('sigma', HTML("sigma (&sigma;):"), value = 4, min = 1, max = 10, step = 1),
    sliderInput('mua', HTML("alt mu (&mu;_a):"), value = 32, min = 30, max = 35, step = 1),
    sliderInput('n', 'sample size (n):', value = 16, min = 1, max = 50, step = 1),
    sliderInput('alpha', HTML("alpha (&alpha;):"), value = 0.05, min = 0.01, max = 0.10, step = 0.01)
  ),
  mainPanel(
    helpText("Use the sliders at the left to change the values of sigma (the standard deviation of both distributions),",
             "the location of the blue alternative hypothesis (alt mu),",
             "the sample size of both distributions (n), and the type I error rate (alpha).",
             " Based on the values you chose, you'll notice that the power depicted changes.",
             " The big vertical line helps delineate type I error (alpha is area under the red curve to the right of this line)",
             "from type II error (beta is the area under the blue curve to the left of this line).  Recall that",
             "the level of confidence is just one minus alpha and power is just one minus beta."),
    plotOutput('newGraph')
  )
))
