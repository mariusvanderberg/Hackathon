package com.foodsource.apples.service;

import com.foodsource.apples.domain.Adverts;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing Adverts.
 */
public interface AdvertsService {

    /**
     * Save a adverts.
     *
     * @param adverts the entity to save
     * @return the persisted entity
     */
    Adverts save(Adverts adverts);

    /**
     * Get all the adverts.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<Adverts> findAll(Pageable pageable);


    /**
     * Get the "id" adverts.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<Adverts> findOne(Long id);

    /**
     * Delete the "id" adverts.
     *
     * @param id the id of the entity
     */
    void delete(Long id);
}
