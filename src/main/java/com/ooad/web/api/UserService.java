package com.ooad.web.api;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.json.JSONObject;

import com.ooad.web.dao.UserDao;
import com.ooad.web.model.User;
import com.ooad.web.model.UserAccount;
import com.ooad.web.utils.TokenAuth;

@Path("/user")
public class UserService {
    @POST
    @Path("/address")
    @Consumes(MediaType.TEXT_PLAIN)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addAddress(@HeaderParam("authToken") String token, String req) {
        User user = TokenAuth.getUserFromToken(token);
        JSONObject reqJson = new JSONObject(req);
        if(user == null){
            return Response.status(Response.Status.OK).entity(new JSONObject().put("status", Response.Status.UNAUTHORIZED.getStatusCode())
                    .toString()).build();
        }
        JSONObject j = user.addAddress(reqJson);
        return Response.status(Response.Status.OK).entity(j.toString()).build();
    }


    @Path("/address/{id}")
    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteAddress(@HeaderParam("authToken") String token, @PathParam("id") int id) {
        User user = TokenAuth.getUserFromToken(token);
        if(user == null){
            return Response.status(Response.Status.OK).entity(new JSONObject().put("status", Response.Status.UNAUTHORIZED.getStatusCode())
                    .toString()).build();
        }
        JSONObject j = user.deleteAddress(id);
        return Response.status(Response.Status.OK).entity(j.toString()).build();

    }

    @Path("/address/{id}")
    @PUT
    @Consumes(MediaType.TEXT_PLAIN)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateAddress(@HeaderParam("authToken") String token, String req,@PathParam("id") int id) {
        User user = TokenAuth.getUserFromToken(token);
        JSONObject reqJson = new JSONObject(req);
        if(user == null){
            return Response.status(Response.Status.OK).entity(new JSONObject().put("status", Response.Status.UNAUTHORIZED.getStatusCode())
                    .toString()).build();
        }
        JSONObject j = user.updateAddress(reqJson,id);
        return Response.status(Response.Status.OK).entity(j.toString()).build();

    }

    @POST
    @Path("/updatebalance")
    @Consumes(MediaType.TEXT_PLAIN)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updatePayBalance(@HeaderParam("authToken") String token, String req) {
        User user = TokenAuth.getUserFromToken(token);
        JSONObject reqJson = new JSONObject(req);
        int balance = reqJson.getInt("balance");
        if(user == null){
            return Response.status(Response.Status.OK).entity(new JSONObject().put("status", Response.Status.UNAUTHORIZED.getStatusCode())
                    .toString()).build();
        }
        int currentBalance = user.getTescoPayBalance();
        UserDao userDao = new UserDao();
        UserAccount userAccount = userDao.getUserAccountFromUserId(user.getId());
        if(balance<=userAccount.getAmount()) {
            user.setTescoPayBalance(currentBalance + balance);
            userAccount.setAmount(userAccount.getAmount()-balance);
            userAccount.save();
            user.save();
            return Response.status(Response.Status.OK).entity(new JSONObject().put("status", Response.Status.OK.getStatusCode())
                    .toString()).build();
        }else{
            return Response.status(Response.Status.OK).entity(new JSONObject().put("status", Response.Status.BAD_REQUEST.getStatusCode())
                    .put("errors","out of balance in your account").toString()).build();
        }
    }

}

