package com.ooad.web.dao;

import com.ooad.web.model.Seller;
import com.ooad.web.model.UserAccount;
import com.ooad.web.utils.Constants;
import com.ooad.web.utils.Database;
import com.ooad.web.utils.TokenAuth;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.core.Response;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

public class SellerDao {
    public JSONObject validateSellerLogin(String email, String password) {
        try {
            final JSONObject status = new JSONObject();
            final Connection con = Database.getConnection();
            final PreparedStatement ps = con.prepareStatement("SELECT  * FROM  Sellers WHERE emailId=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getString("password").equals(password)) {
                    final Seller seller = getSeller(email);
                    status.put("status", Response.Status.OK.getStatusCode());
                    status.put("seller", seller.toJSON());
                    status.put("token", TokenAuth.generateSellerToken(seller));
                    status.put("errors", "");
                } else {
                    status.put("status", Response.Status.BAD_REQUEST.getStatusCode());
                    final JSONObject errors = new JSONObject();
                    errors.put("psword", Constants.ERROR_WRONG_PASSWD);
                    status.put("errors", errors);
                }
            } else {
                status.put("status", Response.Status.BAD_REQUEST.getStatusCode());
                final JSONObject errors = new JSONObject();
                errors.put("email", Constants.ERROR_NO_USER);
                status.put("errors", errors);
            }
            con.close();
            return status;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new JSONObject();
    }

    public Seller getSeller(String email) {
        try {
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Sellers WHERE emailId=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            Seller s = null;
            if (rs.next()) {
                s=new Seller(rs.getInt("id"),
                        rs.getString("userName"),
                        rs.getString("emailId"),
                        rs.getString("password"),
                        rs.getBoolean("isEnabled"),
                        rs.getString("storeName"),
                        rs.getString("mobileNumber"),
                        rs.getString("streetAddress"),
                        rs.getString("landmark"),
                        rs.getString("city"),
                        rs.getString("state"),
                        rs.getString("pincode"),
                        rs.getString("country"),
                        rs.getInt("totalRatings"),
                        rs.getInt("ratingCount")
                );
            }
            con.close();
            return s;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public Seller getSeller(int id) {
        try {
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Sellers WHERE id=?");
            ps.setString(1, String.valueOf(id));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
               Seller seller = sellerBuilder(rs);
               con.close();
               return seller;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public JSONObject validateSellerRegister(String userName, String email, String password, String storeName, String mobileNumber,
                                             String streetAddress, String landmark, String city, String state, String pincode, String country) {
        JSONObject status = new JSONObject();
        try {
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM  Sellers WHERE emailId = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                JSONArray errors = new JSONArray();
                errors.put(new JSONObject().put("email", Constants.ERROR_USER_EXIST));
                status.put("status", Response.Status.BAD_REQUEST.getStatusCode());
                status.put("errors", errors);
            } else {
                final Seller seller = createSeller(userName, email, password, storeName, mobileNumber, streetAddress, landmark, city,
                        state, pincode, country);
                final JSONObject sellerJsonObject = seller.toJSON();
                status.put("status", Response.Status.CREATED.getStatusCode());
                status.put("seller", sellerJsonObject);
                status.put("token", TokenAuth.generateSellerToken(seller));
            }
            con.close();
            return status;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Seller createSeller(final String userName, final String email, final String password, final String storeName,
                               final String mobileNumber, final String streetAddress, final String landmark, final String city,
                               final String state, final String pincode, final String country) {
        try {
            Connection con = Database.getConnection();
            PreparedStatement ps = con
                    .prepareStatement("INSERT INTO Sellers(userName,emailId,password,storeName,mobileNumber,streetAddress," +
                            "landmark,city,state,pincode,country) VALUES (?,?,?,?,?,?,?,?,?,?,?)");//add seller to database
            ps.setString(1, userName);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, storeName);
            ps.setString(5, mobileNumber);
            ps.setString(6, streetAddress);
            ps.setString(7, landmark);
            ps.setString(8, city);
            ps.setString(9, state);
            ps.setString(10, pincode);
            ps.setString(11, country);
            ps.executeUpdate();
            con.close();
            return getSeller(email);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateSeller(Seller seller){
        try {
            Connection con = Database.getConnection();
            PreparedStatement ps = con
                    .prepareStatement("UPDATE Sellers SET storeName = ? ,mobileNumber = ?,streetAddress = ?," +
                            "landmark = ? ,city = ? ,state = ?,pincode = ?,country = ?,totalRatings = ? , ratingCount = ? "+
                            " WHERE id = ?");
            ps.setString(1, seller.getStoreName());
            ps.setString(2, seller.getMobileNumber());
            ps.setString(3, seller.getStreetAddress());
            ps.setString(4, seller.getLandmark());
            ps.setString(5, seller.getCity());
            ps.setString(6, seller.getState());
            ps.setString(7, seller.getPincode());
            ps.setString(8, seller.getCountry());
            ps.setInt(9,seller.getTotalRatings() );
            ps.setInt(10,seller.getRatingsCount());
            ps.setInt(11,seller.getId());
            ps.executeUpdate();
            con.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private Seller sellerBuilder(ResultSet rs) throws NullPointerException, SQLException {
        if (rs == null) {
            throw new NullPointerException("Result Set");
        }
        final int id = rs.getInt("id");
        final String userName = rs.getString("userName");
        final String emailId = rs.getString("emailId");
        final String password = rs.getString("password");
        final Boolean isEnabled = rs.getBoolean("isEnabled");
        final String storeName = rs.getString("storeName");
        final String mobileNumber = rs.getString("mobileNumber");
        final String streetAddress = rs.getString("streetAddress");
        final String landmark = rs.getString("landmark");
        final String city = rs.getString("city");
        final String state = rs.getString("state");
        final String pincode = rs.getString("pincode");
        final String country = rs.getString("country");
        final int totalRatings = rs.getInt("totalRatings");
        final int ratingCount = rs.getInt("ratingCount");

        return new Seller(id, userName, emailId, password, isEnabled, storeName, mobileNumber, streetAddress,
                landmark, city, state, pincode, country,totalRatings,ratingCount);
    }

    public UserAccount getUserAccountFromSellerId(int sellerId){
        try {
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Accounts WHERE sellerId = ?");
            ps.setInt(1,sellerId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                UserAccount ua = new UserAccount(rs.getInt("id"),rs.getString("name"),rs.getInt("number"),rs.getInt("amount"));
                con.close();
                return ua;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }


    public Collection<Seller> getAllSeller() {
        try {
            Connection con = Database.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Sellers");
            ResultSet rs = ps.executeQuery();
            Collection<Seller> seller = new ArrayList<Seller>();
            while(rs.next()){
                seller.add(sellerBuilder(rs));
            }
            con.close();
            return seller;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
