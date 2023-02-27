package controller;

import connector.ConnectionMaker;
import model.RatingDTO;

import java.sql.*;
import java.util.ArrayList;

public class RatingController {
    private Connection connection;
    public RatingController(ConnectionMaker connectionMaker){
        this.connection = connectionMaker.makeConnection();
    }

    public ArrayList<RatingDTO> selectAll(int movieId){
        ArrayList<RatingDTO> tmp = new ArrayList<>();
        String query = "select * from rating where movieId = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, movieId);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                RatingDTO r = new RatingDTO();
                r.setId(resultSet.getInt("id"));
                r.setWriteId(resultSet.getInt("writerId"));
                r.setScore(resultSet.getFloat("score"));
                r.setReview(resultSet.getString("review"));

                tmp.add(r);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tmp;
    }



    public void delete(int id){
        String query = "delete from rating where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1,id);
            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void insert(RatingDTO ratingDTO){
        String query = "insert into rating(rating.writerId ,rating.movieId, rating.score, rating.review) values (?,?,?,?)";
        try{
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1,ratingDTO.getWriteId());
            pstmt.setInt(2, ratingDTO.getMovieId());
            pstmt.setFloat(3,ratingDTO.getScore());
            pstmt.setString(4,ratingDTO.getReview());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
    }




}












