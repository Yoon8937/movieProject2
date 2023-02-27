package model;

import lombok.Data;

@Data
public class UserDTO {
//    가입일 추가해주기//////////////////////////////////////////////////////////
    private int id;
    private String username;
    private String password;
    private String nickname;
    private String rank;

    private String ask;
}
