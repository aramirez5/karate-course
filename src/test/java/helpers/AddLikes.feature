Feature: Add likes

    Background: Define url
        Given url apiUrl

    Scenario: Given path 'articles'
        Given path 'articles', slug, 'favorite'
        And request {}
        When method Post
        Then status 201
        * def likesCount = response.article.favoritesCount
