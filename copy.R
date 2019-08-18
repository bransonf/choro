# genereates copy

instruction_copy <- HTML("Welcome to Choro, a web application for making choropleth maps.
                         <img src='poverty_example.png' height='400px'>
                         <h3>Exploring the Data</h3>
                         <h4>Navigating Options</h4>
                         <p>First, select a survey you would like to make a map with. Then, choose a year. The latest year is chosen by default.
                         (Tip: SF-1 and SF-3 are versions of the Decennial Census.) Next, pick a region and geography. Next, you will have to
                         define a calculation (see next section) and finally you can experiment with color palettes.</p>
                         
                         <h4>Writing Queries</h4>
                         
                         <p>For increased flexibility, this app allows you to define your own variables. In many circumstances it makes sense to map proportions rather
                         than counts. Or, maybe you want to normalize by rate per thousand, or display income on a log scale.
                         Any valid R code can be evaluated to create a new variable, so long as it follows this format:
                         
                         &lt;variable name&gt; = &lt;variable expression&gt;
                         where &lt;variable name&gt; is only alphanumeric (no spaces, no _, etc.) and preceeds the = sign. The expression after must contain at least one
                         valid variable from the selected dataset, but there is a virtually limitless ability to further customize calculations.
                         </p>
                         <h4>Valid Queries</h4>
                         <h5>ACS Data</h5>
                         <li>NonWhitePop = 1 - B02001_002/B02001_001</li>
                         <li>MedianIncome = B19013_001/1000</li>
                         <li>LogIncome = log(B19013_001)</li>
                         <li>Poverty = B17001_002/B17001_001</li>
                         <h5>Decennial</h5>
                         <li>RentedUnits = H004004/H004001</li>
                         <li>AsianPop = P008006/P008001</li>
                         <li>MedianAge = P013001</li>
                         
                         
                         <h4>Color Scales</h4>
                         
                         <p>This App currently supports the Viridis and ColorBrewer palettes. For those who aren't familiar, both Viridis and ColorBrewer
                         palettes were designed with accessibiliy in mind. Both are designed to be color-blind accessible. Read more about <a href='https://cran.r-project.org/web/packages/viridis/', target='_blank'>Viridis</a> and <a href='http://colorbrewer2.org', target='_blank'>ColorBrewer</a></p>
                         <center><h5>Viridis</h5></center>
                         <center><img src='viridis.png' height = '200px'></center>
                         <center><h5>Color Brewer</h5></center>
                         <Center><img src='colorBrewer.jpg' height = '200px'></center>
                         
                         <h3>About this Application</h3>
                         <p>This is a small project that I began to simplify the process of making maps in R. That is also why this entire application is
                         made using R Shiny. Urban Institute made a <a href='https://medium.com/@urban_institute/building-a-point-and-click-mapping-tool-in-r-shiny-7aa4e99ac913' target='_blank'>similar application</a> for internal use, but I'm imagining much broader applications of the concept. 
                         In its current form, the project is ostensibly just a UI for tidycensus and a little ggplot2.
                         
                         No promises that I will continue to develop this unless there is strong cause for use, but I'm brainstorming features.
                         <li>Add Custom Data (Full Shapefile/geoJSON Support)</li>
                         <li>Basic Data Manipulation (Filter, Join, Etc.)</li>
                         <li>More Specific Map Parameters</li>
                         <li>Customized Downloads</li>
                         <li>Custom Color Palettes</li>
                         <li>Squashing Bugs</li>
                         </p>
                         
                         <p>All of the code for this project is made open source with the hopes that others will contribute or reuse code for similar projects. For bugs or feature requests, please use <a href='https://github.com/bransonf/choro', target='_blank'>GitHub</a>.</p>
                         
                         
                         ")