package org.apache.jsp.ui;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class indexPage_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <link href=\"./indexPage.css\" rel=\"stylesheet\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");

            String currentPage = "index";
            request.setAttribute("currentPage", currentPage);
        
      out.write("\n");
      out.write("        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../components/headerComponent.jsp", out, false);
      out.write(" \n");
      out.write("\n");
      out.write("        <div class=\"indexpage-imageSlider mb-1\">\n");
      out.write("            <div class=\"row d-flex justify-content-center\">\n");
      out.write("                <div class=\"col-4\">\n");
      out.write("                    <h2 class=\"mt-5\">\n");
      out.write("                        Welcome to VRMS\n");
      out.write("                    </h2>\n");
      out.write("                    <p class=\"mt-1\">\n");
      out.write("                        Experience seamless and efficient vehicle rentals with VRMS. Whether you’re looking to rent a car, bike, or truck, we have the perfect solution for you. Manage your bookings, track rentals, and explore a wide range of vehicles with ease.\n");
      out.write("                    </p>\n");
      out.write("                    <h4 class=\"mt-1\">\n");
      out.write("                        Start your journey with us today!\n");
      out.write("                    </h4>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-8\">\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <div data-bs-spy=\"scroll\" data-bs-target=\"#navbar-example2\" data-bs-root-margin=\"0px 0px -40%\" data-bs-smooth-scroll=\"true\" class=\"scrollspy-example bg-body-tertiary p-3 rounded-2\" tabindex=\"0\">\n");
      out.write("            <div id=\"indexPage-sections1\">\n");
      out.write("                <h3 class=\"d-flex justify-content-center\">About Us</h3>\n");
      out.write("                <p class=\"d-flex justify-content-center\">\n");
      out.write("                    Welcome to vehicle rental service, where quality meets convenience. We offer a variety of well-maintained vehicles to ensure your journey is comfortable and reliable. Whether you need a small car for city trips or a larger SUV for family outings, we have the right vehicle for you.</p>\n");
      out.write("                <p class=\"d-flex justify-content-center\">All our vehicles come with modern features like air conditioning, power steering, and electric windows to make your drive enjoyable. We get our vehicles only from trusted dealerships, so you can count on their quality and performance.</p>\n");
      out.write("                <p class=\"d-flex justify-content-center\">Unlike other rental services, we're not tied to any one car brand. This means we can offer a wide selection of cars, from budget-friendly options to more luxurious models. We also have automatic transmission cars available in every category to suit your preferences.</p>\n");
      out.write("                <p class=\"d-flex justify-content-center\">Our goal is simple: to lead the way in car rentals for businesses and individuals worldwide. By working closely with our customers and providing efficient rental solutions, we strive to deliver excellent service every time you choose us.\n");
      out.write("                </p>\n");
      out.write("            </div>\n");
      out.write("            <div id=\"indexPage-sections2\">\n");
      out.write("                <h3 class=\"d-flex justify-content-center\" id=\"scrollspyHeading3\">Our Services</h3>\n");
      out.write("                <p class=\"d-flex justify-content-center\">we offer a range of services designed to meet your diverse vehicle rental needs:Daily Rentals: Whether you need a vehicle for a day or longer, our flexible daily rental options ensure you have access to the right vehicle for any occasion.</p>\n");
      out.write("                <p class=\"d-flex justify-content-center\">Long-Term Rentals: Planning an extended trip or need a vehicle for an extended period? Our long-term rental solutions provide competitive rates and flexible terms to accommodate your schedule.</p>\n");
      out.write("                <p class=\"d-flex justify-content-center\">Airport Transfers: Arriving at the airport? Skip the hassle of waiting and enjoy seamless airport transfers with our convenient rental options available directly at major airports.Corporate Solutions: We specialize in providing tailored rental solutions for businesses, ensuring reliable transportation for employees and clients alike. Benefit from customized corporate packages and dedicated account management services.Special Occasions: Planning a special event or celebration? Choose from our selection of premium vehicles to add style and comfort to your special day.</p>\n");
      out.write("                </p>\n");
      out.write("            </div>\n");
      out.write("            <div id=\"indexPage-sections3\">\n");
      out.write("                <h3 class=\"d-flex justify-content-center\" id=\"scrollspyHeading4\">Contact us</h3>\n");
      out.write("                <p class=\"d-flex justify-content-center\">Thank you for your interest in VRMS. We're here to assist you with any inquiries or assistance you may need. Please feel free to reach out to us using the following contact methods:</p>\n");
      out.write("                <div class=\"d-flex justify-content-center\"><img src=\"../Images/whatsapp-icon.svg\" style=\"width:50px\" alt=\"whatsapp\"/><label>0765907934</label><br></div>\n");
      out.write("                <div class=\"d-flex justify-content-center\"><img src=\"../Images/email-icon.svg\" style=\"width:50px\" alt=\"email\"/><label>contactvrms@gmail.com</label><br></div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../components/footerComponent.jsp", out, false);
      out.write("\n");
      out.write("        <h3 class=\"d-flex justify-content-center\" id=\"scrollspyHeading5\" hidden></h3>\n");
      out.write("    </body>\n");
      out.write("\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
