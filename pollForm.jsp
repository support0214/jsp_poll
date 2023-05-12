<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, poll.*" %>
<jsp:useBean id="pMgr" class="poll.PollMgr" />
<%
	int num = 0;
	if(!(request.getParameter("num")==null || request.getParameter("num").equals(""))) {
		num = Integer.parseInt(request.getParameter("num"));
	}
	PollListBean plBean = pMgr.getList(num);
	ArrayList<String> alist = pMgr.getItem(num);
	
	String question = plBean.getQuestion();
	int type = plBean.getType();
	int active = plBean.getActive();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="pollFormProc.jsp">
		<table>
			<tr>
				<td>Q : <%=question %></td>
			</tr>
			<tr>
				<td>
				<%
					for(int i=0; i<alist.size(); i++) {
						String itemList = alist.get(i);
						if(type==1) {
							out.print("<input type=checkbox name='itemnum' value='"+ i +"'>");
						} else {
							out.print("<input type=radio name='itemnum' value='"+ i +"'>");
						}
						out.print(itemList + "<br>");
					}
				%>
				</td>
			</tr>
			<tr>
				<td>
			<%
				if(active == 1) {
					out.print("<input type='submit' value='투표'>");
				} else {
					out.print("투표");
				}
			%>
				&emsp;&emsp;<input type="button" value="결과" 
							onclick="window.open('pollView.jsp?num=<%=num%>', 'PollView', 'width=500, height=400')">
				</td>
			</tr>
		</table>
		<input type="hidden" name="num" value="<%=num %>">
	</form>
</body>
</html>