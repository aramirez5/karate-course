Feature: Create Token

    Scenario: Create Token
        Given url apiUrl
        Given path 'users/login'
        And request {"user": {"email": "#(UserEmail)", "password": "#(UserPassword)"}}
        When method Post
        Then status 200
        * def authToken = response.user.token
        