<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" 
                           url="jdbc:mysql://localhost:3306/quizzes" 
                           user="root" password=""/>  

        <form method="POST" action="MidtermQuizChecker">   
            <h1>Identification</h1>            
            <sql:query dataSource="${db}" var="rs">
                SELECT description, answer FROM questions 
                WHERE term='midterms' AND type='identification';
            </sql:query> 
            <ol>
                <c:forEach var="questionList" items="${rs.rows}">
                    <li><c:out value="${questionList.description}"/></li>
                    <input type="text" name="idenAns"/>
                    <br/>
                </c:forEach>
            </ol>

            <h1>True or False</h1>
            <sql:query dataSource="${db}" var="rs">
                SELECT description, answer FROM questions 
                WHERE term='midterms' AND type='TrueOrFalse';
            </sql:query> 
            <table>
                <c:forEach var="questionList" items="${rs.rows}"> 
                    <tr>
                        <td><input type="text" name="tfAns"></td>
                        <td><c:out value="${questionList.description}"/></td>
                    </tr>
                </c:forEach>
            </table>

            <h1>Multiple Choice</h1>
            <sql:query dataSource="${db}" var="rs">
                SELECT description, answer, choice1, choice2, choice3, choice4 
                FROM questions NATURAL JOIN multiplechoice
                WHERE term='midterms' AND type='Multiplechoice';
            </sql:query>
            <ol>
                <c:forEach var="questionList" items="${rs.rows}" varStatus="loop">
                    <input type="radio" name="mcAns${loop.index+1}" value="NO ANSWER" hidden="hidden" checked="checked">
                    <li><c:out value="${questionList.description}"/></li>
                    <input type="radio" name="mcAns${loop.index+1}" value="${questionList.choice1}">
                    <label>${questionList.choice1}</label><br/>
                    <input type="radio" name="mcAns${loop.index+1}" value="${questionList.choice2}">
                    <label>${questionList.choice2}</label><br/>                    
                    <input type="radio" name="mcAns${loop.index+1}" value="${questionList.choice3}">
                    <label>${questionList.choice3}</label><br/>
                    <input type="radio" name="mcAns${loop.index+1}" value="${questionList.choice4}">
                    <label>${questionList.choice4}</label><br/>
                    <br/>
                </c:forEach>
            </ol>

            <h1>Matching Type</h1>     
            <p>Match their HTTP Status code.</p>       
            <sql:query dataSource="${db}" var="rs">
                SELECT choice FROM mtchoices 
                WHERE term='midterms' ORDER BY 1;
            </sql:query>     
            <table>
                <c:forEach var="choiceList" items="${rs.rows}">
                    <tr>
                        <td><c:out value="${choiceList.choice}"/></td>
                    </tr>
                </c:forEach>                    
            </table>   
            
            <sql:query dataSource="${db}" var="rs">
                SELECT description, answer FROM questions 
                WHERE term='midterms' AND type='Matchingtype';
            </sql:query> 
            <table>
                <c:forEach var="questionList" items="${rs.rows}">
                    <c:set var="ctr" value="${loop.index+1}"/>
                    <tr>
                        <td><input type="text" name="mtAns"></td>
                        <td><c:out value="${questionList.description}"/></td>
                    </tr>
                </c:forEach> 
            </table>

            <input type="submit" name="submitQuiz" value="Submit"/>
        </form>
    </body>
</html>