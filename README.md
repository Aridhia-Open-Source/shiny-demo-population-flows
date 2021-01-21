# demo-population-flows

Circular visualisation showing world population movement.

## About the Chi-squared test app

This mini-app shows a circular visualisation of world population movement. 
You can explore the estimates of migration flows between and within regions for five-year periods, from 1990 to 2010.
This visualisation uses the R package ggvis. This app is a recreation of the interactive visualisation found in http://www.global-migration.info/.
The original visualisation uses d3 javascript library, thus offering more interactivity.
                       
On the right side-bar you can choose the year you want to display in the graph shown in the main panel.
To get quantitivative information about the flows, hover over elements in the plot. If you hover over on a region,
you will get information on flows from and to that specific region.

### Checkout and run

You can clone this repository by using the command:

```
git clone https://github.com/aridhia/demo-population-flows
```

Open the .Rproj file in RStudio and use `runApp()` to start the app.

### Deploying to the workspace

1. Create a new mini-app in the workspace called "chi-squared-test"" and delete the folder created for it
2. Download this GitHub repo as a .ZIP file, or zip all the files
3. Upload the .ZIP file to the workspace and upzip it inside a folder called "chi-squared-test"
4. Run the app in your workspace
