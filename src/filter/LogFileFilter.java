package filter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;


public class LogFileFilter implements Filter {
	
	PrintWriter writer = null;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("LogFilter초기화");
		String filename = filterConfig.getInitParameter("filename");
		
		//파일이 없을 경우
		if(filename == null) {
			throw new ServletException("로그 파일의 이름을 찾을 수 없습니다.");
		}
		
		/* 매개 변수로 받는 값이 FileWriter보조스트림을 연결하는데 true값은 파일을 덮어쓰기를하지 않고
		 * 이어서 계속 로그 기록을 남기기 위한 속성을 정의한 것.
		 * PrintWriter 주스트림의 매개변수 중 true는 autoFlush를 하라는 뜻.*/	
		try {
			writer = new PrintWriter(new FileWriter(filename, true), true);
		} catch (IOException e) { e.printStackTrace(); }	
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//요청한 클라이언트의 IP를 얻어오고 있음.
		String clientAddr = request.getRemoteAddr();
		writer.println("접속한 클라이언트 IP : " + clientAddr);
		writer.println("접근한 URL경로 : " + this.getURLPath(request));
		long start = System.currentTimeMillis();
		writer.println("요청 처리 시작 시각 : " + this.getCurrentTime());
		chain.doFilter(request, response);
		long end = System.currentTimeMillis();
		writer.println("요청 처리 종료 시각 : " + this.getCurrentTime());
		writer.println("요청 처리 소요 시간 : " + (end-start) + "ms");
		writer.println("===================================================");
		
	}
	
	@Override
	public void destroy() {
		System.out.println("LogFilter해제");
		writer.close(); // 리소스 해제
	}
	
	public String getURLPath(ServletRequest request) {
		
		HttpServletRequest hRequest = null;
		String currentPath = "";
		String queryString = "";
		
		if(request instanceof HttpServletRequest) {
			hRequest = (HttpServletRequest)request; //다운 캐스팅
			currentPath = hRequest.getRequestURI(); //URI 가져오기
			//아래는 post면 null일 것이고, get이면 뒤의 코드가 올 것
			queryString = (queryString == null) ? "" : "?" + hRequest.getQueryString();
		}
		
		return currentPath + queryString;
	}
	
	public String getCurrentTime() {
		SimpleDateFormat sformat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		return sformat.format(new Date());
	}

}
