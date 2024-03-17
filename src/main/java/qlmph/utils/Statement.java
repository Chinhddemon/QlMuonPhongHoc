package qlmph.utils;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.UUID;

public class Statement {

    public static void setUUIDRanDom(int count, PreparedStatement statement) throws SQLException {
        statement.setObject(count, UUID.randomUUID());
    }
    public static void setUUIDAllowsNull(int count, String string, PreparedStatement statement) throws SQLException {
        if( string == null ) {statement.setNull(count, Types.NULL);} 
        else {statement.setObject(count, UUID.fromString(string));}
    }
    public static void setUUIDNotNull(int count, String string, PreparedStatement statement) throws SQLException {
        statement.setObject(count, UUID.fromString(string));
    }

    public static void setVarcharAllowsNull(int count, String string, PreparedStatement statement) throws SQLException {
        if( string == null ) {statement.setNull(count, Types.VARCHAR);} 
        else {statement.setString(count, string);}
    }
    public static void setVarcharNotNull(int count, String string, PreparedStatement statement) throws SQLException {
        statement.setString(count, string);
    }

    public static void setNvarcharAllowsNull(int count, String string, PreparedStatement statement) throws SQLException {
        if( string == null ) {statement.setNull(count, Types.NVARCHAR);} 
        else {statement.setString(count, string);}
    }
    public static void setNvarcharNotNull(int count, String string, PreparedStatement statement) throws SQLException {
        statement.setString(count, string);
    }

    public static void setCharAllowsNull(int count, String string, PreparedStatement statement) throws SQLException {
        if( string == null ) {statement.setNull(count, Types.CHAR);} 
        else {statement.setString(count, string);}
    }
    public static void setCharNotNull(int count, String string, PreparedStatement statement) throws SQLException {
        statement.setString(count, string);
    }

    public static void setDateAllowsNull(int count, Date date, PreparedStatement statement) throws SQLException {
        if( date == null ) {statement.setNull(count, Types.DATE);} 
        else {statement.setDate(count, date);}
    }
    public static void setDateNotNull(int count, Date date, PreparedStatement statement) throws SQLException {
        statement.setDate(count, date);
    }

    public static void setDatetimeAllowsNull(int count, Timestamp timestamp, PreparedStatement statement) throws SQLException {
        if( timestamp == null ) {statement.setNull(count, Types.TIMESTAMP);} 
        else {statement.setTimestamp(count, timestamp);}
    }
    public static void setDatetimeNotNull(int count, Timestamp timestamp, PreparedStatement statement) throws SQLException {
        statement.setTimestamp(count, timestamp);
    }

    public static void setTinyintAllowsNull(int count, byte tinyint, PreparedStatement statement) throws SQLException {
        statement.setByte(count, tinyint);
    }
    public static void setBitNotNull(int count, byte tinyint, PreparedStatement statement) throws SQLException {
        statement.setByte(count, tinyint);
    }
}
