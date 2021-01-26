package test.users.dao;

import test.users.dto.UsersDto;
import test.util.DbcpBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsersDao {

    private static UsersDao dao;
    private UsersDao(){}
    public static UsersDao getInstance(){
        if(dao == null){
            dao = new UsersDao();
        }
        return dao;
    }
    //프로필 이미지 수정
    public boolean updateProfile(UsersDto dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int flag = 0;
        try {
            conn = new DbcpBean().getConn();
            //실행할 insert, update, delete 문 구성
            String sql = "update users"
                    + " set profile = ?"
                    + " where id = ?";
            pstmt = conn.prepareStatement(sql);
            //? 에 바인딩할 내용이 있으면 바인딩한다.
            pstmt.setString(1, dto.getProfile());
            pstmt.setString(2, dto.getId());
            flag = pstmt.executeUpdate(); //sql 문 실행하고 변화된 row 갯수 리턴 받기
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {}
        }
        if (flag > 0) {
            return true;
        } else {
            return false;
        }
    }

    //회원 정보 수정
    public boolean update(UsersDto dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int flag = 0;
        try {
            conn = new DbcpBean().getConn();
            //실행할 insert, update, delete 문 구성
            String sql = "update users"
                    + " set email = ?"
                    + " where id = ?";
            pstmt = conn.prepareStatement(sql);
            //? 에 바인딩할 내용이 있으면 바인딩한다.
            pstmt.setString(1, dto.getEmail());
            pstmt.setString(2, dto.getId());
            flag = pstmt.executeUpdate(); //sql 문 실행하고 변화된 row 갯수 리턴 받기
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {}
        }
        if (flag > 0) {
            return true;
        } else {
            return false;
        }
    }
    //비번 수정
    public boolean updatePwd(UsersDto dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int flag = 0;
        try {
            conn = new DbcpBean().getConn();
            //실행할 insert, update, delete 문 구성
            String sql = "update users"
                    + " set pwd=?"
                    + " where id=? and pwd=?";
            pstmt = conn.prepareStatement(sql);
            //? 에 바인딩할 내용이 있으면 바인딩한다.
            pstmt.setString(1, dto.getNewPwd()); //새 비밀번호
            pstmt.setString(2, dto.getId());
            pstmt.setString(3, dto.getPwd()); //구 비밀번호
            flag = pstmt.executeUpdate(); //sql 문 실행하고 변화된 row 갯수 리턴 받기
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {}
        }
        if (flag > 0) {
            return true;
        } else {
            return false;
        }
    }
    //회원 탈퇴
    public boolean delete(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int flag = 0;
        try {
            conn = new DbcpBean().getConn();
            //실행할 insert, update, delete 문 구성
            String sql = "delete from users"
                    + " where id=?";
            pstmt = conn.prepareStatement(sql);
            //? 에 바인딩할 내용이 있으면 바인딩한다.
            pstmt.setString(1, id);
            flag = pstmt.executeUpdate(); //sql 문 실행하고 변화된 row 갯수 리턴 받기
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {}
        }
        if (flag > 0) {
            return true;
        } else {
            return false;
        }
    }
    //가입 정보
    public UsersDto getData(String id) {
        //회원 정보를 담을 UsersDto
        UsersDto dto = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = new DbcpBean().getConn();
            //select 문 작성
            String sql = "select pwd,email,profile,regdate"
                    + " from users"
                    + " where id=?";
            pstmt = conn.prepareStatement(sql);
            // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
            pstmt.setString(1, id);
            //select 문 수행하고 ResultSet 받아오기
            rs = pstmt.executeQuery();
            //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
            if (rs.next()) {
                dto=new UsersDto();
                dto.setId(id);
                dto.setPwd(rs.getString("pwd"));
                dto.setEmail(rs.getString("email"));
                dto.setProfile(rs.getString("profile"));
                dto.setRegdate(rs.getString("regdate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {}
        }
        return dto;
    }

    //아이디 중복확인
    public boolean isExist(String id){
        boolean isExist=false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = new DbcpBean().getConn();
            //select 문 작성
            String sql = "select * "
                    + " from users"
                    + " where id=?";
            pstmt = conn.prepareStatement(sql);
            // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
            pstmt.setString(1, id);
            //select 문 수행하고 ResultSet 받아오기
            rs = pstmt.executeQuery();
            //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
            if (rs.next()) {
                isExist=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {}
        }
        //아이디가 이미 존재하는지 여부를 리턴해준다.
        return isExist;
    }
    //로그인시 아이디 확인
    public boolean isValid(UsersDto dto) {
        //아이디 비밀번호가 유효한 정보인지 여부를 담을 지역변수 만들고 초기값 부여
        boolean isValid=false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = new DbcpBean().getConn();
            //select 문 작성
            String sql = "SELECT id"
                    + " FROM users"
                    + " WHERE id=? AND pwd=?";
            pstmt = conn.prepareStatement(sql);
            // ? 에 바인딩 할게 있으면 여기서 바인딩한다.
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPwd());
            //select 문 수행하고 ResultSet 받아오기
            rs = pstmt.executeQuery();
            //while문 혹은 if문에서 ResultSet 으로 부터 data 추출
            if(rs.next()) {//만일 select 된 row 가 있다면
                //유효한 정보임으로 isValid 에 true 를 대입한다.
                isValid=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {}
        }
        //아이디가 유효한지 여부를 리턴해준다.
        return isValid;
    }
    //회원 가입
    public boolean insert(UsersDto dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int flag = 0;
        try {
            conn = new DbcpBean().getConn();
            String sql = "insert into users"
                    + " (id, pwd, email, regdate)"
                    + " values(?, ?, ?, sysdate)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPwd());
            pstmt.setString(3, dto.getEmail());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try{
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            }catch(Exception e){}
        }
        if(flag > 0){
            return true;
        }else{
            return false;
        }
    }
}
