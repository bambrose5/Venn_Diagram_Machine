loadfonts(device = "win")
library(gplots)
library(tidyverse)

# Set your directory and import your file. The data should be 2-4 columns with a header for the category
# and rows of features. Category labels, colors, fonts, and the final venn diagram file name can then be chosen.

setwd("your directory")
samples <- read.csv("your data", sep = ",", dec = ".", header = TRUE, na = "NA", stringsAsFactors = FALSE)

my_cats <- c("Category 1", "Category 2", "Category 3", "Category 4")
my_cols <- c("red", "orange", "blue", "green")
my_filename <- "your file name"
my_font <- "Comic Sans MS"

# For a sample set with 4 different categories:

if (ncol(samples) == 4){
  
# Parses out a list of features from each category. Spaces are removed and, in case of repeating features within a
# category, only unique features within the category are chosen.
  
  R1 <- samples[,1]
  R2 <- samples[,2]
  R3 <- samples[,3]
  R4 <- samples[,4]
  
  R1 <- unique(R1[R1 != ""])
  R2 <- unique(R2[R2 != ""]) 
  R3 <- unique(R3[R3 != ""])
  R4 <- unique(R4[R4 != ""])
  
# A new list is compiled and the number of common features between certain categories is determined to create a venn diagram.
# The number of those shared features per category is then determined and named accordingly.
  
  new_list <- list(R1=R1, R2=R2, R3=R3, R4=R4)
  ItemsList <- gplots::venn(new_list, show.plot = FALSE)
  venn_nums <- lengths(attributes(ItemsList)$intersections)
  
  area1 <- length(R1)
  area2 <- length(R2)
  area3 <- length(R3)
  area4 <- length(R4)
  n1234 <- tryCatch(getElement(venn_nums, "R1:R2:R3:R4"), error = function(e) return(0))
  n123 <- tryCatch(getElement(venn_nums, "R1:R2:R3"), error = function(e) return(0)) + n1234
  n124 <- tryCatch(getElement(venn_nums, "R1:R2:R4"), error = function(e) return(0)) + n1234
  n134 <- tryCatch(getElement(venn_nums, "R1:R3:R4"), error = function(e) return(0)) + n1234
  n234 <- tryCatch(getElement(venn_nums, "R2:R3:R4"), error = function(e) return(0)) +n1234
  n12 <- tryCatch(getElement(venn_nums, "R1:R2"), error = function(e) return(0)) + n123 + n124
  n13 <- tryCatch(getElement(venn_nums, "R1:R3"), error = function(e) return(0)) + n123 + n134
  n14 <- tryCatch(getElement(venn_nums, "R1:R4"), error = function(e) return(0)) + n124 +n134
  n23 <- tryCatch(getElement(venn_nums, "R2:R3"), error = function(e) return(0)) + n123 + n234
  n24 <- tryCatch(getElement(venn_nums, "R2:R4"), error = function(e) return(0)) + n124 + n234
  n34 <- tryCatch(getElement(venn_nums, "R3:R4"), error = function(e) return(0)) + n134 + n234
  
  # Draws venn diagram and writes the file to desired folder.
  
  venn.plot <- draw.quad.venn(area1, area2, area3, area4, n12, n13, n14, n23, n24, n34, n123, n124, n134, n234, n1234,
    category = my_cats,
    fill = my_cols,
    cex = 2,
    cat.cex = 2,
    fontfamily = my_font,
    cat.fontfamily = my_font)
  
  tiff(res = 300, height = 6, width = 7, units = "in",
    filename = my_filename, 
    compression = "lzw"
  );
  grid.draw(venn.plot)
  dev.off()
}

# Same principles apply below but with 2 and 3 categories.

if (ncol(samples) == 3){
  R1 <- samples[,1]
  R2 <- samples[,2]
  R3 <- samples[,3]
  
  R1 <- unique(R1[R1 != ""])
  R2 <- unique(R2[R2 != ""]) 
  R3 <- unique(R3[R3 != ""])
  
  new_list <- list(R1=R1, R2=R2, R3=R3)
  ItemsList <- gplots::venn(new_list, show.plot = FALSE)
  venn_nums <- lengths(attributes(ItemsList)$intersections)
  
  area1 <- length(R1)
  area2 <- length(R2)
  area3 <- length(R3)
  n123 <- tryCatch(getElement(venn_nums, "R1:R2:R3"), error = function(e) return(0))
  n12 <- tryCatch(getElement(venn_nums, "R1:R2"), error = function(e) return(0)) + n123
  n13 <- tryCatch(getElement(venn_nums, "R1:R3"), error = function(e) return(0)) + n123
  n23 <- tryCatch(getElement(venn_nums, "R2:R3"), error = function(e) return(0)) + n123
  
  venn.plot <- draw.triple.venn(area1, area2, area3, n12, n23, n13, n123,
    category = my_cats,
    fill = my_cols,
    cex = 2,
    cat.cex = 2,
    fontfamily = rep(my_font, 7),
    cat.fontfamily = rep(my_font, 3))
  
  tiff(res = 300, height = 6, width = 7, units = "in",
    filename = my_filename, 
    compression = "lzw"
  );
  grid.draw(venn.plot)
  dev.off()
}


if (ncol(samples) == 2){
  R1 <- samples[,1]
  R2 <- samples[,2]
  
  R1 <- unique(R1[R1 != ""])
  R2 <- unique(R2[R2 != ""]) 
  
  new_list <- list(R1=R1, R2=R2)
  ItemsList <- gplots::venn(new_list, show.plot = FALSE)
  venn_nums <- lengths(attributes(ItemsList)$intersections)
  
  area1 <- length(R1)
  area2 <- length(R2)
  cross.area <- tryCatch(getElement(venn_nums, "R1:R2"), error = function(e) return(0))
  
  venn.plot <- draw.pairwise.venn(area1, area2, cross.area,
                                category = my_cats,
                                fill = my_cols,
                                cex = 2,
                                cat.cex = 2,
                                fontfamily = rep(my_font, 3),
                                cat.fontfamily = rep(my_font, 2))
  
  tiff(res = 300, height = 6, width = 7, units = "in",
       filename = my_filename, 
       compression = "lzw"
  );
  grid.draw(venn.plot)
  dev.off()
}

