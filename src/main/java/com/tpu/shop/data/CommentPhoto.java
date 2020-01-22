package com.tpu.shop.data;

import javax.persistence.*;

@Entity
@Table(name = "comment_photo")
public class CommentPhoto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_photo")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_comment", nullable = false,
            foreignKey = @ForeignKey(
                    name = "fk_comment_photo",
                    foreignKeyDefinition = "FOREIGN KEY (id_comment) REFERENCES comment(id_comment) " +
                            "ON DELETE CASCADE " +
                            "ON UPDATE CASCADE"
            ))
    private Comment comment;

    private Integer position;

    @Column(nullable = false)
    private String url;

    public CommentPhoto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Comment getComment() {
        return comment;
    }

    public void setComment(Comment comment) {
        this.comment = comment;
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
