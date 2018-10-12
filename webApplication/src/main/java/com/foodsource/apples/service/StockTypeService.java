package com.foodsource.apples.service;

import com.foodsource.apples.domain.StockType;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing StockType.
 */
public interface StockTypeService {

    /**
     * Save a stockType.
     *
     * @param stockType the entity to save
     * @return the persisted entity
     */
    StockType save(StockType stockType);

    /**
     * Get all the stockTypes.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<StockType> findAll(Pageable pageable);


    /**
     * Get the "id" stockType.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<StockType> findOne(Long id);

    /**
     * Delete the "id" stockType.
     *
     * @param id the id of the entity
     */
    void delete(Long id);
}
