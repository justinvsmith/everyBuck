<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %> 
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%> 
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budgets</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;700&family=Roboto:wght@400;700;900&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/everyBuck.css" />
    <script src="js/everyBuck.js"></script>
</head>
<body>
	<div class="wrapper">
        <div class="header">
            <div class="left">
                <h2><c:out value="${month}"/> <c:out value="${year}"/></h2>
            </div>
            <div class="right">
                <ul>
                    <li>
                        <button type="button" data-toggle="modal" data-target="#newCategory">
                        New Category
                        </button>
                    </li>
                    <li>
                        <button type="button" data-toggle="modal" data-target="#newItem">
                        New Item
                        </button>
                    </li>
                    <li>
                        <button type="button" data-toggle="modal" data-target="#newTransaction">
                        New Transaction
                        </button>
                    </li>
                    <!-- <li>
                        <button type="button" data-toggle="modal" data-target="#newBudget">
                        New Transaction
                        </button>
                    </li> -->
                </ul>
            </div>
        </div>

<!-- This is the beginning of the income section -->
        <div class="budgeting">
            <div class="category">
                <div class="outside">
                    <table class="budgetMain">
                        <sql:setDataSource var="transactions" driver="com.mysql.cj.jdbc.Driver"
                            url = "jdbc:mysql://localhost:8889/everyDollar?serverTimezone=UTC"
                            user = "root" password ="root" />
                        <sql:query dataSource="${transactions}" var="num" >
                            SELECT * FROM everyDollar.budgets WHERE month = "${month}";
                        </sql:query>
                        <c:set var="plannedAmt" value="${num.rows[0]}" />
                        <tr class="tblHead">
                            <td><h4>Income for <c:out value="${plannedAmt.month}" /></h4></td>
                            <td>Planned</td>
                            <td>Spent</td>
                        </tr>
                    </table>
<!-- End of the table top, now to fake a table for the rest of the content of this section. -->
                    <div class="newRow">
                        <div class="items">
                            <div class="item-left">
                                <div class="itemName">
                                    <a href="#">Justin</a>
                                </div>
                            </div>
                            <div class="item-right">
                                <sql:setDataSource var="transactions" driver="com.mysql.cj.jdbc.Driver"
                                    url = "jdbc:mysql://localhost:8889/everyDollar?serverTimezone=UTC"
                                    user = "root" password ="root" />
                                <sql:query dataSource="${transactions}" var="num" >
                                    SELECT  sum(t.amount) AS sum FROM everyDollar.transactions t Join everyDollar.items i on t.item_id = i.id Join everyDollar.categories c on i.category_id = c.id;
                                </sql:query>
                                <c:set var="totalSpent" value="${total.rows[0].sum}" />
                                <c:set var="totalRemaining" value="${plannedAmt.amount - totalSpent}" />
                                <div>
                                    <p><c:out value="${plannedAmt.amount}"/></p>
                                </div>
                                <div>
                                    <p><c:out value="${totalSpent}"/></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <a href="#">Add Item</a>
                </div>
            </div>
<!-- The end of the first budgeting section where the budgeting info will live-->

<!-- This is the beginning of what should be the repeating sections, starting with the real table for the top -->
            <c:forEach items="${categories}" var="c">
            <div class="category">
                <div class="outside">
                    <table class="budgetMain">
                        <tr class="tblHead">
                            <td><h4><c:out value="${c.name}"/></h4></td>
                            <td>Planned</td>
                            <td>Remaining</td>
                        </tr>
                    </table>
                    <c:forEach items="${c.items}" var="i">
                        <div class="newRow">
                            <div class="items">
                                <div class="item-left">
                                    <div class="itemName">
                                        <a href="#${i.name}"><c:out value="${i.name}" /></a>
                                        <c:set var="itemName" value="${i.name}" />
                                    </div>
                                </div>
                                <div class="item-right">
                                    <div>
                                        <p class="budgetAmt"><c:out value="${i.budgetAmt}"/></p>
                                    </div>
    <!-- This is where I run a query to figure out the totals for the calculated fields -->
                                    <sql:setDataSource var="transactions" driver = "com.mysql.cj.jdbc.Driver"
                                        url ="jdbc:mysql://localhost:8889/everyDollar?serverTimezone=UTC"
                                        user = "root" password="root" />
                                    <sql:query dataSource = "${transactions}" var="num">
                                        SELECT sum(amount) AS sum FROM everyDollar.transactions WHERE item_id = ${i.id};
                                    </sql:query>
                                    <c:set var = "budget"  value="${i.budgetAmt}" />
                                    <c:set var = "spent" value="${num.rows[0].sum}" />
                                    <c:set var= "remaining" value="${budget - spent}" />
                                    <c:set var = "percentage" value="${(spent/budget)*100}" />
                                    <div>
                                        <p class="amtSpent hide"><c:out value="${spent}"/></p>
                                        <p class="amtSpent"><c:out value="${remaining}"/></p>
                                    </div>
                                </div>
                            </div>
                            <div class="meter">
                            <span style="width: ${percentage}%"></span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            </c:forEach>
        </div>
<!-- This is the end of the main sections for the left side of the page. All budgeted categories.-->
    

  <div class="details">
            <div class="container">
            <div class="detailCircle">
            	<sql:setDataSource var="transactions" driver="com.mysql.cj.jdbc.Driver"
                	url = "jdbc:mysql://localhost:8889/everyDollar?serverTimezone=UTC"
                    user = "root" password ="root" />
                    <sql:query dataSource="${transactions}" var="num" >
                    	SELECT * FROM everyDollar.budgets WHERE month = "${month}";
                    </sql:query>
                    <sql:query dataSource = "${transactions}" var="ttl">
                    SELECT sum(amount) AS amount FROM everyDollar.transactions;
                </sql:query>
           		<c:set var ="totalSpent" value="${ttl.rows[0].amount }" />
                    <c:set var="plannedAmt" value="${num.rows[0]}" />
    			<div class="detailInserts"><p>${month}</p>
    				<p class="amount">$<c:out value="${plannedAmt.amount}"/></p>
    			</div>
    			<div class="circleMessage"><p class='month'><c:out value="${month}"/></p>
    				<p class="amount">$<c:out value="${plannedAmt.amount}"/></p></div>
    		</div>
    		<br >
            <div class="tabs">
                <ul class ="navLinks">
                    <li><a href="#planned">Planned</a></li>
                    <li><a href="#spent">Spent</a></li>
                    <li><a href="#remaining">Remaining</a></li>
                </ul>
            <div id="planned">
                <table>
                <c:forEach items="${categories}" var="c">
                <sql:setDataSource var="transactions" driver = "com.mysql.cj.jdbc.Driver"
                    url ="jdbc:mysql://localhost:8889/everyDollar?serverTimezone=UTC"
                    user = "root" password="root" />
                <sql:query dataSource = "${transactions}" var="num">
                    SELECT  sum(t.amount) AS sum FROM everyDollar.transactions t Join everyDollar.items i on t.item_id = i.id Join everyDollar.categories c on i.category_id = c.id WHERE c.name= "${c.name}" ;
                </sql:query>
                <sql:query dataSource = "${transactions}" var="num2">
                    SELECT sum(i.budget_amt) AS total FROM everyDollar.items i join everyDollar.categories c on i.category_id = c.id WHERE c.id = "${c.id}" ;
                </sql:query>
            <c:set var = "spent" value="${num.rows[0].sum}" />
            <c:set var = "budgeted" value="${num2.rows[0].total}" />
            <c:set var = "remaining" value="${budgeted - spent}" />
            <tr>
                <td><c:out value="${c.name}"/></td>
                <td><c:out value="${budgeted}" /></td>
            </tr>
            </c:forEach>
                </table>
            </div>
            <div id="spent">
                <table>
                <sql:query dataSource = "${transactions}" var="ttl">
                    SELECT sum(amount) AS amount FROM everyDollar.transactions;
                </sql:query>
           		<c:set var ="totalSpent" value="${ttl.rows[0].amount }" />
            	<div class="spentInserts hide"><p><c:out value="${totalSpent}"/></p></div>
            	</div>
                <c:forEach items="${categories}" var="c">
                <sql:setDataSource var="transactions" driver = "com.mysql.cj.jdbc.Driver"
                        url ="jdbc:mysql://localhost:8889/everyDollar?serverTimezone=UTC"
                        user = "root" password="root" />
                <sql:query dataSource = "${transactions}" var="num">
                    SELECT  sum(t.amount) AS sum FROM everyDollar.transactions t Join everyDollar.items i on t.item_id = i.id Join everyDollar.categories c on i.category_id = c.id WHERE c.name= "${c.name}" ;
                </sql:query>
                <sql:query dataSource = "${transactions}" var="num2">
                    SELECT sum(i.budget_amt) AS total FROM everyDollar.items i join everyDollar.categories c on i.category_id = c.id WHERE c.id = "${c.id}" ;
                </sql:query>
                 
            <c:set var = "spent" value="${num.rows[0].sum}" />
            <c:set var = "budgeted" value="${num2.rows[0].total}" />
            <c:set var = "remaining" value="${budgeted - spent}" />
            <tr>
                <td><c:out value="${c.name}" /></td>
                <td><c:out value="${spent}" /></td>
            </tr>
    </c:forEach>
        </table>
    </div>
    
    <div id="remaining">
        <table>
        <c:forEach items="${categories}" var="c">
        <sql:setDataSource var="transactions" driver = "com.mysql.cj.jdbc.Driver"
                    url ="jdbc:mysql://localhost:8889/everyDollar?serverTimezone=UTC"
                    user = "root" password="root" />
                <sql:query dataSource = "${transactions}" var="num">
                    SELECT  sum(t.amount) AS sum FROM everyDollar.transactions t Join everyDollar.items i on t.item_id = i.id Join everyDollar.categories c on i.category_id = c.id WHERE c.name= "${c.name}" ;
                </sql:query>
                <sql:query dataSource = "${transactions}" var="num2">
                    SELECT sum(i.budget_amt) AS total FROM everyDollar.items i join everyDollar.categories c on i.category_id = c.id WHERE c.id = "${c.id}" ;
                </sql:query>
                <c:set var = "spent" value="${num.rows[0].sum}" />
                <c:set var = "budgeted" value="${num2.rows[0].total}" />
                <c:set var = "remaining" value="${budgeted - spent}" />
        <tr>
            <td><c:out value="${c.name}" /></td>
            <td><c:out value="${remaining}" /></td>
        </tr>
        </c:forEach>
        </table>
    </div>
    </div>
</div>
    <div class="transactions hide">
    	<div class="list-header">
    		<div class="circle">
    			<div class="inserts">Hi</div>
    		</div>
  		</div>
  		<c:forEach items="${items}" var="it">
  		<div class="${it.name} hide">
  			<h2><c:out value="${it.name}" /></h2>
  		<c:forEach items="${it.transactions }" var="tra" >
  			<c:set var="date" value="${tra.transactionDate}"/>
                <table>
                	<tr>
                        <td><fmt:formatDate pattern="MM/dd" value="${date}"/></td>
                        <td><c:out value="${tra.name}"/></td>
                        <td><c:out value="${tra.amount}"/></td>
                    </tr>
  					</table>
  			</c:forEach>
  		</div>
  		
  		</c:forEach>
  		
    </div>
    <!-- This is where I'll start the forms section of things-->

<!-- This is the form for category -->
        <div class="container">

            <div class="modal" id="newCategory">
                <div class="modal-dialog">
                    <div class="modal-content" style="padding: 10px;">
                        
                        <form action="/newCategory" method="POST">
                            <div class="row">
                                <label class="col-sm-3" for="name">Name:</label>
                                <input class="col-sm-5" type="text" name="name" />
                            </div>
                            <br >
                            <input type="hidden" name="user.id" value="${activeU.id}" />
                            <input type="submit" value="add category" />
                        </form>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>

                    </div>
                </div>
            </div>

        </div>
<!-- End of the form for category -->
        <br >
<!-- Start of the new items form -->
        <div class="container">

            <div class="modal" id="newItem">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <div class="modal-body">
                            <form action="/newItem" method="POST">
                                <div class="row">
                                    <label class="col-sm-3" for="name">Name:</label>
                                    <input type="text" id="name" name="name" />
                                </div>
                                <br >
                                <div class="row">
                                    <label for="budgetAmt" class="col-sm-3">Amount:</label>
                                    <input type="text" class="col-sm-5" name="budgetAmt" />
                                </div>
                                <br >
                                <div class="row">
                                    <label for="category.id" class="col-sm-3">Category: </label>
                                    <select name="category.id" id="" class="col-sm-5">
                                        <c:forEach items="${categories}" var="c">
                                        <option value="${c.id}"><c:out value="${c.name}"/></option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <br >
                                <input type="submit" value="add item" />
                            </form>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>

                    </div>
                </div>
            </div>

        </div>
<!-- End of the form for new items -->
        <br >
<!-- Start of the form for Transactions -->

        <div class="container">
            
            <div class="modal" id="newTransaction">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <div class="modal-body">
                            <form action="/newTransaction" method="POST">
                                <div class="row">
                                    <label for="name" class="col-sm-3">Name: </label>
                                    <input type="text" class="col-sm-5" name="name" />
                                </div>
                                <br >
                                <div class="row">
                                    <label for="amount" class="col-sm-3">Amount:</label>
                                    <input type="text" class="col-sm-5" name="amount" />
                                </div>
                                <br >
                                <div class="row">
                                    <label for="type" class="col-sm-3">Transaction Type:</label>
                                    <select name="type" id="type" class="col-sm-5">
                                        <option value="Income">Income</option>
                                        <option value="Expense">Expense</option>
                                    </select>
                                </div>
                                <div class="row">
                                    <label for="transactionDate" class="col-sm-3">Transaction Date:</label>
                                    <input type="date" class="col-sm-5" name="transactionDate" />
                                </div>
                                <br >
                                <div class="row">
                                    <label for="item.id" class="col-sm-3">Item</label>
                                    <select name="item.id" id="item.id" class="col-sm-5">
                                        <c:forEach items="${items}" var="item">
                                            <option value="${item.id}"><c:out value="${item.name}"/></option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <br >
                                <input type="submit" value="add transaction" />
                            </form>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>

                    </div>
                </div>
            </div>

        </div>
<!-- End of the form for Transactions-->
        <br >
<!-- Beginning of the Budget form-->

        <div class="container">

            <div class="modal" id="newBudget">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <div class="modal-body">
                            <form action="/newBudget" method="POST">
                                <div class="row">
                                    <label for="month" class="col-sm-3">Month:</label>
                                    <input type="text" class="col-sm-5" name="month">
                                </div>
                                <br >
                                <div class="row">
                                    <label for="amount" class="col-sm-3">Amount:</label>
                                    <input type="text" class="col-sm-5" name="amount">
                                </div>
                                <br >
                                <input type="submit" value="new budget" />
                            </form>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>

                    </div>
                </div>
            </div>

        </div>
<!-- End of the form for Budget -->
</body>
</html>