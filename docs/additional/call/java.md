# Calling IBM i with Java

Luckily, there is a pretty sweet package called **JTOpen** found at http://jt400.sourceforge.net/ and 
https://mvnrepository.com/artifact/net.sf.jt400/jt400/9.6

The package provides a bunch of awesome features to make interfacing with IBM i easier.
This example will only use it to run a DB2 SQL statement.


## Example Program
To demonstrate communicating with IBM i, we will be making a very simple java program.
It will connect to IBM i, run a DB2 SQL statement, output the results, and close the connection.

The SQL execution will return a resultset of source members found in all PFs within a targeted library.

This example uses the JT400 jar, **Gradle 4.10**, and Java 8.
I assume there shouldn't be too many differences if using Gradle 4.10+ or Java 8+, we're not doing anything too fancy.

Its worth mentioning that **Groovy** can also be used instead of Java !


## Setup Gradle Project
To start a new gradle project, run ```gradle init``` to generate all of the good ole gradle junk.

Next, open the ```build.gradle``` and input the following script:
```groovy
// build.gradle

apply plugin: 'java'
apply plugin: 'application'
apply plugin: 'eclipse'
apply plugin: 'idea'

sourceCompatibility = '1.8'
targetCompatibility = '1.8'

mainClassName = 'com.example.ibmi.Example'
sourceSets.main.java.srcDirs = ['src']

repositories {
    mavenCentral()
}

dependencies {
    implementation('net.sf.jt400:jt400:9.6') // https://mvnrepository.com/artifact/net.sf.jt400/jt400
}
```

<br>

This will handle the JT400 jar dependency and running our java application.


Now setup the folder structure, I made mine very basic.  
Create the paths ```src/main/com/example/ibmi/``` and ```src/main/resources/```


## Configuration
To make sure credentials aren't hardcoded in the program itself, I made use of a properties file in resources.
Create the file ```src/main/resources/application.properties``` with the following information:

```groovy
// application.properties

ibmi.host=YOURHOST
ibmi.user=YOURUSER
ibmi.pwd=YOURPASSWORD
```


## Main Class
This program could have been multiple classes, but lets just make one big one for the sake of simplicity.
Create the file ```src/main/com/example/ibmi/Example.java``` with the following content(for now):
```java
// Example.java

package com.example.ibmi;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import com.ibm.as400.access.AS400JDBCDriver;

public class Example {

    public static void main(String[] args){
        final Example ex = new Example();
        ex.classLoad("com.ibm.as400.access.AS400JDBCDriver"); // ensure class is loaded
        System.out.println("It worked!");
    }

    private void classLoad(final String s){
        try{
            Class.forName(s);
        } catch(final ClassNotFoundException e) {
            System.out.println(s + " could not be found. " + e);
            System.exit(0);
        }
    }
}
```

<br>

Run ```gradlew clean run --refresh-dependencies``` to ensure that the JT400 jar is successfully fetched.
Hopefully, it ran with no problems and you see that "It worked!" was outputted to console.

<br>

Next, we're going to add the shell for handling a connection/resultset and reading a config file to the main method.
```java
// Example.java

public static void main(String[] args){
    final Example ex = new Example();
    final Properties cfg = ex.getAS400Config();           // Get IBM i credentials
    ex.classLoad("com.ibm.as400.access.AS400JDBCDriver"); // Ensure class is loaded

    final String sql = "SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE " +
        "FROM QSYS2.SYSPARTITIONSTAT " +
        "WHERE TABLE_SCHEMA = 'YOURUSER' " + // CHANGE TO YOUR USER
        "ORDER BY TABLE_PARTITION";
    
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;
    try{
        // TODO
    }
    catch(final Exception e){
        e.printStackTrace();
    }
    finally{
        // Safely close open objects
        if(rs   != null){ try{   rs.close(); } catch(final SQLException sqle){} }
        if(st   != null){ try{   st.close(); } catch(final SQLException sqle){} }
        if(conn != null){ try{ conn.close(); } catch(final SQLException sqle){} }
    }

    // Read properties file from resources
    private Properties getAS400Config(){
        Properties props = null;
        try(InputStream input = Example.class.getClassLoader().getResourceAsStream("application.properties")){
            props = new Properties();
            props.load(input);
        } catch(final Exception e){
            e.printStackTrace();
            System.exit(0);
        }
        return props;
    }
}
```

<br>

Next, make two utility methods. The first is for creating the SQL connection to IBM i using the credentials from the properties file that was loaded. The second is a simple method for printing a resultset to the console.

```java
// Example.java

// Setup AS400 JDBC connection using properties file
private Connection setupAS400Connection(final Properties config){
    Connection conn = null;
    try{
        final String url = "jdbc:as400://" + 
            config.getProperty("ibmi.host") + ";naming=system;prompt=false;*LIBL";
        conn = DriverManager.getConnection(url, config.getProperty("ibmi.user"), config.getProperty("ibmi.pwd"));
    } 
    catch(final Exception e){
        e.printStackTrace();
        System.exit(0);
    }
    return conn;
}

// Print result set to console
private void printResultSet(final ResultSet rs) throws SQLException{
    final ResultSetMetaData rsmd = rs.getMetaData();
    final int colCount = rsmd.getColumnCount();
    for(int i = 1; i <= colCount; i++){
        if(i > 1){
            System.out.print(", ");
        }
        System.out.print(rsmd.getColumnName(i));
    }
    System.out.println("");
    while(rs.next()){
        for(int i = 1; i <= colCount; i++){
            if(i > 1){
                System.out.print(", ");
            }
            System.out.print(rs.getString(i));
        }
        System.out.println("");
    }
}
```

<br>

Add the create connection method call to the main method:

```java
// Example.java

public static void main(String[] args){
    final Example ex = new Example();
    final Properties cfg = ex.getAS400Config();
    ex.classLoad("com.ibm.as400.access.AS400JDBCDriver");
        
    final String sql = "SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE " +
        "FROM QSYS2.SYSPARTITIONSTAT " +
        "WHERE TABLE_SCHEMA = 'YOURUSER' " + // CHANGE TO YOUR USER
        "ORDER BY TABLE_PARTITION";
        
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;
    try{
        conn = ex.setupAS400Connection(cfg); // ADD ME
    }
    catch(final Exception e){
        e.printStackTrace();
    }
    finally{
        if(rs   != null){ try{   rs.close(); } catch(final SQLException sqle){} }
        if(st   != null){ try{   st.close(); } catch(final SQLException sqle){} }
        if(conn != null){ try{ conn.close(); } catch(final SQLException sqle){} }
    }
}
```

<br>

After all that setup, now we're going to query IBM i with the SQL string that's been hanging out doing nothing.
The three new lines just query IBM i and print the resultset to console.
```java
// Example.java

public static void main(String[] args){
    final Example ex = new Example();
    final Properties cfg = ex.getAS400Config();
    ex.classLoad("com.ibm.as400.access.AS400JDBCDriver");
        
    final String sql = "SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE " +
        "FROM QSYS2.SYSPARTITIONSTAT " +
        "WHERE TABLE_SCHEMA = 'YOURUSER' " + // CHANGE TO YOUR USER
        "ORDER BY TABLE_PARTITION";
        
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;
    try{
        conn = ex.setupAS400Connection(cfg);
        st = conn.createStatement();            // ADD ME
        rs = st.executeQuery(sql);              // ADD ME
        ex.printResultSet(rs);                  // ADD ME
    }
    catch(final Exception e){
        e.printStackTrace();
    }
    finally{
        if(rs   != null){ try{   rs.close(); } catch(final SQLException sqle){} }
        if(st   != null){ try{   st.close(); } catch(final SQLException sqle){} }
        if(conn != null){ try{ conn.close(); } catch(final SQLException sqle){} }
    }
}
```


## Result
The application will output the source members found in all PFs within the library specified in the hardcoded SQL string.

Run the application using ```gradlew clean run``` and if all went well you should see something similar to this:
```
> Task :run
TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE
OTTEB1, QCLLESRC, CLFIZZBUZZ, CLLE
OTTEB1, QCLLESRC, ECHO, CLLE
OTTEB1, QCMDSRC, FIZZBUZZ, CMD
OTTEB1, QRPGLESRC, HELLORPGLE, RPGLE
OTTEB1, QCLLESRC, PARMTEST, CLLE
OTTEB1, QDDSSRC, TODOITEMS, PF
OTTEB1, TODOITEMS, TODOITEMS, null
OTTEB1, QDDSSRC, TODOITLBL1, LF
OTTEB1, QDDSSRC, TODOITSTS1, LF
OTTEB1, QDDSSRC, TODOLABELS, PF
OTTEB1, TODOLABELS, TODOLABELS, null
OTTEB1, QRPGLESRC, TODOLIST, SQLRPGLE
OTTEB1, QDDSSRC, TODOSTATUS, PF
OTTEB1, TODOSTATUS, TODOSTATUS, null
```

<br>

## Full Source
```java
// Example.java

package com.example.ibmi;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import com.ibm.as400.access.AS400JDBCDriver;

public class Example {

    public static void main(String[] args){
        final Example ex = new Example();
        final Properties cfg = ex.getAS400Config();
        ex.classLoad("com.ibm.as400.access.AS400JDBCDriver");
        
        final String sql = "SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE " +
            "FROM QSYS2.SYSPARTITIONSTAT WHERE TABLE_SCHEMA = 'YOURUSER' ORDER BY TABLE_PARTITION";
        
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try{
            conn = ex.setupAS400Connection(cfg);
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            ex.printResultSet(rs);
        }
        catch(final Exception e){
            e.printStackTrace();
        }
        finally{
            if(rs   != null){ try{   rs.close(); } catch(final SQLException sqle){} }
            if(st   != null){ try{   st.close(); } catch(final SQLException sqle){} }
            if(conn != null){ try{ conn.close(); } catch(final SQLException sqle){} }
        }
    }

    private void printResultSet(final ResultSet rs) throws SQLException{
        final ResultSetMetaData rsmd = rs.getMetaData();
        final int colCount = rsmd.getColumnCount();
        for(int i = 1; i <= colCount; i++){
            if(i > 1){
                System.out.print(", ");
            }
            System.out.print(rsmd.getColumnName(i));
        }
        System.out.println("");
        while(rs.next()){
            for(int i = 1; i <= colCount; i++){
                if(i > 1){
                    System.out.print(", ");
                }
                System.out.print(rs.getString(i));
            }
            System.out.println("");
        }
    }

    private void classLoad(final String s){
        try{
            Class.forName(s);
        } catch(final ClassNotFoundException e) {
            System.out.println(s + " could not be found. " + e);
            System.exit(0);
        }
    }

    private Connection setupAS400Connection(final Properties config){
        Connection conn = null;
        try{
            final String url = "jdbc:as400://" + 
                config.getProperty("ibmi.host") + ";naming=system;prompt=false;*LIBL";
            conn = DriverManager.getConnection(url, config.getProperty("ibmi.user"), config.getProperty("ibmi.pwd"));
        } 
        catch(final Exception e){
            e.printStackTrace();
            System.exit(0);
        }
        return conn;
    }

    private Properties getAS400Config(){
        Properties props = null;
        try(InputStream input = Example.class.getClassLoader().getResourceAsStream("application.properties")){
            props = new Properties();
            props.load(input);
        } catch(final Exception e){
            e.printStackTrace();
            System.exit(0);
        }
        return props;
    }
}
```