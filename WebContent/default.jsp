<%@ page 
language="java"
contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"
import="java.util.Map,
		java.util.HashMap,
		net.sf.json.JSONObject,
		net.sf.json.JSONArray,
		java.io.*,
		java.util.ArrayList"
%>
<%
	try {
	/*
		String groups = request.getHeader("x-rh-group") == null?"":request.getHeader("x-rh-group");
		String user = request.getHeader("x-rh-username") == null?"":request.getHeader("x-rh-username");
		if (!groups.toUpperCase().matches(".*CN=Web Administration,.*".toUpperCase())) {
			if (
				!user.equalsIgnoreCase("joeuser") && 
				!user.equalsIgnoreCase("bobuser")
				) {
				response.setStatus(HttpServletResponse.SC_FORBIDDEN);
				return;
			}
		} 
		*/

		ArrayList<String> servers = new ArrayList<String>();
		servers.add("osprey");
		servers.add("jordan");
		
		JSONArray jsonArray = JSONArray.fromObject( servers );   
		out.println( jsonArray ); 
    } catch (Exception e) {
    	out.println(e.getMessage());
    	
    	StringWriter sw = new StringWriter();
		String callStack = null;
		try {
			PrintWriter p = new PrintWriter(sw);
			e.printStackTrace(p);
		} finally {
			try {
				sw.close();
			} catch (IOException e2) {
				out.println("<p>Something odd going on...");
			}
		}
		out.println("<pre>" + sw.toString()+"</pre>");
    }
%>
</BODY>
</HTML>
