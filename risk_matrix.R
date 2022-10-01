# Load libraries

library(ggplot2)
library(plotly)
library(dplyr)

# Load the data ----

risk <- read.csv("https://neo-reliability.com/files/risk.csv")
oa_risk <- read.csv("oa_risk.csv")
oa_risk_cons <- read.csv("oa_risk_cons.csv")
oa_risk_cons <- oa_risk_cons %>% 
  inner_join(oa_risk, by="Id")

# Creating heatmap background for Risk Matrix

# setting the score in order to calculate the risk level ----
Likelihood_score <- rep(c(1,2,4,6,12),5)
Consequence_score <- rep(c(1,2,4,6,12),each=5)
Likelihood <- rep(c(1:5),5)
Consequence <- rep(c(1:5),each=5)
df <- data.frame(Likelihood,Consequence)
df <- mutate(df, risk_score = Consequence_score * Likelihood_score,
             Risk = case_when(risk_score >= 0 & risk_score < 6 ~ 1,
                              risk_score >= 6 & risk_score < 12 ~ 2,
                              risk_score >= 12 & risk_score < 32  ~ 3,
                              risk_score >= 32 ~ 4) )

oa_risk <- mutate(oa_risk, risk_score = Consequence * Likelihood,
                  Risk = case_when(risk_score >= 0 & risk_score < 6 ~ "Insignificant",
                                   risk_score >= 6 & risk_score < 12 ~ "Minor",
                                   risk_score >= 12 & risk_score < 32  ~ "Significant"))

# plotting ----
risk_p <- ggplot(df,aes(x =Likelihood, y =Consequence, fill=Risk))+
  geom_tile()+
  scale_fill_gradientn(colours = c("dark green","yellow","red"),guide=FALSE)+
  scale_x_continuous(name= "Likelihood",breaks = 0:5, expand = c(0, 0))+
  scale_y_continuous(name = "Consequence",breaks = 0:5, expand = c(0, 0))+
  #coord_fixed()+
  theme_bw()+
  geom_hline(yintercept = seq(1.5,5.5), color = "white")+
  geom_vline(xintercept = seq(1.5,5.5), color = "white")+
  ggtitle("OpenApps Risk Matrix")+
  theme(legend.position="bottom")+
  guides(color=guide_legend(title="Selected Plants"))+
  geom_jitter(data = oa_risk,
              # position = "jitter",
              inherit.aes = FALSE, width= 0.3,height = 0.3,
              aes(x = Likelihood,
                  y = Consequence, 
                  col = Type,
                  text = paste("<b>Id#:</b>",Id,"<br>",
                               "<b>Issue:</b>",Title,"<br>",
                               "<b>Risk:</b>",Risk,"<br>",
                               "<b>Type:</b>",Type,"</b>",
                               "<b>Interim Action:</b>","Interim")))+
  scale_color_manual(values = c("#9400D3","#009fdf","#aaaaaa")
  )

config(ggplotly(risk_p,tooltip = "text", width = 950,height = 750), displayModeBar=FALSE, collaborate = FALSE) %>%
  layout(margin=list(l=90,b=50),
         legend = list(orientation = "h",y = -0.15, x = 0))

plot(risk_p)

# plot.df <- ggplot(data = oa_risk, aes(x = Likelyhood, y = Consequence, color = Type, group = Type)) +
#   geom_point()
# print(plot.df)

# oa_risk$Risk <- case_when(risk_score >= 0 & risk_score < 6 ~ 1,
#                  risk_score >= 6 & risk_score < 12 ~ 2,
#                  risk_score >= 12 & risk_score < 32  ~ 3,
#                  risk_score >= 32 ~ 4)

