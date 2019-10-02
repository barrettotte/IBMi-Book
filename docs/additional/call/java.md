# Calling the IBMi with Java

Luckily, there is a pretty sweet package that exists called **JTOpen** found at http://jt400.sourceforge.net/ and
the maven repo at https://mvnrepository.com/artifact/net.sf.jt400/jt400/9.6

This package provides a bunch of awesome features to make interfacing with the IBMi easier.


## Example Program
To demonstrate communicating with the IBMi, we will be making a very simple java program.
It will connect to the IBMi, run a DB2 SQL statement, output the results, and close the connection.

This example uses the JT400 jar, **Gradle 4.10**, and Java 8.
I assume there shouldn't be too many differences if using Gradle 4.10+ or Java 8+, we're not doing anything too fancy.
Groovy can also be used instead of Java !


## Setup Gradle Project
To start, run ```gradle init``` to generate all of the good ole gradle junk.

Next, open the ```build.gradle``` and input the following snippet:
```groovy
// build.gradle

plugins {
    id 'java'
}
sourceCompatibility = '1.8'
targetCompatibility = '1.8'

repositories {
    mavenCentral()
}

dependencies {
    // https://mvnrepository.com/artifact/net.sf.jt400/jt400
    compile group: 'net.sf.jt400', name: 'jt400', version: '9.6'
}
```

Run a ```gradlew build --refresh-dependencies``` for good measure and it should download the JT400 jar from maven.



