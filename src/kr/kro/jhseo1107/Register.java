package kr.kro.jhseo1107;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
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
				String id = request.getParameter("userID");
				String pw = request.getParameter("userPW");
				String nickname = request.getParameter("userName");
				if(id.contains(" ") || pw.contains(" ") || nickname.isBlank() || pw.isBlank() || id.isBlank())
				{
					alertredirect("공백이 있으면 안됩니다.", "register.jsp", request, response);
					return;
				}
				
				String hashedpw = sha256(pw);
				
				String path = Pathstring.path;
				JSONParser parser = new JSONParser();
				Reader reader= new FileReader(path+"\\userlist.json");
				JSONObject object;
				object = (JSONObject) parser.parse(reader);
				JSONArray names = (JSONArray) object.get("users");
				Iterator<String> iterator = names.iterator();
				
				/*while(iterator.hasNext())
				{
					if(iterator.next().equals(id))
					{
						alertredirect("이미 사용중인 ID입니다.", "register.jsp", request, response);
					}
				}*/
				File checkingfile = new File(path+"\\"+id+".json");
				if(checkingfile.exists())
				{
					alertredirect("이미 사용중인 ID입니다.", "register.jsp", request, response);
					return;
				}
				
				JSONObject editedobject = new JSONObject();
				JSONArray editednames = new JSONArray();
				while(iterator.hasNext())
				{
					editednames.add(iterator.next());
				}
				editednames.add(id);
				editedobject.put("users", editednames);
				FileWriter file = new FileWriter(path+"\\userlist.json");
				file.write(editedobject.toJSONString());
				file.close();
				
				nickname.replace(' ', '>');
				
				JSONObject userfile = new JSONObject();
				userfile.put("id", id);
				userfile.put("pw", hashedpw);
				userfile.put("nickname", nickname);
				userfile.put("text", "Sample text. Login to edit.");
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
		} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
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
	public static String bytesToHex(byte[] bytes)
	{
		StringBuilder builder = new StringBuilder();
		for (byte b: bytes)
		{
			builder.append(String.format("%02x", b));
		}
		return builder.toString();
	}
	public static String sha256(String msg) throws NoSuchAlgorithmException
	{
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(msg.getBytes());
		
		return bytesToHex(md.digest());
	}
}
