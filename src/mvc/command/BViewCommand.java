package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

//DB에 저장되어 있는 게시글을 보고자 할 때 실행하는 커맨드 객체
public class BViewCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		BoardDAO bDao = BoardDAO.getInstance();
		//보고자 하는 게시글의 순번을 가져오고 있는 코드
		int num = Integer.parseInt(request.getParameter("num"));
		//보고자 하는 게시글이 있는 페이지 수를 가져오고 있는 코드
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		BoardDTO board = new BoardDTO();
		board = bDao.getBoardByNum(num, pageNum);
		
		request.setAttribute("num", num);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("board", board);
		
		
	}

}
