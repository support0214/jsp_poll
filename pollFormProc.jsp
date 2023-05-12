<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id ="pMgr" class="poll.PollMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String[] itemnum = request.getParameterValues("itemnum"); // 배열을 담기위해서는 values를 붙여준다
    boolean result=pMgr.updatePoll(num, itemnum);
	String msg = "투표가 등록되지 않았습니다";
	if(result) {
		msg = "투료가 정상적으로 등록되었습니다";
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "pollList.jsp?num=<%= num %>";
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>