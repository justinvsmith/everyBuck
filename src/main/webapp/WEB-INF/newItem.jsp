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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newItem">
          Open modal
    </button>
    
    <div class="modal" id="newItem">
          <div class="modal-dialog">
            <div class="modal-content">
    
    <div class="modal-body">
	<form:form action="/newItem" method="post" modelAttribute="item">
            		<div class="row">
            			<form:errors path="name" /><br >
            			<form:label class="col-sm-3" path="name">Name:</form:label>
            			<form:input class="col-sm-4" type="text" path="name" />
            		</div>
            		<br >
            		<div class="row">
            			<form:errors path="budgetAmt" /><br >
            			<form:label class="col-sm-3" path="budgetAmt">Amount:</form:label>
            			<form:input class="col-sm-4" type="text" path="budgetAmt" />
            		</div>
            		<br >
            		<div class="row">
            			<form:errors path="category.id" /><br >
            			<form:label class="col-sm-3" path="category.id">Category:</form:label>
            			<form:select class="col-sm-4" path="category.id" >
            			<c:forEach items="${categories}" var="c">
            				<form:option path="category.id" value="${c.id}"><c:out value="${c.name }" /></form:option>
            				</c:forEach>
            			</form:select>
            		</div>
            		<br >
            		<input type="submit" value="add item" />
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