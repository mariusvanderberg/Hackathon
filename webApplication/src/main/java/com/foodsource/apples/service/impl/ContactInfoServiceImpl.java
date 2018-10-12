package com.foodsource.apples.service.impl;

import com.foodsource.apples.service.ContactInfoService;
import com.foodsource.apples.domain.ContactInfo;
import com.foodsource.apples.repository.ContactInfoRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;
/**
 * Service Implementation for managing ContactInfo.
 */
@Service
@Transactional
public class ContactInfoServiceImpl implements ContactInfoService {

    private final Logger log = LoggerFactory.getLogger(ContactInfoServiceImpl.class);

    private final ContactInfoRepository contactInfoRepository;

    public ContactInfoServiceImpl(ContactInfoRepository contactInfoRepository) {
        this.contactInfoRepository = contactInfoRepository;
    }

    /**
     * Save a contactInfo.
     *
     * @param contactInfo the entity to save
     * @return the persisted entity
     */
    @Override
    public ContactInfo save(ContactInfo contactInfo) {
        log.debug("Request to save ContactInfo : {}", contactInfo);        return contactInfoRepository.save(contactInfo);
    }

    /**
     * Get all the contactInfos.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ContactInfo> findAll(Pageable pageable) {
        log.debug("Request to get all ContactInfos");
        return contactInfoRepository.findAll(pageable);
    }


    /**
     * Get one contactInfo by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<ContactInfo> findOne(Long id) {
        log.debug("Request to get ContactInfo : {}", id);
        return contactInfoRepository.findById(id);
    }

    /**
     * Delete the contactInfo by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete ContactInfo : {}", id);
        contactInfoRepository.deleteById(id);
    }
}
