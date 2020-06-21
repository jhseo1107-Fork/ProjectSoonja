package kr.kro.jhseo1107;

import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Edit")
public class Edit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Edit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, FileNotFoundException {
		// TODO Auto-generated method stub
		try {
				String path = Pathstring.path;
				String id = request.getParameter("userID");
				String nickname = request.getParameter("userName");
				String text = request.getParameter("userText");
				if(text.isBlank() || nickname.isBlank())
				{
					alertredirect("공백이 있으면 안됩니다.", "editor.jsp", request, response);
					return;
				}
				
								
				JSONObject userfile = new JSONObject();
				userfile.put("id", id);
				userfile.put("nickname", nickname);
				userfile.put("text", text);
				FileWriter file2 = new FileWriter(path+"\\"+id+".json");
				file2.write(userfile.toJSONString());
				file2.close();

				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.write("<form name='hiddenform' method='get' action='users.jsp'>");
				out.write("<input type='hidden' name='userID' value='"+id+"'>");
				out.write("</form>");
				out.write("<script>");
				out.write("document.hiddenform.submit();");
				out.write("</script>");
		} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		}
		
		
	}
	private void alertredirect(String alrettext, String redirecturl, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();

		out.write("<script>");
		out.write("alert('"+ alrettext +"'); window.location.href='register.jsp';");
		out.write("</script>");
	}
}
