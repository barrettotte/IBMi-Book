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
            "FROM QSYS2.SYSPARTITIONSTAT WHERE TABLE_SCHEMA = 'OTTEB1' ORDER BY TABLE_PARTITION";
        
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