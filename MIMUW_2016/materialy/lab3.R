# Lab 3 - Statistics 2

## Plots with ggplot

1. Choose the `auta2012` dataset and select only 5 Brands (it's up to you which one)

2. Create a barplot (geom_bar) with information about number of cars for each Brand

3. Create a barplot (geom_bar) with information about number of cars for each combination of Brand and type of fuel

4. Create a point plot (geom_point) with information about relation between Price and Mileage

5. Add curve with smoothed trend (geom_sooth) with information about weighted LOESS average

6. Present distribution of Price in groups defined by Brand. Compare plots with histogram (geom_histogram), 
boxplot (geom_boxplot), vioplots (geom_violin).
Which tool is better?

7. Compare plots for different transformations of the variable (log / sqrt). (see: scale_y_sqrt)

8. Create a plot with more than one layer. Merge for example geom_point and geom_smooth. 
Or geom_point and geom_boxplot.

9. Choose different themes. Start with theme_bw(). Then try to remove legend from the plot.

10. Use facets in order to generate different views for different Brands (start with facet_wrap)

