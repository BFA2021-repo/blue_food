library(aplot)
library(ggplot2)
library("magrittr") 
library(ggrepel)
library(ggpubr)
library(dplyr)
library(pheatmap)


#Read table
m=read.csv('./Results/data_viz/fig_viz.csv',
           header = TRUE)

IC <- m[,c(1,2,4,10,11,13,20,23,24)]
IA <- m[,c(1,3,5,10,12,14,19,23,24)]
MC <- m[,c(1,6,8,10,15,17,22,23,24)]
MA <- m[,c(1,7,9,10,16,18,21,23,24)]

IC=na.omit(IC)
colnames(IC) <- c("ISO", "QPI", "SPI", "Cap", "QV", "SV", "Pro", "Cont", "Inco")
IA=na.omit(IA)
colnames(IA) <- c("ISO", "QPI", "SPI", "Cap", "QV", "SV", "Pro", "Cont", "Inco")
MC=na.omit(MC)
colnames(MC) <- c("ISO","QPI", "SPI", "Cap", "QV", "SV", "Pro", "Cont", "Inco")
MA=na.omit(MA)
colnames(MA) <- c("ISO","QPI", "SPI", "Cap", "QV", "SV", "Pro", "Cont", "Inco")

head(IC)
head(IA)
head(MC)
head(MA)

## FIGURE2 Quantity FW CAPTURE
IC1=ggplot(IC, aes(y = QPI, x = Cap)) + 
  geom_point(aes(color = Cont, size = (Pro)^(1/3)), alpha = 0.5) + 
  scale_color_manual(values = c("#FFD947","#FC5185", "#A9D158","#3FC1C9", "#B389ED")) +
  scale_size(range = c(0.5, 12))+ 
  geom_text_repel(data= subset(IC,QPI > max(IC$QPI)*2/3 | QPI < max(IC$QPI)/3 | Cap < max(IC$Cap)/3 | Cap > max(IC$Cap)*2/3),aes(label=ISO), size= 5) + 
  geom_hline(yintercept = max(IC$QPI)/3,lty="dashed")+
  geom_hline(yintercept = max(IC$QPI)*2/3,lty="dashed")+
  geom_vline(xintercept = max(IC$Cap)/3,lty="dashed")+
  geom_vline(xintercept = max(IC$Cap)*2/3,lty="dashed")+
  theme_classic(base_size = 35)+
  theme(axis.title = element_blank(),legend.position = "none")

IC2<-ggplot(IC,aes(Cap))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
IC3<-ggplot(IC,aes(QPI))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  coord_flip()
IC4=p1%>%
  insert_top(p2,height = 0.1)%>%
  insert_right(p3,0.1)  

## FIGURE2 Quantity FW CULTURE
IA1=ggplot(IA, aes(y = QPI, x = Cap)) + 
  geom_point(aes(color = Cont, size = (Pro)^(1/3)), alpha = 0.5) + 
  scale_color_manual(values = c("#FFD947","#FC5185", "#A9D158","#3FC1C9", "#B389ED")) +
  scale_size(range = c(0.5, 12))+ geom_text_repel(data= subset(IA,QPI > max(IA$QPI)*2/3 | QPI < max(IA$QPI)/3 | Cap < max(IA$Cap)/3 | Cap > max(IA$Cap)*2/3),aes(label=ISO), size= 5) + 
  geom_hline(yintercept = max(IA$QPI)/3,lty="dashed")+
  geom_hline(yintercept = max(IA$QPI)*2/3,lty="dashed")+
  geom_vline(xintercept = max(IA$Cap)/3,lty="dashed")+
  geom_vline(xintercept = max(IA$Cap)*2/3,lty="dashed")+
  theme_classic(base_size = 35)+
  theme(axis.title = element_blank(),legend.position = "none")

IA2<-ggplot(IA,aes(Cap))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
IA3<-ggplot(IA,aes(QPI))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  coord_flip()
IA4=f1%>%
  insert_top(f2,height = 0.1)%>%
  insert_right(f3,0.1) 

## FIGURE2 Quantity MARINE CAPTURE
MC1=ggplot(MC, aes(y = QPI, x = Cap)) + 
  geom_point(aes(color = Cont, size = (Pro)^(1/3)), alpha = 0.5) + 
  scale_color_manual(values = c("#FFD947","#FC5185", "#A9D158","#3FC1C9", "#B389ED")) +
  scale_size(range = c(0.5, 12))+ geom_text_repel(data= subset(MC,QPI > max(MC$QPI)*2/3 | QPI < max(MC$QPI)/3 | Cap < max(MC$Cap)/3 | Cap > max(MC$Cap)*2/3),aes(label=ISO), size= 5) + 
  geom_hline(yintercept = max(MC$QPI)/3,lty="dashed")+
  geom_hline(yintercept = max(MC$QPI)*2/3,lty="dashed")+
  geom_vline(xintercept = max(MC$Cap)/3,lty="dashed")+
  geom_vline(xintercept = max(MC$Cap)*2/3,lty="dashed")+
  theme_classic(base_size = 35)+
  theme(axis.title = element_blank(),legend.position = "none")

MC2<-ggplot(MC,aes(Cap))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
MC3<-ggplot(MC,aes(QPI))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  coord_flip()
MC4=t1%>%
  insert_top(t2,height = 0.1)%>%
  insert_right(t3,0.1) 

## FIGURE2 Quantity MARINE CULTURE
MA1=ggplot(MA, aes(y = QPI, x = Cap)) + 
  geom_point(aes(color = Cont, size = (Pro)^(1/3)), alpha = 0.5) + 
  scale_color_manual(values = c("#FFD947","#FC5185", "#A9D158","#3FC1C9", "#B389ED")) +
  scale_size(range = c(0.5, 12))+ geom_text_repel(data= subset(MA,QPI > max(MA$QPI)*2/3 | QPI < max(MA$QPI)/3 | Cap < max(MA$Cap)/3 | Cap > max(MA$Cap)*2/3),aes(label=ISO),size= 5) + 
  geom_hline(yintercept = max(MA$QPI)/3,lty="dashed")+
  geom_hline(yintercept = max(MA$QPI)*2/3,lty="dashed")+
  geom_vline(xintercept = max(MA$Cap)/3,lty="dashed")+
  geom_vline(xintercept = max(MA$Cap)*2/3,lty="dashed")+
  theme_classic(base_size = 35)+
  theme(axis.title = element_blank(),legend.position = "none")

MA2<-ggplot(MA,aes(Cap))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
MA3<-ggplot(MA,aes(QPI))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  coord_flip()
MA4=h1%>%
  insert_top(h2,height = 0.1)%>%
  insert_right(h3,0.1) 

## FIGURE2 SAFETY FW CAPTURE
SIC1=ggplot(IC, aes(y = SPI, x = Cap)) + 
  geom_point(aes(color = Cont, size = (Pro)^(1/3)), alpha = 0.5) + 
  scale_color_manual(values = c("#FFD947","#FC5185", "#A9D158","#3FC1C9", "#B389ED")) +
  scale_size(range = c(0.5, 12))+ 
  geom_text_repel(data= subset(IC,SPI > max(IC$SPI)*2/3 | SPI < max(IC$SPI)/3 | Cap < max(IC$Cap)/3 | Cap > max(IC$Cap)*2/3),aes(label=ISO), size= 5) + 
  geom_hline(yintercept = max(IC$SPI)/3,lty="dashed")+
  geom_hline(yintercept = max(IC$SPI)*2/3,lty="dashed")+
  geom_vline(xintercept = max(IC$Cap)/3,lty="dashed")+
  geom_vline(xintercept = max(IC$Cap)*2/3,lty="dashed")+
  theme_classic(base_size = 35)+
  theme(axis.title = element_blank(),legend.position = "none")

SIC2<-ggplot(IC,aes(Cap))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
SIC3<-ggplot(IC,aes(SPI))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  coord_flip()
SIC4=p1%>%
  insert_top(p2,height = 0.1)%>%
  insert_right(p3,0.1)  

## FIGURE2 SAFETY FW CULTURE
SIA1=ggplot(IA, aes(y = SPI, x = Cap)) + 
  geom_point(aes(color = Cont, size = (Pro)^(1/3)), alpha = 0.5) + 
  scale_color_manual(values = c("#FFD947","#FC5185", "#A9D158","#3FC1C9", "#B389ED")) +
  scale_size(range = c(0.5, 12))+ geom_text_repel(data= subset(IA,SPI > max(IA$SPI)*2/3 | SPI < max(IA$SPI)/3 | Cap < max(IA$Cap)/3 | Cap > max(IA$Cap)*2/3),aes(label=ISO), size= 5) + 
  geom_hline(yintercept = max(IA$SPI)/3,lty="dashed")+
  geom_hline(yintercept = max(IA$SPI)*2/3,lty="dashed")+
  geom_vline(xintercept = max(IA$Cap)/3,lty="dashed")+
  geom_vline(xintercept = max(IA$Cap)*2/3,lty="dashed")+
  theme_classic(base_size = 35)+
  theme(axis.title = element_blank(),legend.position = "none")

SIA2<-ggplot(IA,aes(Cap))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
SIA3<-ggplot(IA,aes(SPI))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  coord_flip()
SIA4=f1%>%
  insert_top(f2,height = 0.1)%>%
  insert_right(f3,0.1) 

## FIGURE2 SAFETY MARINE CAPTURE
SMC1=ggplot(MC, aes(y = SPI, x = Cap)) + 
  geom_point(aes(color = Cont, size = (Pro)^(1/3)), alpha = 0.5) + 
  scale_color_manual(values = c("#FFD947","#FC5185", "#A9D158","#3FC1C9", "#B389ED")) +
  scale_size(range = c(0.5, 12))+ geom_text_repel(data= subset(MC,SPI > max(MC$SPI)*2/3 | SPI < max(MC$SPI)/3 | Cap < max(MC$Cap)/3 | Cap > max(MC$Cap)*2/3),aes(label=ISO), size= 5) + 
  geom_hline(yintercept = max(MC$SPI)/3,lty="dashed")+
  geom_hline(yintercept = max(MC$SPI)*2/3,lty="dashed")+
  geom_vline(xintercept = max(MC$Cap)/3,lty="dashed")+
  geom_vline(xintercept = max(MC$Cap)*2/3,lty="dashed")+
  theme_classic(base_size = 35)+
  theme(axis.title = element_blank(),legend.position = "none")

SMC2<-ggplot(MC,aes(Cap))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
SMC3<-ggplot(MC,aes(SPI))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  coord_flip()
SMC4=t1%>%
  insert_top(t2,height = 0.1)%>%
  insert_right(t3,0.1) 

## FIGURE2 SAFETY MARINE CULTURE
SMA1=ggplot(MA, aes(y = SPI, x = Cap)) + 
  geom_point(aes(color = Cont, size = (Pro)^(1/3)), alpha = 0.5) + 
  scale_color_manual(values = c("#FFD947","#FC5185", "#A9D158","#3FC1C9", "#B389ED")) +
  scale_size(range = c(0.5, 12))+ geom_text_repel(data= subset(MA,SPI > max(MA$SPI)*2/3 | SPI < max(MA$SPI)/3 | Cap < max(MA$Cap)/3 | Cap > max(MA$Cap)*2/3),aes(label=ISO),size= 5) + 
  geom_hline(yintercept = max(MA$SPI)/3,lty="dashed")+
  geom_hline(yintercept = max(MA$SPI)*2/3,lty="dashed")+
  geom_vline(xintercept = max(MA$Cap)/3,lty="dashed")+
  geom_vline(xintercept = max(MA$Cap)*2/3,lty="dashed")+
  theme_classic(base_size = 35)+
  theme(axis.title = element_blank(),legend.position = "none")

SMA2<-ggplot(MA,aes(Cap))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
SMA3<-ggplot(MA,aes(SPI))+
  geom_density(fill="grey",alpha=0.5)+
  scale_y_continuous(expand = c(0,0))+
  theme_minimal()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  coord_flip()
SMA4=h1%>%
  insert_top(h2,height = 0.1)%>%
  insert_right(h3,0.1) 


## FIGURE 3 QUANTITY VS SAFETY
IC$System="FW captur"
IA$System="FW culture"
MC$System="Marine capture"
MA$System="Mariculture"
m2=rbind(IC,IA,MC,MA)
m2=na.omit(m2)

m2$System <- factor(m2$System, levels = c("FW capture","FW culture","Marine capture","Mariculture"))
w1=ggplot(m2, aes(x = QV, y = SV)) + 
  geom_point(aes(color =  Inco),size=2, alpha = 0.7) + 
  scale_color_manual(values = c("#A9D158","#FC5185", "#FFD947","#3FC1C9", "#FFA647")) +
  scale_size(range = c(0.5, 12))+ geom_text_repel(label=m2$ISO) + 
  stat_smooth(method = "lm",formula = y ~ x, colour="black", linetype="dashed")+
  geom_hline(yintercept = max(m2$SV)/3,lty="dashed")+
  geom_hline(yintercept = max(m2$SV)*2/3,lty="dashed")+
  geom_vline(xintercept = max(m2$QV)/3,lty="dashed")+
  geom_vline(xintercept = max(m2$QV)*2/3,lty="dashed")+
  xlab("Quantity")+
  ylab("Safety")
w1+facet_wrap(~System)+theme_bw()+theme(panel.grid = element_blank(),legend.position = "none")+ theme(strip.text.x = element_text(size = 15),text = element_text(size=15))


##CLUSTER ANALYSIS & Heatmap
n=m[,c(1,11,12,13,14,15,16,17,18)]
n[is.na(n)] <- 0

# Min-Max normalization
normalize <- function(x) {return((x - min(x)) / (max(x) - min(x)))}
p <- as.data.frame(lapply(n[,-1], normalize))

df <- scale(p)
head(df, n = 5)
##kֵ??plot
wss <- (nrow(df)-1)*sum(apply(df,2,var)) # ??????????ƽ????
for (i in 2:15) wss[i] <- sum(kmeans(df, centers=i)$withinss) #???㲻ͬ??????????????ƽ????
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares") # ??ͼ
##???鲢д??????
k=pheatmap(p, clustering_method = "ward.D", cutree_col = 2,kmeans_k = 4, cellheight = 60, angle_col = 45,color = colorRampPalette(c("#FEFFB3","#FFB24E", "#BD0026"))(60))
n1=p[k$tree_row$order,k$tree_col$order]


## Figure 6
m2=m[,c(11-18)]
m2=na.omit(m2)
w1=ggplot(m2, aes(x = VICs, y = SVICs, shape=Classification)) + 
  geom_point(aes(color = Continent),size=3, alpha = 0.7) + 
  scale_color_manual(values = c("#FFD947","#FC5185", "#A9D158","#3FC1C9", "#B389ED")) +
  scale_size(range = c(0.5, 12))+ geom_text_repel(label=m2$ISO) + 
  geom_hline(yintercept = max(m2$SVICs)/3,lty="dashed")+
  geom_hline(yintercept = max(m2$SVICs)*2/3,lty="dashed")+
  geom_vline(xintercept = max(m2$VICs)/3,lty="dashed")+
  geom_vline(xintercept = max(m2$VICs)*2/3,lty="dashed")+
  xlab("Quantity")+
  ylab("Safety")
  
w1+facet_wrap(~System)+theme_bw()+theme(panel.grid = element_blank(), strip.text.x = element_text(size = 15),legend.position="bottom")


## Figure S6
#sensitivity analysis
l=read.csv(file.choose(),header = TRUE)
d=ggplot(data=l,aes(x=ID,y=ScoreAvg))+
  geom_point()+
  geom_errorbar(data=l,aes(ymin=ScoreAvg-ScoreStd, ymax=ScoreAvg+ScoreStd,x=ID, y=ScoreAvg))+
  labs(y="Exposure",x=" ")
d+facet_grid(Catogary~Continent, scales = "free", space = "free")+theme_bw()+theme(panel.grid = element_blank())+
  theme(axis.ticks.x = element_blank(),
        axis.line = element_blank(),
        axis.text.x = element_blank(),
        strip.text.x = element_text(size = 15),
        strip.text.y = element_text(size = 14))

## Figure S8 S13
p<- ggplot(data=x1)+ 
  geom_boxplot(mapping=aes(x=Continent,y=SVIC,colour = Continent), #????ͼ
               alpha = 0.5,
               size=1,
               width = 0.6)+ 
  geom_jitter(mapping=aes(x=Continent,y=SVIC,colour = Continent), #ɢ??
              alpha = 0.3,size=3)+
  scale_color_manual(values=c("#FFA647", "#FFD947", "#3FC1C9","#FC5185","#B389ED")) #??ɫ
p+facet_wrap(~System)

## Figure S9
m3=m[,c(1,2,8,9,10)]
m3[m3==0]=NA
m3=na.omit(m3)
m3$Production=log10(m3$ICP)
ggscatter(m3, x="Production", y="VIC", 
          add = "reg.line",
          conf.int = T)+
  labs(y = "Vulnerability", x = "log(Production)")+
  stat_cor(label.x = 2, label.y = -0.1)+
  facet_wrap(~System,scales="free")+
  theme_bw()+
  theme(strip.text.x = element_text(size = 15))

ggscatter(m3, x="Production", y="SVIC", 
          add = "reg.line",
          conf.int = T)+
  labs(y = "Vulnerability", x = "log(Production)")+
  stat_cor(label.x = 2, label.y = -0.1)+
  facet_wrap(~System,scales="free")+
  theme_bw()+
  theme(strip.text.x = element_text(size = 15))
