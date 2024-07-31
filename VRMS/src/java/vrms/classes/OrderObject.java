/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vrms.classes;

/**
 *
 * @author rkcp8
 */
public class OrderObject {
    private String orderId;
    private int vehicleId;

    public OrderObject(String orderId, int vehicleId) {
        this.orderId = orderId;
        this.vehicleId = vehicleId;
    }

    public String getOrderId() {
        return orderId;
    }

    public int getVehicleId() {
        return vehicleId;
    }
    
    
}
