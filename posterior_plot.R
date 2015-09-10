### This is an easy to use code to produce a decent density plot of a posterior distribution, using R ###
### For examle, it is useful as a post-estimation command for any of the MCMCpack regressions ###

library(ggplot2)
library(modeest)

x = as.vector(model1[,2]) #Here, insert which contains your posterior distribution
d <- as.data.frame(x=x)

hdiPlot_dis_rel <- ggplot(data = d) + theme_bw() + 
  geom_density(aes(x=x, y = ..density..), color = 'black')

q5 <- quantile(x,.05)
q95 <- quantile(x,.95)
modex <- asselin(x)
x.dens <- density(x)
df.dens <- data.frame(x = x.dens$x, y = x.dens$y)
hdiPlot_dis_rel + geom_area(data = subset(df.dens, x >= q5 & x <= q95), 
              aes(x=x,y=y), fill = 'blue') +
  geom_vline(xintercept = modex, linetype="dotted") + 
  geom_text(aes(modex,-0.005,label = "Mode", size=4), show_guide = F) + #Here, you can play around with the position of the 'Mode' label
  geom_vline(xintercept = c(0)) +
  xlab("X Variable Label") +
  ylab("Density")
