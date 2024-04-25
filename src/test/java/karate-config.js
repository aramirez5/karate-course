function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.UserEmail = 'karate1@test1.com'
    config.UserPassword = '123456'
  }
  if (env == 'qa') {
    config.UserEmail = 'karate1@qa1.com'
    config.UserPassword = 'abcde'
  }

  var accessToken = karate.callSingle('./helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {authorization: 'Token ' + accessToken})

  return config;
}