package com.foodsource.apples.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

import com.foodsource.apples.domain.enumeration.StockMeasurement;

import com.foodsource.apples.domain.enumeration.StockStatus;

/**
 * A Stock.
 */
@Entity
@Table(name = "stock")
public class Stock implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "amount")
    private Integer amount;

    @Enumerated(EnumType.STRING)
    @Column(name = "measure")
    private StockMeasurement measure;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private StockStatus status;

    @OneToOne
    @JoinColumn(unique = true)
    private StockType stocktype;

    @OneToMany(mappedBy = "stock")
    private Set<PricesPerStock> pricesperstocks = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "stock_adverts",
               joinColumns = @JoinColumn(name = "stocks_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "adverts_id", referencedColumnName = "id"))
    private Set<Adverts> adverts = new HashSet<>();

    @ManyToMany(mappedBy = "stocks")
    @JsonIgnore
    private Set<Supplier> suppliers = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public Stock name(String name) {
        this.name = name;
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public Stock description(String description) {
        this.description = description;
        return this;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getAmount() {
        return amount;
    }

    public Stock amount(Integer amount) {
        this.amount = amount;
        return this;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public StockMeasurement getMeasure() {
        return measure;
    }

    public Stock measure(StockMeasurement measure) {
        this.measure = measure;
        return this;
    }

    public void setMeasure(StockMeasurement measure) {
        this.measure = measure;
    }

    public StockStatus getStatus() {
        return status;
    }

    public Stock status(StockStatus status) {
        this.status = status;
        return this;
    }

    public void setStatus(StockStatus status) {
        this.status = status;
    }

    public StockType getStocktype() {
        return stocktype;
    }

    public Stock stocktype(StockType stockType) {
        this.stocktype = stockType;
        return this;
    }

    public void setStocktype(StockType stockType) {
        this.stocktype = stockType;
    }

    public Set<PricesPerStock> getPricesperstocks() {
        return pricesperstocks;
    }

    public Stock pricesperstocks(Set<PricesPerStock> pricesPerStocks) {
        this.pricesperstocks = pricesPerStocks;
        return this;
    }

    public Stock addPricesperstock(PricesPerStock pricesPerStock) {
        this.pricesperstocks.add(pricesPerStock);
        pricesPerStock.setStock(this);
        return this;
    }

    public Stock removePricesperstock(PricesPerStock pricesPerStock) {
        this.pricesperstocks.remove(pricesPerStock);
        pricesPerStock.setStock(null);
        return this;
    }

    public void setPricesperstocks(Set<PricesPerStock> pricesPerStocks) {
        this.pricesperstocks = pricesPerStocks;
    }

    public Set<Adverts> getAdverts() {
        return adverts;
    }

    public Stock adverts(Set<Adverts> adverts) {
        this.adverts = adverts;
        return this;
    }

    public Stock addAdverts(Adverts adverts) {
        this.adverts.add(adverts);
        adverts.getStocks().add(this);
        return this;
    }

    public Stock removeAdverts(Adverts adverts) {
        this.adverts.remove(adverts);
        adverts.getStocks().remove(this);
        return this;
    }

    public void setAdverts(Set<Adverts> adverts) {
        this.adverts = adverts;
    }

    public Set<Supplier> getSuppliers() {
        return suppliers;
    }

    public Stock suppliers(Set<Supplier> suppliers) {
        this.suppliers = suppliers;
        return this;
    }

    public Stock addSupplier(Supplier supplier) {
        this.suppliers.add(supplier);
        supplier.getStocks().add(this);
        return this;
    }

    public Stock removeSupplier(Supplier supplier) {
        this.suppliers.remove(supplier);
        supplier.getStocks().remove(this);
        return this;
    }

    public void setSuppliers(Set<Supplier> suppliers) {
        this.suppliers = suppliers;
    }
    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here, do not remove

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Stock stock = (Stock) o;
        if (stock.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), stock.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "Stock{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", description='" + getDescription() + "'" +
            ", amount=" + getAmount() +
            ", measure='" + getMeasure() + "'" +
            ", status='" + getStatus() + "'" +
            "}";
    }
}
