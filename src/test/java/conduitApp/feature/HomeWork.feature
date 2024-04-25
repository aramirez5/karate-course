
Feature: Home Work

    Background: Preconditions
        * def articleFavorite = read ('classpath:conduitApp\\json\\favoriteArticle.json')
        * def newComment = read ('classpath:conduitApp\\json\\newComment.json')
        * def timeValidator = read('classpath:helpers\\timeValidator.js')
        Given url apiUrl 

    # Alert: It is needed to dislike the article in each run
    Scenario: Favorite articles
        # Step 1: Get atricles of the global feed
        Given path 'articles'
        # Step 2: Get the favorites count and slug ID for the first article, save it to variables
        When method Get
        Then status 200
        * def articleId = response.articles[0].slug
        * def favoriteCount = response.articles[0].favoritesCount
        # Step 3: Make POST request to increse favorites count for the first article
        Given path 'articles', articleId, '/favorite'
        And request articleFavorite
        When method Post
        Then status 201
        # Step 4: Verify response schema
        And match response == 
        """
        {
            "article": {
                "id": '#number',
                "slug": '#string',
                "title": '#string',
                "description": '#string',
                "body": '#string',
                "createdAt": '#? timeValidator(_)',
                "updatedAt": '#? timeValidator(_)',
                "authorId": '#number',
                "tagList": '#array',
                "author": {
                    "username": '#string',
                    "bio": '##string',
                    "image": '#string',
                    "following": '#boolean'
                },
                "favoritedBy": [
                    {
                        "id": '#number',
                        "email": '#string',
                        "username": '#string',
                        "password": '#string',
                        "image": '#string',
                        "bio": '##string',
                        "demo": '#boolean'
                    }
                ],
                "favorited": '#boolean',
                "favoritesCount": '#number'
            }
        }
        """
        # Step 5: Verify that favorites article incremented by 1
        And match response.article.favoritesCount == favoriteCount + 1
        # Step 6: Get all favorite articles
        Given params { favorited: 'karate1_test', limit: 10, offset:0 }
        Given path 'articles'
        When method Get
        Then status 200
        # Step 7: Verify response schema
        And match response == 
        """
        {
            "articles": [
                {
                    "slug": '#string',
                    "title": '#string',
                    "description": '#string',
                    "body": '#string',
                    "tagList": '#array',
                    "createdAt": '#? timeValidator(_)',
                    "updatedAt": '#? timeValidator(_)',
                    "favorited": '#boolean',
                    "favoritesCount": '#number',
                    "author": {
                        "username": '#string',
                        "bio": '##string',
                        "image": '#string',
                        "following": '#boolean'
                    }
                }
            ],
            "articlesCount": '#number'
        }
        """
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
        And match response.articles[0].slug == articleId
   
    # Alert: It is needed to have at least one comment in an article
    Scenario: Comment articles
        # Step 1: Get atricles of the global feed
        Given path 'articles'
        When method Get
        Then status 200
        # Step 2: Get the slug ID for the first article, save it to variable
        * def articleId = response.articles[0].slug
        # Step 3: Make a GET call to 'comments' end-point to get all comments
        Given path 'articles', articleId, '/comments'
        When method Get
        Then status 200
        # Step 4: Verify response schema
        And match each response.comments == 
        """
        {
            "id": '#number',
            "createdAt": '#? timeValidator(_)',
            "updatedAt": '#? timeValidator(_)',
            "body": '#string',
            "author": {
                "username": '#string',
                "bio": '##string',
                "image": '#string',
                "following": '#boolean'
            }
        }       
        """
        # Step 5: Get the count of the comments array lentgh and save to variable
        * def commentsCount = response.comments.length
        # Step 6: Make a POST request to publish a new comment
        Given path 'articles', articleId, '/comments'
        And request newComment
        When method Post
        Then status 201
        And match response ==
        # Step 7: Verify response schema that should contain posted comment text
        """
            {
                "comment": {
                    "id": '#number',
                    "createdAt": '#? timeValidator(_)',
                    "updatedAt": '#? timeValidator(_)',
                    "body": '#string',
                    "author": {
                        "username": '#string',
                        "bio": '##string',
                        "image": '#string',
                        "following": '#boolean'
                    }
                }
            }    
        """
        # Step 8: Get the list of all comments for this article one more time
        Given path 'articles', articleId, '/comments'
        When method Get
        Then status 200
        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
        And match Number(response.comments.length) == commentsCount + 1 
        # # Step 10: Make a DELETE request to delete comment
        * def commentId = response.comments[0].id
        Given path 'articles', articleId, '/comments', commentId
        When method Delete
        Then status 204
        # # Step 11: Get all comments again and verify number of comments decreased by 1
        Given path 'articles', articleId, '/comments'
        When method Get
        Then status 200
        And match Number(response.comments.length) == commentsCount
    