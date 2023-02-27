package controller;

import connector.ConnectionMaker;
import model.MovieDTO;
import model.TheaterDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TheaterController {
    private Connection connection;
    public TheaterController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }

    public ArrayList<TheaterDTO> selectAll(){
        ArrayList<TheaterDTO> list = new ArrayList<>();

        String query = "select * from theater";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);

            ResultSet resultSet = pstmt.executeQuery();
            while(resultSet.next()){
                TheaterDTO t = new TheaterDTO();
                t.setId(resultSet.getInt("id"));
                t.setName(resultSet.getString("name"));
                t.setLocation(resultSet.getString("location"));
                t.setTel(resultSet.getString("tel"));

                list.add(t);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return list;
    }

    public TheaterDTO selectOne(int id){
        TheaterDTO t = null;
        String query = "select * from theater where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1,id);

            ResultSet resultSet = pstmt.executeQuery();
            if(resultSet.next()){
                t = new TheaterDTO();
                t.setId(resultSet.getInt("id"));
                t.setName(resultSet.getString("name"));
                t.setLocation(resultSet.getString("location"));
                t.setTel(resultSet.getString("tel"));
            }

            resultSet.close();
            pstmt.close();
        } catch(Exception e){
            e.printStackTrace();
        }

        return t;
    }



    public void insert(TheaterDTO theaterDTO){
        String query = "INSERT INTO `moviedb`.`theater` (`name`, `location`, `tel`) VALUES (?,?,?);";

        try{
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1,theaterDTO.getName());
            pstmt.setString(2,theaterDTO.getLocation());
            pstmt.setString(3, theaterDTO.getTel());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
    }

















}













