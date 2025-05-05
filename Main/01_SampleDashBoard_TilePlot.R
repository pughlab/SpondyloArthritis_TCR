library(tidyverse)
library(ggalign)
### Input data preparation ----------------------------------------------------------------------------------------
data_path <- "https://raw.githubusercontent.com/pughlab/SpondyloArthritis_TCR/refs/heads/main/Data"
Inventory_fname <- "01_SampleInventory.csv"
InventoryData <- read_csv(file.path(data_path , Inventory_fname)) 

### Visualization -------------------------------------------------------------------------------------------------

ggsave(file.path("/Users/shirin/Desktop/Immunarch/downsamplign/Projetcs/AS/Inventory" ,
                 "AS_SampleInventory.svg") ,
       device = "svg" ,
       width = 7000 ,
       height = 3000 ,
       units = "px" ,
       dpi = 1000)
ggplot(data = InventoryData %>%
               mutate(`Disease status` = fct_relevel(`Disease status` , "axSpA" , "ReA" , "Healthy"))) +
        geom_tile(
                aes(
                        x = `Patient ID` ,
                        y =  BioSpecimen ,
                        fill = Phenotype),
                color = "#000000" ,
                linewidth = 0.05 ,
                width = 0.85 , height = 0.75 )+
        
        scale_fill_manual(breaks = c("CD8CD103CD49a" , "NoSignature") ,
                          labels = c("InEx CD8 CD103 CD49a T cells" , "Unsorted, bulk population") ,
                          values = c("#EEC8C8" , "#860309")) + 
        
        ggh4x::facet_nested(. ~ Technology + `Disease status`,
                   scales = "free" ,
                   space = "free" ) +
        theme_light() +
        theme(
                panel.grid = element_blank() ,
                panel.spacing = unit(0.5 , units = "line"),
                axis.ticks.x = element_line(linewidth = 0.25 , color = "#000000"),
                axis.line.x = element_line(color = "#000000" , linewidth = 0.25) ,
                
                
                axis.title = element_blank() ,
                
                axis.text.y = element_text(size = 9 , color = "#000000") ,
                axis.text.x = element_text(size = 9 ,  color = "#000000" , angle = 30 , hjust = 1) ,
                
                strip.text.x = element_text(size = 9 , color = "#000000") ,
                strip.text.y = element_text(size = 9 , color = "#000000" , angle = 0) ,
                
                legend.position = "bottom" ,
                legend.text = element_text(size = 9 , color = "#000000") ,
                legend.title = element_text(size = 9 , color = "#000000"))
dev.off()
