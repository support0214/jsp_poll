<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Poll</title>
<style>
	body { background-color : #FAEBFF; }
	a {color:black;}
	hr { width :700px; background-color: #7C6D93; height:1px; border:0;}
	table{border : 3px solid #7C6D93; border-collapse:collapse; width:600px;}
	tr, th, td {border : 1px dotted #6A5B81; padding:3px 2px;}
</style>
</head>
<body>
	<div align="center">
		<h1>투표프로그램</h1>
		<hr>
		
		<h4>설문작성</h4>
		<form method="post" action="pollInsertProc.jsp">
			<table>
				<tr>
					<th>질문</th>
					<td colspan="2">q: <input name="question" size="30"></td>
				</tr>
				<tr>
					<th rowspan="7">항목</th>
				<%
					for (int i = 1; i <= 4; i++) {
						out.print("		<td>" + (i * 2 - 1) + ": <input name='item'></td>");
						out.print("		<td>" + (i * 2) + ": <input name='item'></td>");
						out.print("</tr>");
						if(i<4)
							out.print("<tr>");
					}
				%>
				<tr>
					<td>시작일</td>
					<td>
						<select name="sdateY">
							<option value="2023">2023
							<option value="2024">2024
						</select>년 
						<select name="sdateM">
							<%
								for (int i = 1; i <= 12; i++) {
									out.println("<option value='" + i + "'>" + i);
								}
							%>
						</select>월 
						<select name="sdateD">
							<%
								for (int i = 1; i <= 31; i++) {
									out.println("<option value='" + i + "'>" + i);
								}
							%>
						</select>일
					</td>
				</tr>
				<tr>
					<td>종료일</td>
					<td><select name="edateY">
							<option value="2023">2023
							<option value="2024">2024
						</select>년 
						<select name="edateM">
							<%
								for (int i = 1; i <= 12; i++) {
									out.println("<option value='" + i + "'>" + i);
								}
							%>
						</select>월 
						<select name="edateD">
							<%
								for (int i = 1; i <= 31; i++) {
									out.println("<option value='" + i + "'>" + i);
								}
							%>
						</select>일
					</td>
				</tr>
				<tr>
					<td>이중답변</td>
					<td>
						<input type="radio" name="type" value="1" checked>yes 
						<input type="radio" name="type" value="0">no
					</td>
				</tr>
				<tr>
					<th colspan=3>
						<input type="submit" value="작성하기"> 
						<input type="reset" value="다시쓰기"> 
						<input type="button" value="리스트" onclick="location.href='pollList.jsp'">
					</th>
				</tr>	
				
			</table>
		</form>
	</div>
</body>
</html>