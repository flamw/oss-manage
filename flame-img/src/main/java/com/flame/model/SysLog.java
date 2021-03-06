package com.flame.model;

import java.util.Date;

public class SysLog {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_sys_log.id
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_sys_log.user_id
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    private Integer userId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_sys_log.user_name
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    private String userName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_sys_log.operation_type
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    private String operationType;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_sys_log.description
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    private String description;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_sys_log.ctime
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    private Date ctime;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_sys_log.id
     *
     * @return the value of t_sys_log.id
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_sys_log.id
     *
     * @param id the value for t_sys_log.id
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_sys_log.user_id
     *
     * @return the value of t_sys_log.user_id
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_sys_log.user_id
     *
     * @param userId the value for t_sys_log.user_id
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_sys_log.user_name
     *
     * @return the value of t_sys_log.user_name
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public String getUserName() {
        return userName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_sys_log.user_name
     *
     * @param userName the value for t_sys_log.user_name
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_sys_log.operation_type
     *
     * @return the value of t_sys_log.operation_type
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public String getOperationType() {
        return operationType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_sys_log.operation_type
     *
     * @param operationType the value for t_sys_log.operation_type
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public void setOperationType(String operationType) {
        this.operationType = operationType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_sys_log.description
     *
     * @return the value of t_sys_log.description
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public String getDescription() {
        return description;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_sys_log.description
     *
     * @param description the value for t_sys_log.description
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_sys_log.ctime
     *
     * @return the value of t_sys_log.ctime
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public Date getCtime() {
        return ctime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_sys_log.ctime
     *
     * @param ctime the value for t_sys_log.ctime
     *
     * @mbggenerated Sun Apr 09 16:02:33 CST 2017
     */
    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }
}