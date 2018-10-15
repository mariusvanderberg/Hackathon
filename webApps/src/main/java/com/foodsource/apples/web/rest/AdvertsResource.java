package com.foodsource.apples.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.foodsource.apples.domain.Adverts;
import com.foodsource.apples.service.AdvertsService;
import com.foodsource.apples.web.rest.errors.BadRequestAlertException;
import com.foodsource.apples.web.rest.util.HeaderUtil;
import com.foodsource.apples.web.rest.util.PaginationUtil;
import io.github.jhipster.web.util.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;

import java.util.List;
import java.util.Optional;

/**
 * REST controller for managing Adverts.
 */
@RestController
@RequestMapping("/api")
public class AdvertsResource {

    private final Logger log = LoggerFactory.getLogger(AdvertsResource.class);

    private static final String ENTITY_NAME = "adverts";

    private final AdvertsService advertsService;

    public AdvertsResource(AdvertsService advertsService) {
        this.advertsService = advertsService;
    }

    /**
     * POST  /adverts : Create a new adverts.
     *
     * @param adverts the adverts to create
     * @return the ResponseEntity with status 201 (Created) and with body the new adverts, or with status 400 (Bad Request) if the adverts has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/adverts")
    @Timed
    public ResponseEntity<Adverts> createAdverts(@RequestBody Adverts adverts) throws URISyntaxException {
        log.debug("REST request to save Adverts : {}", adverts);
        if (adverts.getId() != null) {
            throw new BadRequestAlertException("A new adverts cannot already have an ID", ENTITY_NAME, "idexists");
        }
        Adverts result = advertsService.save(adverts);
        return ResponseEntity.created(new URI("/api/adverts/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /adverts : Updates an existing adverts.
     *
     * @param adverts the adverts to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated adverts,
     * or with status 400 (Bad Request) if the adverts is not valid,
     * or with status 500 (Internal Server Error) if the adverts couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/adverts")
    @Timed
    public ResponseEntity<Adverts> updateAdverts(@RequestBody Adverts adverts) throws URISyntaxException {
        log.debug("REST request to update Adverts : {}", adverts);
        if (adverts.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        Adverts result = advertsService.save(adverts);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, adverts.getId().toString()))
            .body(result);
    }

    /**
     * GET  /adverts : get all the adverts.
     *
     * @param pageable the pagination information
     * @return the ResponseEntity with status 200 (OK) and the list of adverts in body
     */
    @GetMapping("/adverts")
    @Timed
    public ResponseEntity<List<Adverts>> getAllAdverts(Pageable pageable) {
        log.debug("REST request to get a page of Adverts");
        Page<Adverts> page = advertsService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, "/api/adverts");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /adverts/:id : get the "id" adverts.
     *
     * @param id the id of the adverts to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the adverts, or with status 404 (Not Found)
     */
    @GetMapping("/adverts/{id}")
    @Timed
    public ResponseEntity<Adverts> getAdverts(@PathVariable Long id) {
        log.debug("REST request to get Adverts : {}", id);
        Optional<Adverts> adverts = advertsService.findOne(id);
        return ResponseUtil.wrapOrNotFound(adverts);
    }

    /**
     * DELETE  /adverts/:id : delete the "id" adverts.
     *
     * @param id the id of the adverts to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/adverts/{id}")
    @Timed
    public ResponseEntity<Void> deleteAdverts(@PathVariable Long id) {
        log.debug("REST request to delete Adverts : {}", id);
        advertsService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }
}
