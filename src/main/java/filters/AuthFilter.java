package filters;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebFilter(filterName = "AuthFilter")
public class AuthFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        chain.doFilter(request, response);
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Public pages that don't require authentication
        if (requestURI.equals(contextPath + "/") ||
                requestURI.contains("/LoginServlet") ||
                requestURI.contains("/RegisterServlet") ||
                requestURI.contains("/about") ||
                requestURI.contains("/contact") ||
                requestURI.contains("/css/") ||
                requestURI.contains("/js/") ||
                requestURI.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(contextPath + "/LoginServlet");
            return;
        }


    }
}