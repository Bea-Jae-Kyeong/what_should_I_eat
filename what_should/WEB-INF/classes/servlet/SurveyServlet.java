package servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/SurveyServlet")
public class SurveyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SurveyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Survey servlet");
		HttpSession session = request.getSession();
		String sid = request.getParameter("sid");
		System.out.println("가게 id: "+sid);
		String sname = request.getParameter("sname");
		System.out.println("가게이름: "+sname);
		String menu = request.getParameter("menu");
		System.out.println("대표메뉴: "+menu);
		String genre = request.getParameter("genre");
		System.out.println("종류:"+genre);
		String flour = request.getParameter("flour");
		System.out.println("밥 면:"+flour);
		String meat = request.getParameter("meat");
		System.out.println("고기:"+meat);
		String size = request.getParameter("size");
		System.out.println("양:"+size);
		String cost = request.getParameter("cost");
		System.out.println("가격:"+cost);
		String soup = request.getParameter("soup");
		System.out.println("국물:"+soup);
	
		// attribute가 set되어 jsp에서 필요한 값들을 servlet에서 받아올 수 있게 함
		session.setAttribute("sid", sid);
		session.setAttribute("sname", sname);
		session.setAttribute("menu", menu);
		session.setAttribute("genre", genre);
		session.setAttribute("flour", flour);
		session.setAttribute("meat", meat);
		session.setAttribute("size", size);
		session.setAttribute("cost", cost);
		session.setAttribute("soup", soup);
		
		String suc = "1-2.jsp";
		response.sendRedirect(suc);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}