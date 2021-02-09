# Population Flows

This RShiny mini-app shows a circular visualisation of world population movement. It allows you to explore the estimates of migration flows between and within regions from 1990 to 2010, in five-year periods. The data shows bilateral flows between 196 countries, it captures the number of people who changed their country of residence over five-year periods.

This app is a recreation of the interactive visualisation found in http://www.global-migration.info/, from this same site you will find the data used. This visualisation tool uses the R package ggvis, while the original used d3 javascript library, thus offering more interactivity.
                       
The graph is shown in the main panel, using the right-hand side-bar you can change the year being displayed. To get quantitative information about the flows, hover over elements in the plot. If you hover over on a region, you will get information on flows from and to that specific region.

### Checkout and run

You can clone this repository by using the command:

```
git clone https://github.com/aridhia/demo-population-flows
```

Open the .Rproj file in RStudio and use `runApp()` to start the app.

### Deploying to the workspace

1. Create a new mini-app in the workspace called "population-flows"" and delete the folder created for it
2. Download this GitHub repo as a .ZIP file, or zip all the files
3. Upload the .ZIP file to the workspace and upzip it inside a folder called "population-flows"
4. Run the app in your workspace
