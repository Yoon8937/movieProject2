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
    private final int PAGE_SIZE = 10;
    public MovieController(ConnectionMaker connectionMaker){
        this.connection = connectionMaker.makeConnection();
    }


    public ArrayList<MovieDTO> selectAll(int pageNo){
        ArrayList<MovieDTO> list = new ArrayList<>();

//        String query = "select * from movie";
        String query = "select * from movie order by id desc limit ?, ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, (pageNo - 1) * PAGE_SIZE);
            pstmt.setInt(2, PAGE_SIZE);

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

    public int countTotalPage(){
        int totalPage = 0;
        String query = "select count(*) from movie";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            int count = 0;
            if(resultSet.next()) {
                count = resultSet.getInt(1);
            }

            totalPage = count / PAGE_SIZE;
            if (count % PAGE_SIZE !=0) {
                totalPage++;
            }

            pstmt.close();
            resultSet.close();
        } catch (SQLException e){
            e.printStackTrace();
        }

        return totalPage;
    }


}





























