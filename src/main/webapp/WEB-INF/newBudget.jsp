<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Budget</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">

        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newBudget">
          Open modal
        </button>
        
        <div class="modal" id="newBudget">
          <div class="modal-dialog">
            <div class="modal-content">
        
        <div class="modal-body">
	<form:form action="/newBudget" method="post" modelAttribute="budget">
            		<div class="row">
            			<form:errors path="month" /><br >
            			<form:label class="col-sm-3" path="month">Month:</form:label>
            			<form:input class="col-sm-4" type="text" path="month" />
            		</div>
            		<br >
            		<div class="row">
            			<form:errors path="amount" /><br >
            			<form:label class="col-sm-3" path="amount">Amount:</form:label>
            			<form:input class="col-sm-4" type="text" path="amount" />
 					</div>
 					<br >
            		<input type="submit" value="new budget" />
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