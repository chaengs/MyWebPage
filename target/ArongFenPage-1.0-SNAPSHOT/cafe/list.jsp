<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="java.util.List"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=3;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=3;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	//검색 키워드 처리
	String keyword = request.getParameter("keyword");
	String condition = request.getParameter("condition");
	//만일 키워드가 넘어오지 않는다면
	if(keyword==null){
		keyword="";
		condition="";
	}
	//특수기호 인코딩
	String encodedK = URLEncoder.encode(keyword);
	//startRowNum 과 endRowNum  을 CafeDto 객체에 담고
	CafeDto dto=new CafeDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);

	List<CafeDto> list = null;
	int totalRow = 0;
	if(!keyword.equals("")){
			if(condition.equals("title_content")){
				dto.setTitle(keyword);
				dto.setContent(keyword);
				list = CafeDao.getInstance().getListTC(dto);
				totalRow = CafeDao.getInstance().getCountTC(dto);
			}else if(condition.equals("title")){
				dto.setTitle(keyword);
				list = CafeDao.getInstance().getListT(dto);
				totalRow = CafeDao.getInstance().getCountT(dto);
			}else if(condition.equals("writer")){
				dto.setWriter(keyword);
				list = CafeDao.getInstance().getListW(dto);
				totalRow = CafeDao.getInstance().getCountW(dto);
			}
	}else{
		list = CafeDao.getInstance().getList(dto);
		totalRow = CafeDao.getInstance().getCount();
	}
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	//전체 페이지의 갯수 구하기
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다. 
	}
	String id=(String)session.getAttribute("id");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="../css/style.css">
<style>
	a:link { color: black; text-decoration: none;}
	a:visited { color: black; text-decoration: none;}
	a:hover { color: blue; text-decoration: underline;}

	.alert {
		text-align: center;
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="cafe" name="thisPage"/>
</jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item active">
				<a href="${pageContext.request.contextPath}/file/list.jsp">자료실 목록</a>
			</li>
		</ul>
	</nav>
	<h3>게시판</h3>
	<table class="table table-hover">
		<thead class="table-light" id="tablecolor">
			<tr>
				<th>글번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>조회수</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<%for(CafeDto tmp:list){ %>
			<tr>
				<td><%=tmp.getNum() %></td>
				<td><%=tmp.getWriter() %></td>
				<td><a href="detail.jsp?num=<%=tmp.getNum()%>"><%=tmp.getTitle() %></a></td>
				<td><%=tmp.getViewCount() %></td>
				<td><%=tmp.getRegdate() %></td>
				<td>
					<%if(tmp.getWriter().equals(id)){ %>
					<a href="javascript:deleteConfirm(<%=tmp.getNum()%>)">삭제</a>
					<%}%>
				</td>
			</tr>
		<%} %>
		</tbody>
	</table>
	<button type="button" class="btn btn-sm" style="background-color: #DADAFC">
		<a href="${pageContext.request.contextPath}/cafe/private/insertform.jsp">글쓰기</a>
	</button>
	<nav>
		<ul class="pagination justify-content-center">
			<%if(startPageNum != 1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>">Prev</a>
				</li>
			<%}else{ %>
				<li class="page-item disabled">
					<a class="page-link" href="javascript:">Prev</a>
				</li>
			<%} %>
			<%for(int i=startPageNum; i<=endPageNum; i++) {%>
				<%if(i==pageNum){ %>
					<li class="page-item active">
						<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
					</li>
				<%}else{ %>
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
					</li>
				<%} %>
			<%} %>
			<%if(endPageNum < totalPageCount){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>">Next</a>
				</li>
			<%}else{ %>
				<li class="page-item disabled">
					<a class="page-link" href="javascript:">Next</a>
				</li>
			<%} %>
		</ul>
	</nav>
	<form action="list.jsp" method="get">
		<label for="condition">검색조건</label>
		<select name="condition" id="condition">
			<option value="title_content" <%=condition.equals("title_content") ? "selected" : ""%>>제목 + 내용</option>
			<option value="title" <%=condition.equals("title") ? "selected": ""%>>제목</option>
			<option value="writer" <%=condition.equals("writer") ? "selected" : ""%>>작성자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어 입력" value="<%=keyword%>">
		<button type="submit" class="btn btn-sm" style="background-color: #DADAFC">검색</button>
	</form>
</div>
<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
<%if(!keyword.equals("")){ %>
<div class="alert center-block" style="background-color : #DADAFC; width: 70%; float: none; margin: 0 auto">
	<strong><%=totalRow %></strong> 개의 자료가 검색되었습니다.
</div>
<%} %>
</div>
<script>
	function deleteConfirm(num){
		let isDelete=confirm(num+"번 파일을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="private/delete.jsp?num="+num;
		}
	}
</script>
</body>
</html>







