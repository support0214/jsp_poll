<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, poll.*" %>
<jsp:useBean id="pMgr" class="poll.PollMgr" />
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
	tr, th, td {border : 1px dotted #6A5B81; }
</style>
</head>
<body>
	<div align="center">
		<h1>투표프로그램</h1>
		<hr>
		
		<h4>설문폼</h4>
		<jsp:include page="pollForm.jsp" />
		<hr>
		
		<h4>설문리스트</h4>
		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>시작일 ~ 종료일</th>
			</tr>
		<%
			ArrayList<PollListBean> alist = pMgr.getAllList();
		
			int count = alist.size();
			for(int i=0; i<alist.size(); i++) {
				PollListBean plBean = alist.get(i);
				int num = plBean.getNum();
				String question = plBean.getQuestion();
				String sdate = plBean.getSdate();
				String edate = plBean.getEdate();
				
				out.print("<tr>");
				out.print("	<td>"+ count +"</td>");
				out.print("	<td><a href='pollList.jsp?num="+ num +"'>"+ question +"</a></td>");
				out.print("	<td>"+ sdate + " ~ " + edate +"</td>");
				out.print("</tr>");
				count--;
			}
		%>
			<tr>
				<td colspan="3" align="right"><a href="pollInsert.jsp">설문작성하기</a></td>
			</tr>
		</table>
	</div>
</body>
</html>