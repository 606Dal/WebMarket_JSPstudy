package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;

//게시판의 게시글 작성을 위해서 사용자 명을 가져오는 커맨드 객체이다. 
public class BWriteFormCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("BWriteFormCommand클래스 들어옴");
		BoardDAO bDao = BoardDAO.getInstance();
		String id = request.getParameter("id");
		
		String name = bDao.getLoginName(id);
		request.setAttribute("name", name);
		System.out.println("BWriteFormCommand클래스 실행 후 나감");
	}
}
