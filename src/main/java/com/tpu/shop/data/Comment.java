package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonView;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "comment")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_comment")
    @JsonView(Views.Comment.class)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_user", nullable = false,
            foreignKey = @ForeignKey(
                    name = "fk_user_comment",
                    foreignKeyDefinition = "FOREIGN KEY (id_user) REFERENCES user(id_user) " +
                            "ON DELETE CASCADE " +
                            "ON UPDATE CASCADE"
            ))
    @JsonView(Views.Comment.class)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_model", nullable = false,
            foreignKey = @ForeignKey(
                    name = "fk_model_comment",
                    foreignKeyDefinition = "FOREIGN KEY (id_model) REFERENCES model(id_model) " +
                            "ON DELETE CASCADE " +
                            "ON UPDATE CASCADE"
            ))
    private Model model;

    @Column(columnDefinition = "TEXT")
    @JsonView(Views.Comment.class)
    private String message;

    @JsonView(Views.Comment.class)
    private Integer rating;

    @Column(name = "date_created")
    @JsonView(Views.Comment.class)
    //@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "d MMMM yyyy HH:mm")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd.MM.yyyy HH:mm")
    private LocalDateTime dateCreated;

    @Column(name = "date_updated")
    @JsonView(Views.Comment.class)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd.MM.yyyy HH:mm")
    private LocalDateTime dateUpdated;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "comment")
    private List<CommentPhoto> photos;

    public Comment() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public LocalDateTime getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(LocalDateTime dateCreated) {
        this.dateCreated = dateCreated;
    }

    public LocalDateTime getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(LocalDateTime dateUpdated) {
        this.dateUpdated = dateUpdated;
    }

    public List<CommentPhoto> getPhotos() {
        return photos;
    }

    public void setPhotos(List<CommentPhoto> photos) {
        this.photos = photos;
    }
}
