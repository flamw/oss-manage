package com.flame.dao;

import java.util.List;
import java.util.Map;

import com.flame.model.Message;

public interface MessageMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_message
     *
     * @mbggenerated Mon May 08 10:13:47 CST 2017
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_message
     *
     * @mbggenerated Mon May 08 10:13:47 CST 2017
     */
    int insert(Message record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_message
     *
     * @mbggenerated Mon May 08 10:13:47 CST 2017
     */
    int insertSelective(Message record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_message
     *
     * @mbggenerated Mon May 08 10:13:47 CST 2017
     */
    Message selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_message
     *
     * @mbggenerated Mon May 08 10:13:47 CST 2017
     */
    int updateByPrimaryKeySelective(Message record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_message
     *
     * @mbggenerated Mon May 08 10:13:47 CST 2017
     */
    int updateByPrimaryKey(Message record);
    List<Message> selectByUserId(Integer userId);
    List<Map<String,Object>> selectUserCheckByMessageId(Integer messageId);
}