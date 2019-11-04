package com.ssm.maven.core.entity;

import javax.jnlp.IntegrationService;

/**
 * @author 1034683568@qq.com
 * @project_name ssm-maven
 * @date 2017-3-1
 */
public class User {

    @Override
    public String toString() {
        return "User [id=" + id + ", userName=" + userName + ", password="
                + password + ", name=" + name + ",email=" + email + ",mobile="
                + mobile + ",role_id=" + role_id + ",role_priv_level=" + role_priv_level +
                ",status=" + status + "]";
    }

    private Integer id; // 主键
    private String userName; // 用户姓名
    private String password; // 密码
    private String name; //
    private String email;
    private String mobile;
    private Integer role_id;
    private Integer role_priv_level;
    private Integer status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Integer getRoleId() {
        return role_id;
    }

    public void setRoleId(Integer role_id) {
        this.role_id = role_id;
    }

    public Integer getRolePrivLevel() {
        return role_priv_level;
    }

    public void setRolePrivLevel(Integer role_priv_level) {
        this.role_priv_level = role_priv_level;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

}
