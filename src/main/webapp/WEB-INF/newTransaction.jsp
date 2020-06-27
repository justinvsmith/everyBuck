<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&family=Roboto:wght@400;700;900&display=swap" rel="stylesheet">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/everyBuck.css" />
    <script src="js/everyBuck.js"></script>
</head>
<body>

	<div class="container">
	
	 <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newTransaction">
          Open modal
        </button>
        
        <div class="modal" id="newTransaction">
          <div class="modal-dialog">
            <div class="modal-content">
        
        <div class="modal-body">
	<form:form action="/newTransaction" method="post" modelAttribute="transaction">
            		<div class="row">
            			<form:errors path="name" /><br >
            			<form:label class="col-sm-3" path="name">Name:</form:label>
            			<form:input class="col-sm-5" type="text" path="name" />
            		</div>
            		<br >
            		<div class="row">
            			<form:errors path="amount" /><br >
            			<form:label class="col-sm-3" path="amount">Amount:</form:label>
            			<form:input class="col-sm-5" type="text" path="amount" />
            		</div>
            		<br >
            		<div class="row">
            			<form:errors path="type" /><br >
            			<form:label class="col-sm-3" path="type">Transaction type:</form:label>
            			<form:select class="col-sm-5" path="type" >
            				<form:option path="type" value="Income">Income</form:option>
            				<form:option path="type" value="Expense">Expense</form:option>
            			</form:select>
            		</div>
            		<br >
            		<div class="row">
            			<form:errors path="transactionDate" /><br >
            			<form:label class="col-sm-3" path="transactionDate">Transaction Date:</form:label>
            			<form:input class="col-sm-5" type="date" path="transactionDate" />
            		</div>
            		<br >
            		<div class="row">
            		<form:errors path="item.id" /><br >
            		<form:label class="col-sm-3"  path="item.id">Items</form:label>
            		<form:select class="col-sm-5" path="item.id" >
            		<c:forEach items="${items}" var="i">
            		<form:option path="item.id" value="${i.id }"><c:out value="${i.name}" /></form:option>
            		</c:forEach>
            		</form:select>
            		</div>
            		<br >
            		<input type="submit" value="add transaction" />
            	</form:form>
            	</div>
            	
            	<div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
              </div>
            	
            	
                </div>
          </div>
        </div>
    
    </div>
</body>
</html>