package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface BCommand {
	//각 구현 객체의 구현부에서 필요한 것들 작성
	public void execute(HttpServletRequest request, HttpServletResponse response);

}
