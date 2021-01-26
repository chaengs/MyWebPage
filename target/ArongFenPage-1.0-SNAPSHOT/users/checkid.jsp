<%@ page import="test.users.dao.UsersDao" %>
<%@ page contentType="application/json; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%--contentType Json으로 하기--%>
<%
    String inputId = request.getParameter("inputId");
    System.out.println("inputId : " + inputId);

    boolean isExist = UsersDao.getInstance().isExist(inputId);
%>
{"isExist" : ${isExist}}