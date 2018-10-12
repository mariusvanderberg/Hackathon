package com.foodsource.apples.domain;


import javax.persistence.*;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A Supplier.
 */
@Entity
@Table(name = "supplier")
public class Supplier implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "surname")
    private String surname;

    @Column(name = "reg_number")
    private String regNumber;

    @Column(name = "active")
    private Boolean active;

    @OneToOne
    @JoinColumn(unique = true)
    private ContactInfo contactInfo;

    @ManyToMany
    @JoinTable(name = "supplier_adverts",
               joinColumns = @JoinColumn(name = "suppliers_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "adverts_id", referencedColumnName = "id"))
    private Set<Adverts> adverts = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "supplier_stock",
               joinColumns = @JoinColumn(name = "suppliers_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "stocks_id", referencedColumnName = "id"))
    private Set<Stock> stocks = new HashSet<>();

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

    public Supplier name(String name) {
        this.name = name;
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public Supplier surname(String surname) {
        this.surname = surname;
        return this;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getRegNumber() {
        return regNumber;
    }

    public Supplier regNumber(String regNumber) {
        this.regNumber = regNumber;
        return this;
    }

    public void setRegNumber(String regNumber) {
        this.regNumber = regNumber;
    }

    public Boolean isActive() {
        return active;
    }

    public Supplier active(Boolean active) {
        this.active = active;
        return this;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public ContactInfo getContactInfo() {
        return contactInfo;
    }

    public Supplier contactInfo(ContactInfo contactInfo) {
        this.contactInfo = contactInfo;
        return this;
    }

    public void setContactInfo(ContactInfo contactInfo) {
        this.contactInfo = contactInfo;
    }

    public Set<Adverts> getAdverts() {
        return adverts;
    }

    public Supplier adverts(Set<Adverts> adverts) {
        this.adverts = adverts;
        return this;
    }

    public Supplier addAdverts(Adverts adverts) {
        this.adverts.add(adverts);
        adverts.getSuppliers().add(this);
        return this;
    }

    public Supplier removeAdverts(Adverts adverts) {
        this.adverts.remove(adverts);
        adverts.getSuppliers().remove(this);
        return this;
    }

    public void setAdverts(Set<Adverts> adverts) {
        this.adverts = adverts;
    }

    public Set<Stock> getStocks() {
        return stocks;
    }

    public Supplier stocks(Set<Stock> stocks) {
        this.stocks = stocks;
        return this;
    }

    public Supplier addStock(Stock stock) {
        this.stocks.add(stock);
        stock.getSuppliers().add(this);
        return this;
    }

    public Supplier removeStock(Stock stock) {
        this.stocks.remove(stock);
        stock.getSuppliers().remove(this);
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
        Supplier supplier = (Supplier) o;
        if (supplier.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), supplier.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "Supplier{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", surname='" + getSurname() + "'" +
            ", regNumber='" + getRegNumber() + "'" +
            ", active='" + isActive() + "'" +
            "}";
    }
}
