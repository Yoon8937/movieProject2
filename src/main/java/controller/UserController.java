package controller;

import connector.ConnectionMaker;
import model.UserDTO;

import java.sql.*;
import java.util.ArrayList;

/*
*             구현해야 할 것 : 회원등급 업데이트
* */

public class UserController {
    private Connection connection;
    public UserController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }


    public UserDTO auth(String username, String password) {
        String query = "SELECT * FROM user where username = ? and password = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                UserDTO userDTO = new UserDTO();
                userDTO.setId(resultSet.getInt("id"));
                userDTO.setUsername(resultSet.getString("username"));
                userDTO.setNickname(resultSet.getString("nickname"));
                userDTO.setRank(resultSet.getString("rank"));

                return userDTO;
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }



    public boolean insert(UserDTO userDTO){
        System.out.println("회원가입 메서드가 호출되었습니다.");
        String query = "INSERT INTO user (username,password,nickname) values (?,?,?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, userDTO.getUsername());
            pstmt.setString(2, userDTO.getPassword());
            pstmt.setString(3, userDTO.getNickname());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public void delete(int id) {
        String query = "DELETE  FROM `user` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }




    public UserDTO selectOne(int id) {
        UserDTO u = null;
        String query = "SELECT * FROM `user` WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                u = new UserDTO();
                u.setId(resultSet.getInt("id"));
                u.setUsername(resultSet.getString("username"));
                u.setNickname(resultSet.getString("nickname"));
                u.setRank(resultSet.getString("rank"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return u;
    }


    public ArrayList<UserDTO> selectAll() { //수정하기
        ArrayList<UserDTO> list = new ArrayList<>();

        String query = "select * from user";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);

            ResultSet resultSet = pstmt.executeQuery();

            while(resultSet.next()){
                UserDTO u = new UserDTO();
                u.setId(resultSet.getInt("id"));
                u.setUsername(resultSet.getString("username"));
                u.setNickname(resultSet.getString("nickname"));
                u.setRank(resultSet.getString("rank"));
                u.setAsk(resultSet.getString("ask"));

                list.add(u);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
//        System.out.println("이것은 총 멤버임 메서드"+list);
        return list;
    }


    public void update(int id, String rank) {
        String query = "update user set user.rank = ? where id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1,rank);
            pstmt.setInt(2,id);

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public void ask_RankUp(int id, String askRank) {
        String query = "update user set user.ask = ? where id = ?";

        try{
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1,askRank);
            pstmt.setInt(2,id);

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }




}
