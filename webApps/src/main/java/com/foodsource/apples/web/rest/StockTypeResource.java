package com.foodsource.apples.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.foodsource.apples.domain.StockType;
import com.foodsource.apples.service.StockTypeService;
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
 * REST controller for managing StockType.
 */
@RestController
@RequestMapping("/api")
public class StockTypeResource {

    private final Logger log = LoggerFactory.getLogger(StockTypeResource.class);

    private static final String ENTITY_NAME = "stockType";

    private final StockTypeService stockTypeService;

    public StockTypeResource(StockTypeService stockTypeService) {
        this.stockTypeService = stockTypeService;
    }

    /**
     * POST  /stock-types : Create a new stockType.
     *
     * @param stockType the stockType to create
     * @return the ResponseEntity with status 201 (Created) and with body the new stockType, or with status 400 (Bad Request) if the stockType has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/stock-types")
    @Timed
    public ResponseEntity<StockType> createStockType(@RequestBody StockType stockType) throws URISyntaxException {
        log.debug("REST request to save StockType : {}", stockType);
        if (stockType.getId() != null) {
            throw new BadRequestAlertException("A new stockType cannot already have an ID", ENTITY_NAME, "idexists");
        }
        StockType result = stockTypeService.save(stockType);
        return ResponseEntity.created(new URI("/api/stock-types/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /stock-types : Updates an existing stockType.
     *
     * @param stockType the stockType to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated stockType,
     * or with status 400 (Bad Request) if the stockType is not valid,
     * or with status 500 (Internal Server Error) if the stockType couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/stock-types")
    @Timed
    public ResponseEntity<StockType> updateStockType(@RequestBody StockType stockType) throws URISyntaxException {
        log.debug("REST request to update StockType : {}", stockType);
        if (stockType.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        StockType result = stockTypeService.save(stockType);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, stockType.getId().toString()))
            .body(result);
    }

    /**
     * GET  /stock-types : get all the stockTypes.
     *
     * @param pageable the pagination information
     * @return the ResponseEntity with status 200 (OK) and the list of stockTypes in body
     */
    @GetMapping("/stock-types")
    @Timed
    public ResponseEntity<List<StockType>> getAllStockTypes(Pageable pageable) {
        log.debug("REST request to get a page of StockTypes");
        Page<StockType> page = stockTypeService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, "/api/stock-types");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /stock-types/:id : get the "id" stockType.
     *
     * @param id the id of the stockType to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the stockType, or with status 404 (Not Found)
     */
    @GetMapping("/stock-types/{id}")
    @Timed
    public ResponseEntity<StockType> getStockType(@PathVariable Long id) {
        log.debug("REST request to get StockType : {}", id);
        Optional<StockType> stockType = stockTypeService.findOne(id);
        return ResponseUtil.wrapOrNotFound(stockType);
    }

    /**
     * DELETE  /stock-types/:id : delete the "id" stockType.
     *
     * @param id the id of the stockType to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/stock-types/{id}")
    @Timed
    public ResponseEntity<Void> deleteStockType(@PathVariable Long id) {
        log.debug("REST request to delete StockType : {}", id);
        stockTypeService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }
}
