package com.foodsource.apples.service.impl;

import com.foodsource.apples.service.StockTypeService;
import com.foodsource.apples.domain.StockType;
import com.foodsource.apples.repository.StockTypeRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;
/**
 * Service Implementation for managing StockType.
 */
@Service
@Transactional
public class StockTypeServiceImpl implements StockTypeService {

    private final Logger log = LoggerFactory.getLogger(StockTypeServiceImpl.class);

    private final StockTypeRepository stockTypeRepository;

    public StockTypeServiceImpl(StockTypeRepository stockTypeRepository) {
        this.stockTypeRepository = stockTypeRepository;
    }

    /**
     * Save a stockType.
     *
     * @param stockType the entity to save
     * @return the persisted entity
     */
    @Override
    public StockType save(StockType stockType) {
        log.debug("Request to save StockType : {}", stockType);        return stockTypeRepository.save(stockType);
    }

    /**
     * Get all the stockTypes.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<StockType> findAll(Pageable pageable) {
        log.debug("Request to get all StockTypes");
        return stockTypeRepository.findAll(pageable);
    }


    /**
     * Get one stockType by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<StockType> findOne(Long id) {
        log.debug("Request to get StockType : {}", id);
        return stockTypeRepository.findById(id);
    }

    /**
     * Delete the stockType by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete StockType : {}", id);
        stockTypeRepository.deleteById(id);
    }
}
