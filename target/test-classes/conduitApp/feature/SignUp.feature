Feature: Sign up a new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        Given url apiUrl

    Scenario: New user sign up
        # Given def userData = {"email": "karate78990@test78990.com", "username": "karate78990test78990"}
        Given path 'users'
        And request 
        """
        {
            "user": {
                //"email": #(userData.email),
                "email": #(randomEmail),
                "password": "123456",
                "username": #(randomUsername)
                //"username": #(userData.username)
            }
        }
        """
        When method Post
        Then status 200
        And match response ==
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "username": #(randomUsername),
                    "bio": null,
                    "image": '#string',
                    "token": '#string'
                }
            }
    """

    Scenario Outline: Validate sign up error messages
        Given path 'users'
        And request 
        """
        {
            "user": {
                "email": "<email>",
                "password": "<password>",
                "username": "<username>"
            }
        }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>
             
        Examples:
            | email                | password  | username                  | errorResponse                                          |
            | #(randomEmail)       | Karate123 | KarateUser123             | {"errors": {"username": ["has already been taken"]}}   |
            | KarateUser1@test.com | Karate123 | #(randomUsername)         | {"errors": {"email": ["has already been taken"]}}      |
            |                      | Karate123 | #(randomUsername)         | {"errors": {"email": ["can't be blank"]}}              |
            | #(randomEmail)       |           | #(randomUsername)         | {"errors": {"password": ["can't be blank"]}}           |
            | #(randomEmail)       | Karate123 |                           | {"errors": {"username": ["can't be blank"]}}           |
