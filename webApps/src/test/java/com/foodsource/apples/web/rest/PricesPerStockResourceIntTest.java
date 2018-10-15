package com.foodsource.apples.web.rest;

import com.foodsource.apples.FoodsourceApp;

import com.foodsource.apples.domain.PricesPerStock;
import com.foodsource.apples.repository.PricesPerStockRepository;
import com.foodsource.apples.service.PricesPerStockService;
import com.foodsource.apples.web.rest.errors.ExceptionTranslator;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.web.PageableHandlerMethodArgumentResolver;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.List;


import static com.foodsource.apples.web.rest.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the PricesPerStockResource REST controller.
 *
 * @see PricesPerStockResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = FoodsourceApp.class)
public class PricesPerStockResourceIntTest {

    private static final Float DEFAULT_PRICE = 1F;
    private static final Float UPDATED_PRICE = 2F;

    private static final String DEFAULT_UNIT = "AAAAAAAAAA";
    private static final String UPDATED_UNIT = "BBBBBBBBBB";

    @Autowired
    private PricesPerStockRepository pricesPerStockRepository;

    

    @Autowired
    private PricesPerStockService pricesPerStockService;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restPricesPerStockMockMvc;

    private PricesPerStock pricesPerStock;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final PricesPerStockResource pricesPerStockResource = new PricesPerStockResource(pricesPerStockService);
        this.restPricesPerStockMockMvc = MockMvcBuilders.standaloneSetup(pricesPerStockResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();
    }

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static PricesPerStock createEntity(EntityManager em) {
        PricesPerStock pricesPerStock = new PricesPerStock()
            .price(DEFAULT_PRICE)
            .unit(DEFAULT_UNIT);
        return pricesPerStock;
    }

    @Before
    public void initTest() {
        pricesPerStock = createEntity(em);
    }

    @Test
    @Transactional
    public void createPricesPerStock() throws Exception {
        int databaseSizeBeforeCreate = pricesPerStockRepository.findAll().size();

        // Create the PricesPerStock
        restPricesPerStockMockMvc.perform(post("/api/prices-per-stocks")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(pricesPerStock)))
            .andExpect(status().isCreated());

        // Validate the PricesPerStock in the database
        List<PricesPerStock> pricesPerStockList = pricesPerStockRepository.findAll();
        assertThat(pricesPerStockList).hasSize(databaseSizeBeforeCreate + 1);
        PricesPerStock testPricesPerStock = pricesPerStockList.get(pricesPerStockList.size() - 1);
        assertThat(testPricesPerStock.getPrice()).isEqualTo(DEFAULT_PRICE);
        assertThat(testPricesPerStock.getUnit()).isEqualTo(DEFAULT_UNIT);
    }

    @Test
    @Transactional
    public void createPricesPerStockWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = pricesPerStockRepository.findAll().size();

        // Create the PricesPerStock with an existing ID
        pricesPerStock.setId(1L);

        // An entity with an existing ID cannot be created, so this API call must fail
        restPricesPerStockMockMvc.perform(post("/api/prices-per-stocks")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(pricesPerStock)))
            .andExpect(status().isBadRequest());

        // Validate the PricesPerStock in the database
        List<PricesPerStock> pricesPerStockList = pricesPerStockRepository.findAll();
        assertThat(pricesPerStockList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    public void getAllPricesPerStocks() throws Exception {
        // Initialize the database
        pricesPerStockRepository.saveAndFlush(pricesPerStock);

        // Get all the pricesPerStockList
        restPricesPerStockMockMvc.perform(get("/api/prices-per-stocks?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(pricesPerStock.getId().intValue())))
            .andExpect(jsonPath("$.[*].price").value(hasItem(DEFAULT_PRICE.doubleValue())))
            .andExpect(jsonPath("$.[*].unit").value(hasItem(DEFAULT_UNIT.toString())));
    }
    

    @Test
    @Transactional
    public void getPricesPerStock() throws Exception {
        // Initialize the database
        pricesPerStockRepository.saveAndFlush(pricesPerStock);

        // Get the pricesPerStock
        restPricesPerStockMockMvc.perform(get("/api/prices-per-stocks/{id}", pricesPerStock.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(pricesPerStock.getId().intValue()))
            .andExpect(jsonPath("$.price").value(DEFAULT_PRICE.doubleValue()))
            .andExpect(jsonPath("$.unit").value(DEFAULT_UNIT.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingPricesPerStock() throws Exception {
        // Get the pricesPerStock
        restPricesPerStockMockMvc.perform(get("/api/prices-per-stocks/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updatePricesPerStock() throws Exception {
        // Initialize the database
        pricesPerStockService.save(pricesPerStock);

        int databaseSizeBeforeUpdate = pricesPerStockRepository.findAll().size();

        // Update the pricesPerStock
        PricesPerStock updatedPricesPerStock = pricesPerStockRepository.findById(pricesPerStock.getId()).get();
        // Disconnect from session so that the updates on updatedPricesPerStock are not directly saved in db
        em.detach(updatedPricesPerStock);
        updatedPricesPerStock
            .price(UPDATED_PRICE)
            .unit(UPDATED_UNIT);

        restPricesPerStockMockMvc.perform(put("/api/prices-per-stocks")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(updatedPricesPerStock)))
            .andExpect(status().isOk());

        // Validate the PricesPerStock in the database
        List<PricesPerStock> pricesPerStockList = pricesPerStockRepository.findAll();
        assertThat(pricesPerStockList).hasSize(databaseSizeBeforeUpdate);
        PricesPerStock testPricesPerStock = pricesPerStockList.get(pricesPerStockList.size() - 1);
        assertThat(testPricesPerStock.getPrice()).isEqualTo(UPDATED_PRICE);
        assertThat(testPricesPerStock.getUnit()).isEqualTo(UPDATED_UNIT);
    }

    @Test
    @Transactional
    public void updateNonExistingPricesPerStock() throws Exception {
        int databaseSizeBeforeUpdate = pricesPerStockRepository.findAll().size();

        // Create the PricesPerStock

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restPricesPerStockMockMvc.perform(put("/api/prices-per-stocks")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(pricesPerStock)))
            .andExpect(status().isBadRequest());

        // Validate the PricesPerStock in the database
        List<PricesPerStock> pricesPerStockList = pricesPerStockRepository.findAll();
        assertThat(pricesPerStockList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    public void deletePricesPerStock() throws Exception {
        // Initialize the database
        pricesPerStockService.save(pricesPerStock);

        int databaseSizeBeforeDelete = pricesPerStockRepository.findAll().size();

        // Get the pricesPerStock
        restPricesPerStockMockMvc.perform(delete("/api/prices-per-stocks/{id}", pricesPerStock.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<PricesPerStock> pricesPerStockList = pricesPerStockRepository.findAll();
        assertThat(pricesPerStockList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(PricesPerStock.class);
        PricesPerStock pricesPerStock1 = new PricesPerStock();
        pricesPerStock1.setId(1L);
        PricesPerStock pricesPerStock2 = new PricesPerStock();
        pricesPerStock2.setId(pricesPerStock1.getId());
        assertThat(pricesPerStock1).isEqualTo(pricesPerStock2);
        pricesPerStock2.setId(2L);
        assertThat(pricesPerStock1).isNotEqualTo(pricesPerStock2);
        pricesPerStock1.setId(null);
        assertThat(pricesPerStock1).isNotEqualTo(pricesPerStock2);
    }
}
