/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Austen
 */
@Entity
@Table(name = "ordered_item")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "OrderedItem.findAll", query = "SELECT o FROM OrderedItem o"),
    @NamedQuery(name = "OrderedItem.findByOrderId", query = "SELECT o FROM OrderedItem o WHERE o.orderedItemPK.orderId = :orderId"),
    @NamedQuery(name = "OrderedItem.findByItemId", query = "SELECT o FROM OrderedItem o WHERE o.orderedItemPK.itemId = :itemId"),
    @NamedQuery(name = "OrderedItem.findByQuantity", query = "SELECT o FROM OrderedItem o WHERE o.quantity = :quantity")})
public class OrderedItem implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected OrderedItemPK orderedItemPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "quantity")
    private short quantity;
    @JoinColumn(name = "item_id", referencedColumnName = "item_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Items items;
    @JoinColumn(name = "order_id", referencedColumnName = "order_id", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Order1 order1;

    public OrderedItem() {
    }

    public OrderedItem(OrderedItemPK orderedItemPK) {
        this.orderedItemPK = orderedItemPK;
    }

    public OrderedItem(OrderedItemPK orderedItemPK, short quantity) {
        this.orderedItemPK = orderedItemPK;
        this.quantity = quantity;
    }

    public OrderedItem(int orderId, int itemId) {
        this.orderedItemPK = new OrderedItemPK(orderId, itemId);
    }

    public OrderedItemPK getOrderedItemPK() {
        return orderedItemPK;
    }

    public void setOrderedItemPK(OrderedItemPK orderedItemPK) {
        this.orderedItemPK = orderedItemPK;
    }

    public short getQuantity() {
        return quantity;
    }

    public void setQuantity(short quantity) {
        this.quantity = quantity;
    }

    public Items getItems() {
        return items;
    }

    public void setItems(Items items) {
        this.items = items;
    }

    public Order1 getOrder1() {
        return order1;
    }

    public void setOrder1(Order1 order1) {
        this.order1 = order1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderedItemPK != null ? orderedItemPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OrderedItem)) {
            return false;
        }
        OrderedItem other = (OrderedItem) object;
        if ((this.orderedItemPK == null && other.orderedItemPK != null) || (this.orderedItemPK != null && !this.orderedItemPK.equals(other.orderedItemPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.OrderedItem[ orderedItemPK=" + orderedItemPK + " ]";
    }
    
}
