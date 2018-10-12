package com.foodsource.apples.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.annotations.ApiModel;

import javax.persistence.*;

import java.io.Serializable;
import java.util.Objects;

/**
 * Task entity.
 * @author The JHipster team.
 */
@ApiModel(description = "Task entity. @author The JHipster team.")
@Entity
@Table(name = "prices_per_stock")
public class PricesPerStock implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "price")
    private Float price;

    @Column(name = "unit")
    private String unit;

    @ManyToOne
    @JsonIgnoreProperties("pricesperstocks")
    private Stock stock;

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Float getPrice() {
        return price;
    }

    public PricesPerStock price(Float price) {
        this.price = price;
        return this;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public String getUnit() {
        return unit;
    }

    public PricesPerStock unit(String unit) {
        this.unit = unit;
        return this;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Stock getStock() {
        return stock;
    }

    public PricesPerStock stock(Stock stock) {
        this.stock = stock;
        return this;
    }

    public void setStock(Stock stock) {
        this.stock = stock;
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
        PricesPerStock pricesPerStock = (PricesPerStock) o;
        if (pricesPerStock.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), pricesPerStock.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "PricesPerStock{" +
            "id=" + getId() +
            ", price=" + getPrice() +
            ", unit='" + getUnit() + "'" +
            "}";
    }
}
