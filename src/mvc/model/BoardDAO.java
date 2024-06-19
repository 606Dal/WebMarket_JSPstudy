package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class BoardDAO {

	//DB접속시 필요한 멤버객체를 선언하고 있음
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private ArrayList<BoardDTO> dtos = null;
	private static BoardDAO instance;

	
	public BoardDAO() {
	}

	//싱글톤 패턴(최초 한 번 생성해서 재활용)으로 BoardDAO객체를 하나만 만들어서 리턴하고 있음
	public static BoardDAO getInstance() {
		if(instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}
	
	//board테이블의 레코드 개수를 가져오는 메서드
	public int getListCount(String items, String text) {
	
		int count = 0;
		String sql = "";
		
		//파라미터로 넘어오는 검색 기능이 둘 다 아무 값도 없다면
			if(items==null && text==null) {
				sql = "select count(*) from board";
			}
			else {
				//파라미터로 넘어오는 값으로 검색 기능을 하게끔 쿼리를 작성함.		이 글자와 유사한 것
				sql = "select count(*) from board where " + items + " like '%" + text + "%'"; 
			}
			
			try {
				conn = DBConnection.getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch (Exception e) {
				System.out.println("getBoardCount()예외" + e.getMessage());
				e.printStackTrace();
			}finally {
				try {
					if(rs != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				} catch (Exception e2) {
					System.out.println("getBoardCount() close()호출 예외" + e2.getMessage());
					e2.printStackTrace();
				}
			}
		return count;
	}
	
	
	//board테이블에 있는 레코드를 가져오는 메서드	items : 제목, 본문, 글쓴이. text : 검색한 단어
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text){
		
		int total_record = getListCount(items,text);
		int start = (page - 1) * limit; //페이지는 0페이지가 없으므로 -1을 함
		int index = start + 1;
		
		String sql = "";
		dtos = new ArrayList<BoardDTO>();
		
		//파라미터로 넘어오는 검색 기능이 둘 다 아무 값도 없다면
		if(items==null && text==null) {
			sql = "select * from board order by num desc";
		}
		else {
			//파라미터로 넘어오는 값으로 검색 기능을 하게끔 쿼리를 작성함.		이 글자와 유사한 것
			sql = "select * from board where " + items + " like '%" + text + "%' order by num desc"; 
		}
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();
			//페이지가 0이나 음수가 넘어오면 문제가 생겨서 절대값으로 받음
			while(rs.absolute(index)) {
				BoardDTO board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				
				dtos.add(board);
				
				//인덱스가 가져올 데이터 건수 보다 작다면
				if(index < (start + limit) && index <= total_record) {
					index++;
				}
				else {
					break;
				}
			}
		}catch (Exception e) {
			System.out.println("getBoardList()예외 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				System.out.println("getBoardList() close()호출 예외 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		return dtos;
	}
	
	//member 테이블에서 인증된 id의 사용자명 가져오기
	public String getLoginName(String id) {
		
		String name = null;
		String sql = "select * from members where id = ?";
		System.out.println("getLoginName() 들어옴");
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				name = rs.getString("name");
			}
			
		} catch (Exception e) {
			System.out.println("getLoginNameNum예외 발생 : " + e.getMessage());
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				System.out.println("getLoginName() close()호출 예외 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		return name;
	}
	
	//board테이블에 새로운 글을 저장하는 부분
	public void insertBoard(BoardDTO board) {
		
		String sql = "alter table board auto_increment = 1";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			
			sql = "insert into board values(?,?,?,?,?,?,?,?)"; 
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board.getNum());
			pstmt.setString(2, board.getId());
			pstmt.setString(3, board.getName());
			pstmt.setString(4, board.getSubject());
			pstmt.setString(5, board.getContent());
			pstmt.setString(6, board.getRegist_day());
			pstmt.setInt(7, board.getHit());
			pstmt.setString(8, board.getIp());
			
			pstmt.executeUpdate();
			System.out.println("insertBoard() 수행 완료");
			
		} catch (Exception e) {
			System.out.println("insertBoard() 예외 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				System.out.println("insertBoard() close()호출 예외 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
	}
	//선택된 게시글의 상세 내용을 가져오는 메서드
	public BoardDTO getBoardByNum(int num, int pageNum) {
		
		BoardDTO board = null;
		String sql = "select * from board where num = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
			}
			System.out.println("getBoardByNum() 수행 완료");
		} catch (Exception e) {
			System.out.println("getBoardByNum() 예외 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) pstmt.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				System.out.println("getBoardByNum() close()호출 예외 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		//조회 수를 증가시키는 메서드 호출 부분
		updateHit(num);
		
		return board;
	}

	//선택된 글의 조회 수를 증가시키는 메서드
	private void updateHit(int num) {
		
		String sql = "select hit from board where num = ?";
		int hit = 0;
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				hit = rs.getInt("hit") + 1;
			}
			
			sql = "update board set hit = ? where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hit);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
			System.out.println("updateHit() 수행 완료");
		} catch (Exception e) {
			System.out.println("updateHit() 예외 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) pstmt.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				System.out.println("updateHit() close()호출 예외 : " + e2.getMessage());
				e2.printStackTrace();
			}
		
		}
	}

	//게시글 수정한 내용을 DB에 저장하는 메서드
	public void updateBoard(BoardDTO board) {

		String sql = "update board set subject = ?, content = ?, regist_day = ?, hit = ? where num = ?"; 
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getRegist_day());
			pstmt.setInt(4, board.getHit());
			pstmt.setInt(5, board.getNum());
			
			pstmt.executeUpdate();
			System.out.println("updateBoard() 수행 완료");
		} catch (Exception e) {
			System.out.println("updateBoard() 예외 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				System.out.println("updateBoard() close()호출 예외 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
	}
	//선택된 글을 삭제하는 메서드
	public void deleteBoard(int num) {
		
		String sql = "delete from board where num = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			System.out.println("deleteBoard() 수행 완료");
		} catch (Exception e) {
			System.out.println("deleteBoard() 예외 발생 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				System.out.println("deleteBoard() close()호출 예외 : " + e2.getMessage());
				e2.printStackTrace();
			}
		}
		
	}
	
	
	
	
}
