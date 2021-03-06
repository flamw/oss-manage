package com.flame.dao;

import java.util.List;

import com.flame.model.Note;

public interface NoteMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_note
     *
     * @mbggenerated Wed May 03 18:44:17 CST 2017
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_note
     *
     * @mbggenerated Wed May 03 18:44:17 CST 2017
     */
    int insert(Note record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_note
     *
     * @mbggenerated Wed May 03 18:44:17 CST 2017
     */
    int insertSelective(Note record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_note
     *
     * @mbggenerated Wed May 03 18:44:17 CST 2017
     */
    Note selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_note
     *
     * @mbggenerated Wed May 03 18:44:17 CST 2017
     */
    int updateByPrimaryKeySelective(Note record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_note
     *
     * @mbggenerated Wed May 03 18:44:17 CST 2017
     */
    int updateByPrimaryKeyWithBLOBs(Note record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_note
     *
     * @mbggenerated Wed May 03 18:44:17 CST 2017
     */
    int updateByPrimaryKey(Note record);

	List<Note> selectForListByUserId(Integer userId);
}