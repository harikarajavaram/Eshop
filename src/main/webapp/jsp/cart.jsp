<%@ page import="com.ooad.web.model.*" %>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="images/Tesco.ico" type="image/x-icon">
    <title>
        Tesco.com Shopping Cart </title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">

    <script src="../js/jquery.min.js"></script>
    <script src="../js/jquery.cookie.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="../js/cart.js"></script>
    <link rel="stylesheet" href="../css/cart.css">
    <% Cart cart= (Cart)request.getAttribute("cart");%>

</head>

<body>
<script>
    function deleteCartItem(cartItemId) {
        console.log("deleted Item");
        $.ajax({
            type: 'DELETE',
            url: 'api/item/cart/'+cartItemId,
            success: function (data) {
                // console.log("deleted");
                window.location.replace("/cart");
            }

        });
    }
</script>
<%@include file="header.jsp" %>
<div class="container-fluid" style="margin-top: 40px;margin-bottom: 90px;">
    <div class="col-lg-9">
        <h1 id="pageTitle">Shopping Cart</h1>
        <div class="row">
            <div class="col-lg-8"></div>
            <div class="col-lg-2">
                <h5 class="headTiles text-left">Price</h5>
            </div>
            <div class="col-lg-2">
                <h5 class="headTiles text-right">Quantity</h5>
            </div>
        </div>
        <hr>

        <% for (CartItem c: cart.getCartItems()) {%>
            <div class="cartItems row">
                <div id="cartItemDetails">
                    <div class="col-lg-2">
                        <img id = "prodImage<%=c.getId()%>" width="150"  src="<%=c.getItem().getUrl()%>" height="150" class = "img-responsive" alt="">
                    </div>
                    <div class="col-lg-6">
                        <a href="/item?id=<%=c.getItem().getId()%>"><span id="productTitle" class="btn-link"><%=c.getItem().getName()%></span></a> by <a href="#" id="sellerName"><%=c.getItem().getSeller().getUserName()%></a>
                        <div class="barcode"><%=c.getItem().getItemBarcode()%></div>
                        <div id="availability"><span id="avail">In stock</span></div>
                        <span id="removeItem" onclick="deleteCartItem(<%=c.getId()%>)" class="btn-link" >Delete</span>
                    </div>
                </div>
                <div class="Price col-lg-2 text-left">&#2352;<span id="currentPrice<%=c.getId()%>"><%=c.getItem() instanceof FreeItem ? 0: c.getItem().getPrice()%></span></div>
                <div class="item-column col-lg-2 text-right" id="quantity" >
                    <p contenteditable="true" id="<%=c.getId()%>" class="Quantity"><%=c.getQuantity()%></p>
                </div>
            </div>
            <hr>
        <% } %>
        </div>
        <div class="col-lg-3">
            
            <div class="item-box" style="height: 140px;width: 310px;">
                <div class="item-row">Subtotal (<span id="numberOfItems"><%=cart.size()%></span> items):<span class="Price" style="font-size: 19px"> &#2352;<%=cart.getSubTotal()%></span></div>
                <div class="item-row">Promotion <span class="Price" style="font-size: 19px"> &#2352;<%=cart.getPromotionApplied()%></span></div>
                <div class="item-row">Total <span class="Price" style="font-size: 19px"> &#2352;<%= cart.getGrandTotal()%></span></div>
                <div>
                    <a href="/checkout"><input id="proceedToCheckout"type="button"  class="btn1" value="Proceed to Checkout" style="background-color: #D10024;color: white;margin-top: 10px;"></a>
                </div>
            </div>
        </div>
</div>

<%--<p> <%= cart.toJSON().toString(4)%></p>--%>
<%@include file="footer.jsp" %>
</body>
</html>
