Feature: Articles

    Background: Define url
        * url apiUrl
        * def articleRequestBody = read ('classpath:conduitApp\\json\\newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
        * set articleRequestBody.description.title = dataGenerator.getRandomArticleValues().description
        * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

    @debug
    Scenario: Create a new article
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        And match response.article.title == articleRequestBody.article.title

    Scenario: Create and delete article
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given params { limit: 10, offset:0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == articleRequestBody.article.title

        Given path 'articles', articleId
        When method Delete
        Then status 204

        Given params { limit: 10, offset:0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title