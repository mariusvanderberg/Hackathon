package com.foodsource.apples.domain;


import javax.persistence.*;

import java.io.Serializable;
import java.util.Objects;

/**
 * A StockType.
 */
@Entity
@Table(name = "stock_type")
public class StockType implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "variation")
    private String variation;

    @Column(name = "description")
    private String description;

    @Column(name = "fruit")
    private Boolean fruit;

    @Column(name = "vegtable")
    private Boolean vegtable;

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getVariation() {
        return variation;
    }

    public StockType variation(String variation) {
        this.variation = variation;
        return this;
    }

    public void setVariation(String variation) {
        this.variation = variation;
    }

    public String getDescription() {
        return description;
    }

    public StockType description(String description) {
        this.description = description;
        return this;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean isFruit() {
        return fruit;
    }

    public StockType fruit(Boolean fruit) {
        this.fruit = fruit;
        return this;
    }

    public void setFruit(Boolean fruit) {
        this.fruit = fruit;
    }

    public Boolean isVegtable() {
        return vegtable;
    }

    public StockType vegtable(Boolean vegtable) {
        this.vegtable = vegtable;
        return this;
    }

    public void setVegtable(Boolean vegtable) {
        this.vegtable = vegtable;
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
        StockType stockType = (StockType) o;
        if (stockType.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), stockType.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "StockType{" +
            "id=" + getId() +
            ", variation='" + getVariation() + "'" +
            ", description='" + getDescription() + "'" +
            ", fruit='" + isFruit() + "'" +
            ", vegtable='" + isVegtable() + "'" +
            "}";
    }
}
