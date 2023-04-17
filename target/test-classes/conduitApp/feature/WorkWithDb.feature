Feature: Work with database

    Background: Connect to database
        * def dbHandler = Java.type('helpers.DbHandler')
    
    Scenario: Seed database with a new job
        * eval dbHandler.addNewJobWithName("QA3")

    @debug 
    Scenario: Get level for job
        * def level = dbHandler.getMinAndMaxLevelsForJob("QA3")
        * print level.minLvl
        * print level.maxLvl
        And match level.minLvl == '80'
        And match level.maxLvl == '120'