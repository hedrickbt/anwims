<%@ page 
language="java"
contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"
import="java.util.Map,
		java.util.HashMap,
		net.sf.json.JSONObject,
		net.sf.json.JSONArray,
		java.io.*,
		java.util.ArrayList,
		java.util.Random,
		com.anwim.microsoft.windows.CommandResponse,
		com.anwim.microsoft.windows.RunCommand,
		com.anwim.microsoft.windows.services.StopServicesCommand,
		com.anwim.microsoft.windows.services.ListServicesCommand,
		com.anwim.microsoft.windows.services.ServiceCommand"
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

		String server = request.getParameter("server");
		if (( server == null ) || ( server.length() == 0 )) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);	
			out.println("You must specify a value for the server parameter.");
			return;
		}

		String service = request.getParameter("service");
		if (( service == null ) || ( service.length() == 0 )) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);	
			out.println("You must specify a value for the service parameter.");
			return;
		}

		RunCommand cmd = new RunCommand();
		CommandResponse cmdResponse = new CommandResponse(); // unused
		StopServicesCommand ssc = new StopServicesCommand(cmd);
		ssc.execute(server, service); // the result here can contain error information

		// states for services 1=STOPPED (BLACK), 4=RUNNING (GREEN), 2=START_PENDING (YELLOW), 3=STOP_PENDING (RED)
		cmd = new RunCommand();
		cmdResponse = new CommandResponse(); // unused
		ListServicesCommand lsc = new ListServicesCommand(cmd);
		Map<String, String> mapOuter = lsc.execute(server);

		JSONObject jsonObject = JSONObject.fromObject( mapOuter );   
		out.println( jsonObject ); 
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
