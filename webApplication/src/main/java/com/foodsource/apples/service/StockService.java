package com.foodsource.apples.service;

import com.foodsource.apples.domain.Stock;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing Stock.
 */
public interface StockService {

    /**
     * Save a stock.
     *
     * @param stock the entity to save
     * @return the persisted entity
     */
    Stock save(Stock stock);

    /**
     * Get all the stocks.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<Stock> findAll(Pageable pageable);

    /**
     * Get all the Stock with eager load of many-to-many relationships.
     *
     * @return the list of entities
     */
    Page<Stock> findAllWithEagerRelationships(Pageable pageable);
    
    /**
     * Get the "id" stock.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<Stock> findOne(Long id);

    /**
     * Delete the "id" stock.
     *
     * @param id the id of the entity
     */
    void delete(Long id);
}
