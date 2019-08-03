<%@ page import="com.ooad.web.dao.ItemCategoryDao" %>
<%@ page import="com.ooad.web.model.ItemCategory" %>
<%@ page import="com.ooad.web.utils.TokenAuth" %>
<%@ page import="com.ooad.web.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.ooad.web.model.ItemSubCategory" %>
<% Cookie[] cookies = request.getCookies();
   User user = null;
   if(cookies != null){
       for(Cookie cookie: cookies){
           if(cookie.getName().equals("authToken")){
                user = TokenAuth.getUserFromToken(cookie.getValue());
           }
       }
   }
%>
<link rel="stylesheet" href="../css/fontawesome-all.min.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap-dropdownhover.css">
<link rel="stylesheet" href="../css/header.css">

<link type="text/css" rel="stylesheet" href="../css/slick.css"/>
<link type="text/css" rel="stylesheet" href="../css/slick-theme.css"/>
<link type="text/css" rel="stylesheet" href="../css/nouislider.min.css"/>
<link rel="stylesheet" href="../css/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="../css/style.css"/>
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<script src="../js/bootstrap-dropdownhover.js"></script>
<script src="../js/header.js"></script>

<script src="../js/slick.min.js"></script>
<script src="../js/nouislider.min.js"></script>
<script src="../js/jquery.zoom.min.js"></script>
<script src="../js/main.js"></script>
<!-- HEADER -->
        <header>


            <!-- MAIN HEADER -->
            <div id="header">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- LOGO -->
                        <div class="col-md-2">
                            <div class="header-logo" style="margin-top: 15px">
                                <a href="/" class="logo">
                                    <img src="../images/logo.png" alt="" height="35" width="100">
                                </a>
                            </div>
                        </div>
                        <!-- /LOGO -->

                        <!-- SEARCH BAR -->
                        <div class="col-md-7">
                            <div class="header-search">
                                <form action="" id="item-search" >
                                    <select class="input-select" name="" id="nav-search-select">
                                        <option value="all">All Categories</option>
                                        <% final ItemCategoryDao itemCategoryDao = new ItemCategoryDao();
                                            ArrayList<ItemCategory> itemCategories = (ArrayList<ItemCategory>) itemCategoryDao.getAllCategories();
                                            for (ItemCategory itemCategory : itemCategories) { %>
                                        <option value="<%= itemCategory.getName()%>"><%= itemCategory.getDisplayName()%>
                                        </option>
                                        <% }%>
                                    </select>
                                    <input class="input" placeholder="Search here" type="text">
                                    <button id="search-icon" class="search-btn">Search</button>
                                </form>
                            </div>
                        </div>
                        <!-- /SEARCH BAR -->

                        <!-- ACCOUNT -->
                        <div class="col-md-3 clearfix">
                            <div class="header-ctn">
                                <% if(user == null) {%>
                                <!-- Account -->
                                <div>
                                    <a href="/login">
                                        <i class="fa fa-sign-out"></i>
                                        <span>Login</span>
                                    </a>
                                </div>
                                <!-- /Account -->
                                <% } else { %>
                                <!-- Account -->
                                <div>
                                    <a href="/" id="nav-logout">
                                        <i class="fa fa-sign-in"></i>
                                        <span>Logout</span>
                                    </a>
                                </div>
                                <!-- /Account -->
                                <%}%>
                                

                                <!-- Cart -->
                                <div class="dropdown">
                                    <a href="/cart">
                                        <i class="fa fa-shopping-cart"></i>
                                        <span>Your Cart</span>
                                        <div class="qty" id="cart-contents"><%=(user==null)? 0:user.getCart().size()%></div>
                                    </a>
                                </div>
                                <!-- /Cart -->

                                <!-- Menu Toogle -->
                                <div class="menu-toggle">
                                    <a href="#">
                                        <i class="fa fa-bars"></i>
                                        <span>Menu</span>
                                    </a>
                                </div>
                                <!-- /Menu Toogle -->
                            </div>
                        </div>
                        <!-- /ACCOUNT -->
                    </div>
                    <!-- row -->
                </div>
                <!-- container -->
            </div>
            <!-- /MAIN HEADER -->
        </header>
        <!-- /HEADER -->
        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="/">Home</a></li>
                        <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Categories
                        <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <%for (ItemCategory itemCategory : itemCategories) { %>
                            <li class="dropdown">
                                <a href="#"><%=itemCategory.getDisplayName()%></a>
                                <% if(itemCategory.getDisplayName().equals("Others")) continue;%>
                                <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <% ArrayList<ItemSubCategory> itemsubCategories = (ArrayList<ItemSubCategory>) itemCategoryDao.getAllsubCategories(itemCategory.getId());
                                        for (ItemSubCategory itemsubCategory : itemsubCategories) { %>
                                        <li><a href="/items?category=<%=itemCategory.getName()%>&subcategory=<%=itemsubCategory.getDisplayName()%>"><%=itemsubCategory.getDisplayName()%></a></li>
                                    <%}%>
                                </ul>
                            </li>
                            <%}%>
                        </ul>
                    </li>
                        <li><a href="/myorders">My Orders</a></li>
                        <li><a href="/list">My List</a></li>
                        <li><a href="/tescopay">Tesco Pay</a></li>
                        <li><a href="/sellerlogin">Sell</a></li>
                        <% if(user!=null && user.getEmailId().equals("admin@admin.com")) { %>
                            <li><a href="/admin">Admin</a></li>
                        <%}%>
                    </ul>
                    <!-- <ul class="dropdown-menu">
                        <li>Categories</li>
                        <%for (ItemCategory itemCategory : itemCategories) { %>
                        <li class="dropdown">
                            <a href="#"><%=itemCategory.getDisplayName()%></a>
                            <% if(itemCategory.getDisplayName().equals("Others")) continue;%>
                            <ul class="dropdown-menu">
                                <% ArrayList<ItemSubCategory> itemsubCategories = (ArrayList<ItemSubCategory>) itemCategoryDao.getAllsubCategories(itemCategory.getId());
                                    for (ItemSubCategory itemsubCategory : itemsubCategories) { %>
                                    <li><a href="/items?category=<%=itemCategory.getName()%>&subcategory=<%=itemsubCategory.getDisplayName()%>"><%=itemsubCategory.getDisplayName()%></a></li>
                                <%}%>
                            </ul>
                        </li>
                        <%}%>
                    </ul> -->
                    <!-- /NAV -->
                </div>
                <!-- /responsive-nav -->
            </div>
            <!-- /container -->
        </nav>
        <!-- /NAVIGATION -->