package com.foodsource.apples.service.impl;

import com.foodsource.apples.service.AdvertsService;
import com.foodsource.apples.domain.Adverts;
import com.foodsource.apples.repository.AdvertsRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;
/**
 * Service Implementation for managing Adverts.
 */
@Service
@Transactional
public class AdvertsServiceImpl implements AdvertsService {

    private final Logger log = LoggerFactory.getLogger(AdvertsServiceImpl.class);

    private final AdvertsRepository advertsRepository;

    public AdvertsServiceImpl(AdvertsRepository advertsRepository) {
        this.advertsRepository = advertsRepository;
    }

    /**
     * Save a adverts.
     *
     * @param adverts the entity to save
     * @return the persisted entity
     */
    @Override
    public Adverts save(Adverts adverts) {
        log.debug("Request to save Adverts : {}", adverts);        return advertsRepository.save(adverts);
    }

    /**
     * Get all the adverts.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<Adverts> findAll(Pageable pageable) {
        log.debug("Request to get all Adverts");
        return advertsRepository.findAll(pageable);
    }


    /**
     * Get one adverts by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<Adverts> findOne(Long id) {
        log.debug("Request to get Adverts : {}", id);
        return advertsRepository.findById(id);
    }

    /**
     * Delete the adverts by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete Adverts : {}", id);
        advertsRepository.deleteById(id);
    }
}
