<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="test.users.dto.UsersDto" %>
<%@ page import="test.users.dao.UsersDao" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Tomcat 서버를 실행했을때 WebContent/upload 폴더의 실제 경로 얻어오기
    String realPath=application.getRealPath("/upload");
    System.out.println("realPath:"+realPath);
    //해당 경로를 access 할수 있는 파일 객체 생성
    File f=new File(realPath);
    if(!f.exists()){ //만일  폴더가 존재 하지 않으면
        f.mkdir(); //upload 폴더 만들기
    }
    //최대 업로드 사이즈 설정
    int sizeLimit=1024*1024*5; // 5 MByte
    MultipartRequest mr=new MultipartRequest(request,
            realPath,
            sizeLimit,
            "utf-8",
            new DefaultFileRenamePolicy());
    //업로드된 이미지의 원본 파일명
    String orgFileName=mr.getOriginalFileName("image");
    //upload  폴더에 실제 저장된 파일명
    String saveFileName=mr.getFilesystemName("image");
    //로그인된 아이디
    String id=(String)session.getAttribute("id");
    //저장된 파일명을 이용해서 프로필 이미지 경로를 구성한다.
    String profile="/upload/"+saveFileName;
    //UsersDto 객체에 담아서
    UsersDto dto=new UsersDto();
    dto.setId(id);
    dto.setProfile(profile);
    //DB 에 반영하기
    UsersDao.getInstance().updateProfile(dto);
    //개인정보 수정 페이지로 리다일렉트
    String cPath=request.getContextPath();
    response.sendRedirect(cPath+"/users/private/updateform.jsp");
%>