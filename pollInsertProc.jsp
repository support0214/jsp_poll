<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="pMgr" class="poll.PollMgr" />

<jsp:useBean id="plBean" class="poll.PollListBean" />
<jsp:setProperty property="*" name="plBean" />

<jsp:useBean id="piBean" class="poll.PollItemBean" />
<jsp:setProperty property="*" name="piBean" />
<%
	String sdate = request.getParameter("sdateY") + "-"
				 + request.getParameter("sdateM") + "-"
				 + request.getParameter("sdateD");
	String edate = request.getParameter("edateY") + "-"
			 	 + request.getParameter("edateM") + "-"
			 	 + request.getParameter("edateD");
	
	plBean.setSdate(sdate);
	plBean.setEdate(edate);
	
	boolean result = pMgr.insertPoll(plBean, piBean);
	
	String msg = "설문 추가에 실패하였습니다";
	String url = "pollInsert.jsp";
	if(result) {
		msg = "설문이 추가 되었습니다";
		url = "pollList.jsp";
	}
%>
<script type="text/javascript">
	alert("<%=msg %>");
	location.href="<%=url %>";
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