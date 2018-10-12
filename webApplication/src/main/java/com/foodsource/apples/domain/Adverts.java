package com.foodsource.apples.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

import java.io.Serializable;
import java.time.Instant;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A Adverts.
 */
@Entity
@Table(name = "adverts")
public class Adverts implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "text")
    private String text;

    @Column(name = "prices_per_stock")
    private Float pricesPerStock;

    @Column(name = "units")
    private Integer units;

    @Column(name = "startdate")
    private Instant startdate;

    @Column(name = "end_date")
    private Instant endDate;

    @ManyToMany(mappedBy = "adverts")
    @JsonIgnore
    private Set<Supplier> suppliers = new HashSet<>();

    @ManyToMany(mappedBy = "adverts")
    @JsonIgnore
    private Set<Stock> stocks = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public Adverts text(String text) {
        this.text = text;
        return this;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Float getPricesPerStock() {
        return pricesPerStock;
    }

    public Adverts pricesPerStock(Float pricesPerStock) {
        this.pricesPerStock = pricesPerStock;
        return this;
    }

    public void setPricesPerStock(Float pricesPerStock) {
        this.pricesPerStock = pricesPerStock;
    }

    public Integer getUnits() {
        return units;
    }

    public Adverts units(Integer units) {
        this.units = units;
        return this;
    }

    public void setUnits(Integer units) {
        this.units = units;
    }

    public Instant getStartdate() {
        return startdate;
    }

    public Adverts startdate(Instant startdate) {
        this.startdate = startdate;
        return this;
    }

    public void setStartdate(Instant startdate) {
        this.startdate = startdate;
    }

    public Instant getEndDate() {
        return endDate;
    }

    public Adverts endDate(Instant endDate) {
        this.endDate = endDate;
        return this;
    }

    public void setEndDate(Instant endDate) {
        this.endDate = endDate;
    }

    public Set<Supplier> getSuppliers() {
        return suppliers;
    }

    public Adverts suppliers(Set<Supplier> suppliers) {
        this.suppliers = suppliers;
        return this;
    }

    public Adverts addSupplier(Supplier supplier) {
        this.suppliers.add(supplier);
        supplier.getAdverts().add(this);
        return this;
    }

    public Adverts removeSupplier(Supplier supplier) {
        this.suppliers.remove(supplier);
        supplier.getAdverts().remove(this);
        return this;
    }

    public void setSuppliers(Set<Supplier> suppliers) {
        this.suppliers = suppliers;
    }

    public Set<Stock> getStocks() {
        return stocks;
    }

    public Adverts stocks(Set<Stock> stocks) {
        this.stocks = stocks;
        return this;
    }

    public Adverts addStock(Stock stock) {
        this.stocks.add(stock);
        stock.getAdverts().add(this);
        return this;
    }

    public Adverts removeStock(Stock stock) {
        this.stocks.remove(stock);
        stock.getAdverts().remove(this);
        return this;
    }

    public void setStocks(Set<Stock> stocks) {
        this.stocks = stocks;
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
        Adverts adverts = (Adverts) o;
        if (adverts.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), adverts.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "Adverts{" +
            "id=" + getId() +
            ", text='" + getText() + "'" +
            ", pricesPerStock=" + getPricesPerStock() +
            ", units=" + getUnits() +
            ", startdate='" + getStartdate() + "'" +
            ", endDate='" + getEndDate() + "'" +
            "}";
    }
}
