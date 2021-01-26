<%@page import="test.file.dto.FileDto"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="java.util.List"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=5;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;

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

	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	//만일 키워드가 넘어오지 않는다면
	if(keyword==null){
		keyword="";
		condition="";
	}
	//특수기호를 인코딩할 키워드를 미리 준비한다.
	String encodedK= URLEncoder.encode(keyword);
	//startRowNum 과 endRowNum  을 FileDto 객체에 담고
	FileDto dto=new FileDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);

	//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
	List<FileDto> list=null;
	//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
	int totalRow=0;
	//만일 검색 키워드가 넘어온다면
	if(!keyword.equals("")){
		//검색 조건이 무엇이냐에 따라 분기 하기
		if(condition.equals("title_filename")){//제목 + 파일명 검색인 경우
			//검색 키워드를 FileDto 에 담아서 전달한다.
			dto.setTitle(keyword);
			dto.setOrgFileName(keyword);
			//제목+파일명 검색일때 호출하는 메소드를 이용해서 목록 얻어오기
			list = FileDao.getInstance().getListTF(dto);
			//제목+파일명 검색일때 호출하는 메소드를 이용해서 row  의 갯수 얻어오기
			totalRow = FileDao.getInstance().getCountTF(dto);
		}else if(condition.equals("title")){ //제목 검색인 경우
			dto.setTitle(keyword);
			list = FileDao.getInstance().getListT(dto);
			totalRow = FileDao.getInstance().getCountT(dto);
		}else if(condition.equals("writer")){ //작성자 검색인 경우
			dto.setWriter(keyword);
			list = FileDao.getInstance().getListW(dto);
			totalRow = FileDao.getInstance().getCountW(dto);
		} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
	}else{//검색 키워드가 넘어오지 않는다면
		//키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다.
		list=FileDao.getInstance().getList(dto);
		//키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
		totalRow=FileDao.getInstance().getCount();
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
	//로그인된 아이디가 있는지 읽어와본다 (로그인을 하지 않았으면 null 이다)
	String id=(String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>/file/list.jsp</title>
	<jsp:include page="../include/resource.jsp"></jsp:include>
	<style>
		a:link { color: black; text-decoration: none;}
		a:visited { color: black; text-decoration: none;}
		a:hover { color: blue; text-decoration: underline;}

		.alert{
			text-align: center;
		}
		.card img {
			height: 150px;
		}
	</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="file" name="thisPage"/>
</jsp:include>
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item active">
				<a href="${pageContext.request.contextPath}/file/list.jsp">자료실</a>
			</li>
		</ul>
	</nav>
	<h3>자료실</h3>
	<table class="table table-hover">
		<thead class="table-dark" style="background-color: #C5A3FF">
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>파일명</th>
				<th>크기</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<%for(FileDto tmp : list){%>
		<tr>
			<td><%=tmp.getNum() %></td>
			<td><%=tmp.getWriter() %></td>
			<td><%=tmp.getTitle() %></td>
			<td><a href="download.jsp?num=<%=tmp.getNum()%>"><%=tmp.getOrgFileName() %></a></td>
			<td><%=tmp.getFileSize() %></td>
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
	<button type="button" class="btn btn-sm" style="background-color: #C5A3FF">
		<a href="private/upload_form.jsp">파일 업로드</a>
	</button>
	<nav>
		<ul class="pagination justify-content-center">
			<%if(startPageNum != 1){ %>
			<li class="page-item">
				<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition%>&keyword=<%=encodedK%>">Prev</a>
			</li>
			<%}else{ %>
			<li class="page-item disabled">
				<a class="page-link" href="javascript:">Prev</a>
			</li>
			<%} %>
			<%for(int i=startPageNum; i<=endPageNum; i++) {%>
			<%if(i==pageNum){ %>
			<li class="page-item active">
				<a class="page-link" href="list.jsp?pageNum=<%=i %>&condition=<%=condition%>&keyword=<%=encodedK%>"><%=i %></a>
			</li>
			<%}else{ %>
			<li class="page-item">
				<a class="page-link" href="list.jsp?pageNum=<%=i %>&condition=<%=condition%>&keyword=<%=encodedK%>"><%=i %></a>
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
			<option value="title_filename" <%=condition.equals("title_filename") ? "selected" : ""%>>제목+파일명</option>
			<option value="title" <%=condition.equals("title") ? "selected" : ""%>>제목</option>
			<option value="writer" <%=condition.equals("writer") ? "selected" : ""%>>작성자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어" value="<%=keyword%>"/>
		<button type="submit">검색</button>
	</form>
	<%-- 만일 검색 키워드가 존재한다면 몇개의 글이 검색 되었는지 알려준다. --%>
	<%if(!keyword.equals("")){ %>
	<div class="alert alert-success center-block">
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