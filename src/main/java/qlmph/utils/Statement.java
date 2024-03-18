package qlmph.utils;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.UUID;

public class Statement {

    public static void setUUIDRanDom(int index, PreparedStatement statement) throws SQLException {
        statement.setObject(index, UUID.randomUUID());
    }
    public static void setUUIDAllowsNull(int index, String string, PreparedStatement statement) throws SQLException {
        if( string == null ) {statement.setNull(index, Types.NULL);} 
        else {statement.setObject(index, UUID.fromString(string));}
    }
    public static void setUUIDNotNull(int index, String string, PreparedStatement statement) throws SQLException {
        statement.setObject(index, UUID.fromString(string));
    }

    public static void setVarcharAllowsNull(int index, String string, PreparedStatement statement) throws SQLException {
        if( string == null ) {statement.setNull(index, Types.VARCHAR);} 
        else {statement.setString(index, string);}
    }
    public static void setVarcharNotNull(int index, String string, PreparedStatement statement) throws SQLException {
        statement.setString(index, string);
    }

    public static void setNvarcharAllowsNull(int index, String string, PreparedStatement statement) throws SQLException {
        if( string == null ) {statement.setNull(index, Types.NVARCHAR);} 
        else {statement.setString(index, string);}
    }
    public static void setNvarcharNotNull(int index, String string, PreparedStatement statement) throws SQLException {
        statement.setString(index, string);
    }

    public static void setCharAllowsNull(int index, String string, PreparedStatement statement) throws SQLException {
        if( string == null ) {statement.setNull(index, Types.CHAR);} 
        else {statement.setString(index, string);}
    }
    public static void setCharNotNull(int index, String string, PreparedStatement statement) throws SQLException {
        statement.setString(index, string);
    }

    public static void setDateAllowsNull(int index, Date date, PreparedStatement statement) throws SQLException {
        if( date == null ) {statement.setNull(index, Types.DATE);} 
        else {statement.setDate(index, date);}
    }
    public static void setDateNotNull(int index, Date date, PreparedStatement statement) throws SQLException {
        statement.setDate(index, date);
    }

    public static void setDatetimeAllowsNull(int index, Timestamp timestamp, PreparedStatement statement) throws SQLException {
        if( timestamp == null ) {statement.setNull(index, Types.TIMESTAMP);} 
        else {statement.setTimestamp(index, timestamp);}
    }
    public static void setDatetimeNotNull(int index, Timestamp timestamp, PreparedStatement statement) throws SQLException {
        statement.setTimestamp(index, timestamp);
    }

    public static void setTinyintAllowsNull(int index, byte tinyint, PreparedStatement statement) throws SQLException {
        statement.setByte(index, tinyint);
    }
    public static void setTinyintNotNull(int index, byte tinyint, PreparedStatement statement) throws SQLException {
        statement.setByte(index, tinyint);
    }
}
