<%-- 
    Document   : indexPage
    Created on : Jul 8, 2024, 5:07:33 PM
    Author     : rkcp8
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="./indexPage.css" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String currentPage = "index";
            request.setAttribute("currentPage", currentPage);
        %>
        <jsp:include page="../components/headerComponent.jsp" /> 

        <div class="indexpage-imageSlider mb-1">
            <div class="row d-flex justify-content-center">
                <div class="col-4">
                    <h2 class="mt-5">
                        Welcome to VRMS
                    </h2>
                    <p class="mt-1">
                        Experience seamless and efficient vehicle rentals with VRMS. Whether you’re looking to rent a car, bike, or truck, we have the perfect solution for you. Manage your bookings, track rentals, and explore a wide range of vehicles with ease.
                    </p>
                    <h4 class="mt-1">
                        Start your journey with us today!
                    </h4>
                </div>
                <div class="col-8">
                </div>
            </div>
        </div>
        <div data-bs-spy="scroll" data-bs-target="#navbar-example2" data-bs-root-margin="0px 0px -40%" data-bs-smooth-scroll="true" class="scrollspy-example bg-body-tertiary p-3 rounded-2" tabindex="0">
            <div id="indexPage-sections1">
                <h3 class="d-flex justify-content-center">About Us</h3>
                <p class="d-flex justify-content-center">
                    Welcome to vehicle rental service, where quality meets convenience. We offer a variety of well-maintained vehicles to ensure your journey is comfortable and reliable. Whether you need a small car for city trips or a larger SUV for family outings, we have the right vehicle for you.</p>
                <p class="d-flex justify-content-center">All our vehicles come with modern features like air conditioning, power steering, and electric windows to make your drive enjoyable. We get our vehicles only from trusted dealerships, so you can count on their quality and performance.</p>
                <p class="d-flex justify-content-center">Unlike other rental services, we're not tied to any one car brand. This means we can offer a wide selection of cars, from budget-friendly options to more luxurious models. We also have automatic transmission cars available in every category to suit your preferences.</p>
                <p class="d-flex justify-content-center">Our goal is simple: to lead the way in car rentals for businesses and individuals worldwide. By working closely with our customers and providing efficient rental solutions, we strive to deliver excellent service every time you choose us.
                </p>
            </div>
            <div id="indexPage-sections2">
                <h3 class="d-flex justify-content-center" id="scrollspyHeading3">Our Services</h3>
                <p class="d-flex justify-content-center">we offer a range of services designed to meet your diverse vehicle rental needs:Daily Rentals: Whether you need a vehicle for a day or longer, our flexible daily rental options ensure you have access to the right vehicle for any occasion.</p>
                <p class="d-flex justify-content-center">Long-Term Rentals: Planning an extended trip or need a vehicle for an extended period? Our long-term rental solutions provide competitive rates and flexible terms to accommodate your schedule.</p>
                <p class="d-flex justify-content-center">Airport Transfers: Arriving at the airport? Skip the hassle of waiting and enjoy seamless airport transfers with our convenient rental options available directly at major airports.Corporate Solutions: We specialize in providing tailored rental solutions for businesses, ensuring reliable transportation for employees and clients alike. Benefit from customized corporate packages and dedicated account management services.Special Occasions: Planning a special event or celebration? Choose from our selection of premium vehicles to add style and comfort to your special day.</p>
                </p>
            </div>
            <div id="indexPage-sections3">
                <h3 class="d-flex justify-content-center" id="scrollspyHeading4">Contact us</h3>
                <p class="d-flex justify-content-center">Thank you for your interest in VRMS. We're here to assist you with any inquiries or assistance you may need. Please feel free to reach out to us using the following contact methods:</p>
                <div class="d-flex justify-content-center"><img src="../Images/whatsapp-icon.svg" style="width:50px" alt="whatsapp"/><label>0765907934</label><br></div>
                <div class="d-flex justify-content-center"><img src="../Images/email-icon.svg" style="width:50px" alt="email"/><label>contactvrms@gmail.com</label><br></div>
            </div>
        </div>
        <jsp:include page="../components/footerComponent.jsp" />
        <h3 class="d-flex justify-content-center" id="scrollspyHeading5" hidden></h3>
    </body>

</html>
