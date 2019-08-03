<%@ page import="java.util.ArrayList" %>
<%@ page import="com.ooad.web.model.Item" %>
<%@ page import="java.io.IOException" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="images/Tesco.ico" type="image/x-icon">
    <title>
        Tesco.com: Online Shopping for Electronics, Apparel, Computers, Books, DVDs &amp; more</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/index.css">

    <script src="js/index.js"></script>
</head>
<body>
<%@include file="jsp/header.jsp" %>
<% ArrayList<Item> items = Item.getLastFive();%>
    <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- shop -->
                    <div class="col-md-4 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="../images/shop01.png" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Laptop<br>Collection</h3>
                                <a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->

                    <!-- shop -->
                    <div class="col-md-4 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="../images/shop03.png" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Accessories<br>Collection</h3>
                                <a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->

                    <!-- shop -->
                    <div class="col-md-4 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="../images/shop02.png" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Cameras<br>Collection</h3>
                                <a href="#" class="cta-btn">Shop now <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->
                <!-- HOT DEAL SECTION -->
        <div id="hot-deal" class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="hot-deal">
                            <ul class="hot-deal-countdown">
                                <li>
                                    <div>
                                        <h3>02</h3>
                                        <span>Days</span>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <h3>10</h3>
                                        <span>Hours</span>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <h3>34</h3>
                                        <span>Mins</span>
                                    </div>
                                </li>
                                <li>
                                    <div>
                                        <h3>60</h3>
                                        <span>Secs</span>
                                    </div>
                                </li>
                            </ul>
                            <h2 class="text-uppercase">hot deal this week</h2>
                            <p>New Collection Up to 50% OFF</p>
                            <a class="primary-btn cta-btn" href="#">Shop now</a>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /HOT DEAL SECTION -->

        <div class="container-fluid">
    <div class='row'>
        <div class='col-md-12'>
            <div class="carousel slide media-carousel" id="media">
                <div class="carousel-inner">
                    <%
                        int i = 0,j=0;
                        while(i < items.size()){
                            if(i%3==0){ %>
                                <div class="item  <%= (i==0) ? "active":""%>">
                                    <div class="row">
                                    <%
                                        while(i<items.size() && j <3) {
                                            final Item item = items.get(i); %>
                                            <div class="col-md-4">
                                                <div class='card'>
                                                    <img class='card-img-top' src='../images/product01.png' alt='' style="height: 160px; width: 160px">
                                                    <div class="card-body">
                                                        <h5 class="card-title"><%=item.getName()%></h5>
                                                        <p class="card-text">Price <%=item.getPrice()%></p>
                                                        <a href="/item?id=<%=item.getId()%>"><button class="add-to-cart-btn"><i class="fa fa-eye"></i>View</button></a>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <%i++;
                                            j++;
                                        }
                                        j=0;
                                    %>
                                    </div>
                                </div>
                            <%}
                        }%>
                    <a data-slide="prev" href="#media" class="left carousel-control"> < </a>
                    <a data-slide="next" href="#media" class="right carousel-control"> > </a>
                </div>
            </div>
        </div>
    </div>

</div>
    <!-- <%
    if(items.size()!=0){
    %>

        <div class="section" style="margin-bottom:60px">

            <div class="container">

                <div class="row">

                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">

                                <div id="tab1" class="tab-pane active">
                                    <div class="products-slick" data-nav="#slick-nav-1">
                                            <%
                                            for(i=0;i<items.size();i++){
                                            final Item item = items.get(i);
                                            %>

                                     
                                        <div class="product">
                                            <div class="product-img">
                                                <img src='<%= item.getUrl() %>' alt="">
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category"><%=item.getSubCategory()%></p>
                                                <h3 class="product-name"><a href="#"><%=item.getName()%></a></h3>
                                                <h4 class="product-price"><%=item.getPrice()%></h4>
                                                
                                            </div>
                                            <div class="add-to-cart">
                                                <a href="/item?id=<%=item.getId()%>"><button class="add-to-cart-btn"><i class="fa fa-eye"></i>View</button></a>
                                            </div>
                                        </div>
                                        

                                        <%
                                           }
                                            %>
                                    </div>
                                    <div id="slick-nav-1" class="products-slick-nav"></div>
                                </div>
                               
                            </div>
                        </div>
                    </div>
           
                </div>
           
            </div>
           
        </div>
        
    <%
   }
    %> -->
<!-- <iframe width="350" height="430" allow="microphone;" src="https://console.dialogflow.com/api-client/demo/embedded/0c893a58-b400-4218-b856-81480207673a"></iframe> -->
<!-- <a class="btn" href="/exam">EndExam4|Q1</a>
<a class="btn" href="/exam2.jsp">EndExam4|Q2Q3</a> -->
<%@include file="jsp/footer.jsp" %>
</body>
<!-- <script type="text/javascript">
    $(document).ready(function () {
        var div = document.createElement("div");
    document.getElementsByTagName('body')[0].appendChild(div);
    div.outerHTML = "<div id='botDiv' style='height: 80px; position: fixed; bottom: 0; z-index: 1000; background-color: #fff'><div id='botTitleBar' style='height: 80px; width: 350px; position:fixed; cursor: pointer;'></div><iframe width='350px' height='430px' src='https://console.dialogflow.com/api-client/demo/embedded/0c893a58-b400-4218-b856-81480207673a'></iframe></div>"; 

    document.querySelector('body').addEventListener('click', function (e) {
        e.target.matches = e.target.matches || e.target.msMatchesSelector;
        if (e.target.matches('#botTitleBar')) { 
            var botDiv = document.querySelector('#botDiv'); 
            botDiv.style.height = botDiv.style.height == '430px' ? '80px' : '430px';
        };
    });
    });
</script> -->
</html>