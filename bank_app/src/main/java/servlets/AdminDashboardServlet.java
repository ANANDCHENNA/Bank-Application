package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String adminName = (String) session.getAttribute("adminName");

        // Check if adminName is not already set in session
        if (adminName == null) {
            adminName = "Admin"; // Set default admin name if not fetched from database
            session.setAttribute("adminName", adminName); // Set adminName in session
        }

        // Handle actions based on parameter
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "registerCustomer":
                    response.sendRedirect("registerCustomer.jsp");
                    break;
                case "viewCustomer":
                    response.sendRedirect("viewCustomer.jsp");
                    break;
                case "closeCustomer":
                    response.sendRedirect("closeCustomer.jsp");
                    break;
                case "editCustomer":
                    response.sendRedirect("editCustomer.jsp");
                    break;
                default:
                    response.sendRedirect("AdminDashboard.jsp");
                    break;
            }
        } else {
            request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
