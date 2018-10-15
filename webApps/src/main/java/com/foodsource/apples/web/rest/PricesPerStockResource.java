package com.foodsource.apples.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.foodsource.apples.domain.PricesPerStock;
import com.foodsource.apples.service.PricesPerStockService;
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
 * REST controller for managing PricesPerStock.
 */
@RestController
@RequestMapping("/api")
public class PricesPerStockResource {

    private final Logger log = LoggerFactory.getLogger(PricesPerStockResource.class);

    private static final String ENTITY_NAME = "pricesPerStock";

    private final PricesPerStockService pricesPerStockService;

    public PricesPerStockResource(PricesPerStockService pricesPerStockService) {
        this.pricesPerStockService = pricesPerStockService;
    }

    /**
     * POST  /prices-per-stocks : Create a new pricesPerStock.
     *
     * @param pricesPerStock the pricesPerStock to create
     * @return the ResponseEntity with status 201 (Created) and with body the new pricesPerStock, or with status 400 (Bad Request) if the pricesPerStock has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/prices-per-stocks")
    @Timed
    public ResponseEntity<PricesPerStock> createPricesPerStock(@RequestBody PricesPerStock pricesPerStock) throws URISyntaxException {
        log.debug("REST request to save PricesPerStock : {}", pricesPerStock);
        if (pricesPerStock.getId() != null) {
            throw new BadRequestAlertException("A new pricesPerStock cannot already have an ID", ENTITY_NAME, "idexists");
        }
        PricesPerStock result = pricesPerStockService.save(pricesPerStock);
        return ResponseEntity.created(new URI("/api/prices-per-stocks/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /prices-per-stocks : Updates an existing pricesPerStock.
     *
     * @param pricesPerStock the pricesPerStock to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated pricesPerStock,
     * or with status 400 (Bad Request) if the pricesPerStock is not valid,
     * or with status 500 (Internal Server Error) if the pricesPerStock couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/prices-per-stocks")
    @Timed
    public ResponseEntity<PricesPerStock> updatePricesPerStock(@RequestBody PricesPerStock pricesPerStock) throws URISyntaxException {
        log.debug("REST request to update PricesPerStock : {}", pricesPerStock);
        if (pricesPerStock.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        PricesPerStock result = pricesPerStockService.save(pricesPerStock);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, pricesPerStock.getId().toString()))
            .body(result);
    }

    /**
     * GET  /prices-per-stocks : get all the pricesPerStocks.
     *
     * @param pageable the pagination information
     * @return the ResponseEntity with status 200 (OK) and the list of pricesPerStocks in body
     */
    @GetMapping("/prices-per-stocks")
    @Timed
    public ResponseEntity<List<PricesPerStock>> getAllPricesPerStocks(Pageable pageable) {
        log.debug("REST request to get a page of PricesPerStocks");
        Page<PricesPerStock> page = pricesPerStockService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, "/api/prices-per-stocks");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /prices-per-stocks/:id : get the "id" pricesPerStock.
     *
     * @param id the id of the pricesPerStock to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the pricesPerStock, or with status 404 (Not Found)
     */
    @GetMapping("/prices-per-stocks/{id}")
    @Timed
    public ResponseEntity<PricesPerStock> getPricesPerStock(@PathVariable Long id) {
        log.debug("REST request to get PricesPerStock : {}", id);
        Optional<PricesPerStock> pricesPerStock = pricesPerStockService.findOne(id);
        return ResponseUtil.wrapOrNotFound(pricesPerStock);
    }

    /**
     * DELETE  /prices-per-stocks/:id : delete the "id" pricesPerStock.
     *
     * @param id the id of the pricesPerStock to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/prices-per-stocks/{id}")
    @Timed
    public ResponseEntity<Void> deletePricesPerStock(@PathVariable Long id) {
        log.debug("REST request to delete PricesPerStock : {}", id);
        pricesPerStockService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }
}
