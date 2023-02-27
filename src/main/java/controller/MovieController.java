package controller;


import connector.ConnectionMaker;
import model.MovieDTO;
import model.UserDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MovieController {
    private Connection connection;
    public MovieController(ConnectionMaker connectionMaker){
        this.connection = connectionMaker.makeConnection();
    }


    public ArrayList<MovieDTO> selectAll(){
        ArrayList<MovieDTO> list = new ArrayList<>();

        String query = "select * from movie";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                MovieDTO m = new MovieDTO();
                m.setId(resultSet.getInt("id"));
                m.setTitle(resultSet.getString("title"));
                m.setStory(resultSet.getString("story"));
                m.setRank(resultSet.getString("rank"));
                list.add(m);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public MovieDTO selectOne(int id){
        MovieDTO m = null;

        String query = "select * from movie where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);

            pstmt.setInt(1,id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                m = new MovieDTO();
                m.setId(resultSet.getInt("id"));
                m.setTitle(resultSet.getString("title"));
                m.setStory(resultSet.getString("story"));
                m.setRank(resultSet.getString("rank"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return m;
    }

    public ArrayList<MovieDTO> selectTheaterAllMovies(int theaterId){
        ArrayList<MovieDTO> list = new ArrayList<>();

        String query = "select movie.id, movie.title,movie.story, movie.rank from movie join infomovie on movie.id = infomovie.movieId" +
                " join theater" +
                " on infomovie.theaterId = theater.id" +
                " where theater.id = ?";
//        String query = "select movie.id, movie.title,movie.story, movie.rank from movie join infomovie on movie.id = infomovie.movieId join theater on infomovie.theaterId = theater.id where theater.id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1,theaterId);
            ResultSet resultSet = pstmt.executeQuery();

            while(resultSet.next()){
                MovieDTO m = new MovieDTO();
                m.setId(resultSet.getInt("movie.id"));
                m.setTitle(resultSet.getString("movie.title"));
                m.setStory(resultSet.getString("movie.story"));
                m.setRank(resultSet.getString("movie.rank"));
                list.add(m);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void delete(int id){
        String query  = "delete from movie where id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(MovieDTO movieDTO){
        String query = "update movie set movie.title = ?, movie.story = ?, movie.rank = ? where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1,movieDTO.getTitle());
            pstmt.setString(2,movieDTO.getStory());
            pstmt.setString(3,movieDTO.getRank());
            pstmt.setInt(4, movieDTO.getId());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insert(MovieDTO movieDTO){
        String query = "insert into movie(movie.title,movie.story, movie.rank) values (?,?,?)";

        try{
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1,movieDTO.getTitle());
            pstmt.setString(2,movieDTO.getStory());
            pstmt.setString(3,movieDTO.getRank());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
    }


}





























