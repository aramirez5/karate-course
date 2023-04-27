<p align="center">
  <img alt="Cypress" src="https://www.softwaretestinghelp.com/wp-content/qa/uploads/2020/08/The-Karate-Framework.png">
</p>

![Framework](https://img.shields.io/badge/Framework-Karate-orange) ![Lenguaje](https://img.shields.io/badge/Lenguaje-Java-blue) ![Licencia](https://img.shields.io/badge/Licencia-MIT-green)

## What is karate-course ? 🥋

<b>karate-course</b> is a project that contains tests made with the Karate framework

## Building and installation 🔧

To build and install this project, follow these steps:

1. First you need to clone this other project

https://github.com/bondar-artem/angular-realworld-example-app/tree/node18compatible

2. Install yarn in your system

https://classic.yarnpkg.com/lang/en/docs/install/#windows-stable

3. Install yarn in the project

```sh
yarn install
```

4. Run the project. We need it because is the endpoint of the karate tests

```sh
npm start
```

5. Finally, in the other hand, clone this repository and run the karate tests. I recommend use the debug option if you don't want to execute all suite tests 

```sh
mvn test -Dkarate.options="--tags @debug"
```

## Additional Information 💡

To create a new karate project from scratch you can launch these instructions and thus create the base folder structure. If you're on Windows, replace the backslashes with circumflexes ^

```sh
mvn archetype:generate \
-DarchetypeGroupId=com.intuit.karate \
-DarchetypeArtifactId=karate-archetype \
-DarchetypeVersion=1.3.1 \
-DgroupId=demo \
-DartifactId=karate
```


## Contribution 🤝

 If you want to contribute to this project, follow these steps:

1. Make a fork of this repository.

2. Create a branch for your changes.

3. Make the necessary changes.

4. Submit a pull request.

## License 📝 

This project is distributed under the ISC license.

## Status 🚀 

This project is currently finished, but new tests can be added at any time. If you find any errors or problems, please open an issue so it can be fixed.