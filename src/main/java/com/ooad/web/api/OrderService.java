package com.ooad.web.api;

import com.ooad.web.dao.ItemDao;
import com.ooad.web.model.Item;
import com.ooad.web.model.Seller;
import com.ooad.web.model.User;
import com.ooad.web.utils.TokenAuth;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import java.io.*;
import java.util.ArrayList;

@Path("/order")
public class OrderService {


    @Path("addaddress")
    @POST
    @Consumes(MediaType.TEXT_PLAIN)
    @Produces(MediaType.APPLICATION_JSON)
    public Response setAddress(String req,@HeaderParam("authToken") String token) {
        User user = TokenAuth.getUserFromToken(token);
        if(user == null){
            return Response.status(Status.OK).entity(new JSONObject().put("status",Status.UNAUTHORIZED.getStatusCode())
                    .toString()).build();
        }
        JSONObject j = user.createOrder(req);
        return Response.status(Status.OK).entity(j.toString()).build();
    }

    @Path("transaction")
    @POST
    @Consumes(MediaType.TEXT_PLAIN)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createTransaction(String req,@HeaderParam("authToken") String token) {
        JSONObject re = new JSONObject(req);
        User user = TokenAuth.getUserFromToken(token);
        if(user == null){
            return Response.status(Status.OK).entity(new JSONObject().put("status",Status.UNAUTHORIZED.getStatusCode())
                    .toString()).build();
        }
        JSONObject j = user.createTransaction(re);
        return Response.status(Status.OK).entity(j.toString()).build();
    }


}
