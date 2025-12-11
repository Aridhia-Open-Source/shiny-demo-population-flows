# Population Flows

This R web app shows a circular visualisation of world population movement. It allows you to explore the estimates of migration flows between and within regions from 1990 to 2010, in five-year periods. The data shows bilateral flows between 196 countries, it captures the number of people who changed their country of residence over five-year periods.

This app is a recreation of the interactive visualisation found in http://www.global-migration.info/, from this same site you will find the data used. This visualisation tool uses the R package ggvis, while the original used d3 javascript library, thus offering more interactivity.
                       
The graph is shown in the main panel, using the right-hand side-bar you can change the year being displayed. To get quantitative information about the flows, hover over elements in the plot. If you hover over on a region, you will get information on flows from and to that specific region.

### Checkout and run

You can clone this repository by using the command:

```
git clone https://github.com/Aridhia-Open-Source/shiny-demo-population-flows
```

Open the .Rproj file in RStudio and use `runApp()` to start the app.

### Deploying to the workspace

1. Download this GitHub repo as a .zip file.
2. Create a new blank R web app in your workspace called "population-flows".
3. Navigate to the `population-flows` folder under "files".
4. Delete the `app.R` file from the `population-flows` folder. Make sure you keep the `.version` file!
5. Upload the .zip file to the `population-flows` folder.
6. Extract the .zip file. Make sure "Folder name" is blank and "Remove compressed file after extracting" is ticked.
7. Navigate into the unzipped folder.
8. Select all content of the unzipped folder, and move it to the `population-flows` folder (so, one level up).
9. Delete the now empty unzipped folder.
10. Start the R console and run the `dependencies.R` script to install all R packages that the app requires.
11. Run the app in your workspace.

For more information visit https://knowledgebase.aridhia.io/article/how-to-upload-your-mini-app/
