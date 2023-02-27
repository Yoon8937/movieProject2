package model;

import lombok.Data;

@Data
public class RatingDTO {
    private int id;
    private int writeId;
    private int movieId;
    private float score;
    private String review;

}
