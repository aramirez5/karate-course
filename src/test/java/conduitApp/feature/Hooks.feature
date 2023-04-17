Feature: Hooks

    Background: Hooks
        # * def result = callonce read('classpath:helpers/Dummy.feature')
        # * def username = result.username

        # After hooks
        # * configure afterFeature = function(){ karate.call('classpath:helpers/Dummy.feature') }
        * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }
        * configure afterFeature =
        """
            function() {
                karate.log('After Feature Text')
            }
        """

    Scenario: First scenario
        # * print username
        * print 'This is the first scenario'

    Scenario: Second scenario
        # * print username
        * print 'This is the second scenario'