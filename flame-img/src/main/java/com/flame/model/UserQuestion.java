package com.flame.model;

public class UserQuestion {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user_question.user_id
     *
     * @mbggenerated Thu Mar 30 00:28:05 CST 2017
     */
    private Integer userId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user_question.question_id
     *
     * @mbggenerated Thu Mar 30 00:28:05 CST 2017
     */
    private Integer questionId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user_question.answer
     *
     * @mbggenerated Thu Mar 30 00:28:05 CST 2017
     */
    private String answer;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user_question.user_id
     *
     * @return the value of t_user_question.user_id
     *
     * @mbggenerated Thu Mar 30 00:28:05 CST 2017
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user_question.user_id
     *
     * @param userId the value for t_user_question.user_id
     *
     * @mbggenerated Thu Mar 30 00:28:05 CST 2017
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user_question.question_id
     *
     * @return the value of t_user_question.question_id
     *
     * @mbggenerated Thu Mar 30 00:28:05 CST 2017
     */
    public Integer getQuestionId() {
        return questionId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user_question.question_id
     *
     * @param questionId the value for t_user_question.question_id
     *
     * @mbggenerated Thu Mar 30 00:28:05 CST 2017
     */
    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user_question.answer
     *
     * @return the value of t_user_question.answer
     *
     * @mbggenerated Thu Mar 30 00:28:05 CST 2017
     */
    public String getAnswer() {
        return answer;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user_question.answer
     *
     * @param answer the value for t_user_question.answer
     *
     * @mbggenerated Thu Mar 30 00:28:05 CST 2017
     */
    public void setAnswer(String answer) {
        this.answer = answer;
    }
}