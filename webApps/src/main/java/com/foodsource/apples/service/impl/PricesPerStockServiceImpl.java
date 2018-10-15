package com.foodsource.apples.service.impl;

import com.foodsource.apples.service.PricesPerStockService;
import com.foodsource.apples.domain.PricesPerStock;
import com.foodsource.apples.repository.PricesPerStockRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;
/**
 * Service Implementation for managing PricesPerStock.
 */
@Service
@Transactional
public class PricesPerStockServiceImpl implements PricesPerStockService {

    private final Logger log = LoggerFactory.getLogger(PricesPerStockServiceImpl.class);

    private final PricesPerStockRepository pricesPerStockRepository;

    public PricesPerStockServiceImpl(PricesPerStockRepository pricesPerStockRepository) {
        this.pricesPerStockRepository = pricesPerStockRepository;
    }

    /**
     * Save a pricesPerStock.
     *
     * @param pricesPerStock the entity to save
     * @return the persisted entity
     */
    @Override
    public PricesPerStock save(PricesPerStock pricesPerStock) {
        log.debug("Request to save PricesPerStock : {}", pricesPerStock);        return pricesPerStockRepository.save(pricesPerStock);
    }

    /**
     * Get all the pricesPerStocks.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<PricesPerStock> findAll(Pageable pageable) {
        log.debug("Request to get all PricesPerStocks");
        return pricesPerStockRepository.findAll(pageable);
    }


    /**
     * Get one pricesPerStock by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<PricesPerStock> findOne(Long id) {
        log.debug("Request to get PricesPerStock : {}", id);
        return pricesPerStockRepository.findById(id);
    }

    /**
     * Delete the pricesPerStock by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete PricesPerStock : {}", id);
        pricesPerStockRepository.deleteById(id);
    }
}
