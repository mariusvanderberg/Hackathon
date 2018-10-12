package com.foodsource.apples.service;

import com.foodsource.apples.domain.PricesPerStock;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing PricesPerStock.
 */
public interface PricesPerStockService {

    /**
     * Save a pricesPerStock.
     *
     * @param pricesPerStock the entity to save
     * @return the persisted entity
     */
    PricesPerStock save(PricesPerStock pricesPerStock);

    /**
     * Get all the pricesPerStocks.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<PricesPerStock> findAll(Pageable pageable);


    /**
     * Get the "id" pricesPerStock.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<PricesPerStock> findOne(Long id);

    /**
     * Delete the "id" pricesPerStock.
     *
     * @param id the id of the entity
     */
    void delete(Long id);
}
