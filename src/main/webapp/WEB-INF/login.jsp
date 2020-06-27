<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link rel="stylesheet" type="text/css" href="css/beltExam.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
</head>
<body>
	 <h1>Register!</h1>
	 <div class="main">
    	<div class="left">
    		<p><form:errors path="user.*"/></p><br >
    		<div class="container">
    		<form:form method="POST" action="/registration" modelAttribute="user">
              	<div class="row">
              	<p>
           			<form:label path="firstName">First Name:</form:label>
            		<form:input type="text" path="firstName"/>
                </p>
                </div>
                <br >
                <div class="row">
              	<p>
           			<form:label path="lastName">First Name:</form:label>
            		<form:input type="text" path="lastName"/>
                </p>
                </div>
                <br >
                <div class="row">
                <p>
           			<form:label path="email">Email:</form:label>
            		<form:input type="email" path="email"/>
                </p>
                </div>
                <br >
                <div class="row">
        		<p>
            		<form:label path="password">Password:</form:label>
            		<form:password path="password"/>
                </p>
                </div>
                <br >
                <div class="row">
        		<p>
            		<form:label path="passwordConfirmation">Password Confirmation:</form:label>
            		<form:password path="passwordConfirmation"/>
                </p>
                </div>
                <br >
        			<input class="btn btn-primary" type="submit" value="Register!"/>
    		</form:form>
    		</div>
    	</div>
    	<div class="right">
    		<p><c:out value="${error}" /></p>
    		<form method="post" action="/login">
        		<p>
            		<label for="email">Email</label>
            		<input type="text" id="email" name="email"/>
                </p>
                <br >
        		<p>
            		<label for="password">Password</label>
            		<input type="password" id="password" name="password"/>
                </p>
                <br >
        			<input class="btn btn-primary" type="submit" value="Login!"/>
    		</form> 
    	</div>
    </div>
</body>
</html>