package com.flame.dao;

import java.util.List;
import java.util.Map;

import com.flame.model.Folder;

public interface FolderMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_folder
     *
     * @mbggenerated Sat Apr 08 14:39:45 CST 2017
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_folder
     *
     * @mbggenerated Sat Apr 08 14:39:45 CST 2017
     */
    int insert(Folder record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_folder
     *
     * @mbggenerated Sat Apr 08 14:39:45 CST 2017
     */
    int insertSelective(Folder record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_folder
     *
     * @mbggenerated Sat Apr 08 14:39:45 CST 2017
     */
    Folder selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_folder
     *
     * @mbggenerated Sat Apr 08 14:39:45 CST 2017
     */
    int updateByPrimaryKeySelective(Folder record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_folder
     *
     * @mbggenerated Sat Apr 08 14:39:45 CST 2017
     */
    int updateByPrimaryKey(Folder record);
    List<Map<String, Object>> queryFolderByPid(Folder record);
    List<Map<String, Object>> queryFolderByFolderName(Folder record);
}