# Happy-Camp-Database
This is a database I created using fictional data about a camp. The database is designed as a relational database with functions, queries, stored procedures, and views built in. The database also has forms that were built using visual studio code.
# How to Build
-- Happy Camp ReadMe by Jacob Weiss --

-- Created on: 6/1/2022 --

-- This file contains the instructions for working with Happy Camp --


-- CREATE the DATABASE, VIEW, FUNCTIONS, QUERIES, and STORED PROCEDURES --
1. Unzip the HappyCampDatabase File
2. Open the BuildHappyCamp.sql script in SSMS.
3. Edit the @data_path to be the folder with the csv files.
4. EXECUTE the build script
5. Open the BuildHappyCampView.sql script in SSMS
6. EXECUTE the view script 
7. Open the HappyCampScript.sql script in SSMS
8. EXECUTE the view script 

-- RUNNING the Startup Form form --
1. Navigate to the Project Happy Camp VS Forms folder and then the Happy Camp Forms folder
2. Open the HappyCamp.sln file using Visual Studio
3. Click on My Project and change the Startup Form to be Startup.
4. START the Startup Form
5. Click on Staff form button to open the staff form.
6. Press the add button to add a new staff member. YOU MUST TYPE all information in manually and when finished save the information. 
7. Search for your Weiss in the search box and it should show the person does not exist.
8. Use the reset button to reset to form.
9. Click on close to go back to the Startup Form.
10. Click on the Parent Sub Form Button to open the Parent Sub Form
11. Press the add button to add a new Parent. YOU MUST TYPE all information in manually and when finished save the information. ALL STATE NAMES MUST BE 2 LETTERS ex Colorado = CO
12. Click on the registration datagrid box to autogenerate a new primary key date. Select a camper from the dropdown the parent registers and save the information.
13. Search for your Weiss in the search box and it should show the person does not exist.
14. Use the reset button to reset to form.
15. Click on close to go back to the Startup Form.
16. Click on the Camper form button to open the camper form
17. Press the add button to add a new Camper. YOU MUST TYPE all information in manually and when finished save the information. ALL STATE NAMES MUST BE 2 LETTERS ex Colorado = CO
18. Search for your 4567 in the search box and it should show the ID does not exist.
19. Use the reset button to reset to form.
20. Click on close to go back to the Startup Form.
21. Click on the search form button to open the search form
22. Move the start date back to any date in January 2018. Move the end date back to any date in December 2018.
23. Click search and it should appear that no entries exist for that time frame.
24. Click on close to go back to the Startup Form.


-- RUNNING the Staff Unit Report --
1. Click on the solutions explorer and go down to Reports phase 3.
2. Click on the staff unit report.
3. Click on the preview tab
4. Select one or many of the Unit Age groups and press View report
5. This will show the staff members, their contact numbers, unit name and contract sign date working with this age group.
6. Exit out of the form.

   
-- RUNNING the Camper Unit Report --
1. Click on the solutions explorer and go down to Reports phase 3.
2. Click on the staff unit report.
3. Click on the preview tab
4. Click the drop down for a different unit
5. This will show the quarter the different campers could register, amount of people registered in that quarter, and the profit the camp generated from the unit that quarter
6. Select a dropdown for a specific quarter and the camper name and time and date registed will appear from campers that registered that quarter
7. Exit out of the form.

