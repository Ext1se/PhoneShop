package com.tpu.shop.data;

import com.fasterxml.jackson.annotation.JsonView;
import com.tpu.shop.utils.ValidationMessage;
import org.hibernate.validator.constraints.Length;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "`user`")
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_user")
    @JsonView({Views.User.class, Views.Comment.class, Views.Order.class})
    private Long id;

    @NotBlank(message = ValidationMessage.EMPTY_FIELD)
    @Length(max = 100)
    @Column(nullable = false)
    @JsonView({Views.User.class, Views.Comment.class, Views.Order.class})
    private String username;

    @NotBlank(message = ValidationMessage.EMPTY_FIELD)
    @Column(nullable = false)
    private String password;

    @Column(name = "first_name")
    @JsonView({Views.User.class, Views.Comment.class, Views.Order.class})
    private String firstName;

    @Column(name = "last_name")
    @JsonView({Views.User.class, Views.Comment.class, Views.Order.class})
    private String lastName;

    @Email(message = ValidationMessage.EMAIL_FIELD)
    @JsonView({Views.Order.class})
    private String email;

    @Column(name = "activation_code")
    private String activationCode;

    @Column(name = "phone_number")
    @JsonView({Views.User.class, Views.Order.class})
    private String phoneNumber;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_address",
            foreignKey = @ForeignKey(
                    name = "fk_user_address",
                    foreignKeyDefinition = "FOREIGN KEY (id_address) REFERENCES address(id_address) " +
                            "ON UPDATE CASCADE " +
                            "ON DELETE SET NULL"
            ))
    @JsonView({Views.User.class, Views.Order.class})
    private Address address;

    //EAGER
    @OneToMany( mappedBy = "user", fetch = FetchType.LAZY)
    private List<Order> orders;

    private boolean isActive;

    /*
    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "id_user"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles;
    */

    // В классе несколько OneToMany c типом EAGER. Так делать нельзя, так как при этом Хибер будет пытаться вытащить
    // одним запросом две коллекции, которые не связаны между собой, то есть по сути получится картезиан в терминах реляционной алгебры.
    // Сделать одну из зависимостей LAZY.
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "user_role",
            joinColumns = @JoinColumn(name = "id_user"),
            inverseJoinColumns = @JoinColumn(name = "id_role"))
    private List<Role> roles;

    @Transient
    private List<SmartPhone> smartPhones = new ArrayList<>();

    public User() {
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isActive();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getActivationCode() {
        return activationCode;
    }

    public void setActivationCode(String activationCode) {
        this.activationCode = activationCode;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public boolean isAdmin() {
        for (Role role : roles) {
            if (role.getName().equalsIgnoreCase("ADMIN")) {
                return true;
            }
        }
        return false;
    }


    public List<SmartPhone> getSmartPhones() {
        return smartPhones;
    }

    public void addSmartPhone(SmartPhone smartPhone){
        this.smartPhones.add(smartPhone);
    }

    public void setSmartPhones(List<SmartPhone> smartPhones) {
        this.smartPhones = smartPhones;
    }
}
