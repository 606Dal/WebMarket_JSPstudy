package mvc.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.BCommand;
import mvc.command.BDeleteCommand;
import mvc.command.BListCommand;
import mvc.command.BUpdateCommand;
import mvc.command.BViewCommand;
import mvc.command.BWriteCommand;
import mvc.command.BWriteFormCommand;


/* @WebServlet("*.do") */
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("actionDo");
		
		BCommand com = null;
		String viewPage = null;
		
		//getRequestURI()는 요청된 전체 uri를 가져옴
		String uri = request.getRequestURI();
		System.out.println("URI : " + uri);
		
		//getContextPath()는 프로젝트명이 리턴됨
		String contextPath = request.getContextPath();
		System.out.println("contextPath : " + contextPath);
		
		//직접 실행되어야 할 파일의 이름을 얻어내는 것
		String command = uri.substring(contextPath.length());
		System.out.println("command : " + command);
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		
		//command패턴에 따라서 분기를 하는 코드
		if(command.equals("/BoardListAction.do")) { //DB에 저장되어 있는 모든 게시글을 출력하는 부분
			System.out.println("------------------------------");
			System.out.println("/BoardListAction.do 페이지 호출");
			System.out.println("------------------------------");
			com = new BListCommand();
			com.execute(request, response);
			System.out.println("BoardListAction의 execute()실행 완료");
			viewPage = "./board/list.jsp";
		}
		else if (command.equals("/BoardWriteForm.do")) { //글 작성을 위해 폼을 호출(회원의 로그인 정보를 가져옴)
			System.out.println("------------------------------");
			System.out.println("/BoardWriteForm.do 페이지 호출");
			System.out.println("------------------------------");
			com = new BWriteFormCommand();
			com.execute(request, response);
			System.out.println("BoardWriteForm의 execute()실행 완료");
			viewPage = "./board/writeForm.jsp";
		}
		else if (command.equals("/BoardWriteAction.do")) { //게시글을 쓰고 DB에 저장
			System.out.println("------------------------------");
			System.out.println("/BoardWriteAction.do 페이지 호출");
			System.out.println("------------------------------");
			com = new BWriteCommand();
			com.execute(request, response);
			System.out.println("BoardWriteAction의 execute()실행 완료");
			viewPage = "/BoardListAction.do";
		}
		else if (command.equals("/BoardViewAction.do")) { //게시글의 제목을 클릭하면 상세 내용을 보는 코드
			System.out.println("------------------------------");
			System.out.println("/BoardViewAction.do 페이지 호출");
			System.out.println("------------------------------");
			com = new BViewCommand();
			com.execute(request, response);
			System.out.println("BoardViewAction의 execute()실행 완료");
			viewPage = "./board/view.jsp";
		}
		else if (command.equals("/BoardUpdateAction.do")) { //게시글의 상세내용에서 수정 눌렀을 때
			System.out.println("------------------------------");
			System.out.println("/BoardUpdateAction.do 페이지 호출");
			System.out.println("------------------------------");
			com = new BUpdateCommand();
			com.execute(request, response);
			System.out.println("BoardUpdateAction의 execute()실행 완료");
			viewPage = "/BoardListAction.do";
		}
		else if (command.equals("/BoardDeleteAction.do")) { //게시글의 상세내용에서 수정 눌렀을 때
			System.out.println("------------------------------");
			System.out.println("/BoardDeleteAction.do 페이지 호출");
			System.out.println("------------------------------");
			com = new BDeleteCommand();
			com.execute(request, response);
			System.out.println("BoardDeleteAction의 execute()실행 완료");
			viewPage = "/BoardListAction.do";
		}
		
		
		//위의 분기문에서 설정된 뷰(.jsp)파일을 가지고 페이지 이동을 하는 코드
		RequestDispatcher rd = request.getRequestDispatcher(viewPage);
		rd.forward(request, response);
		
	}

}
