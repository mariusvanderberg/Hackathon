package com.foodsource.apples.web.rest;

import com.foodsource.apples.FoodsourceApp;

import com.foodsource.apples.domain.StockType;
import com.foodsource.apples.repository.StockTypeRepository;
import com.foodsource.apples.service.StockTypeService;
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
 * Test class for the StockTypeResource REST controller.
 *
 * @see StockTypeResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = FoodsourceApp.class)
public class StockTypeResourceIntTest {

    private static final String DEFAULT_VARIATION = "AAAAAAAAAA";
    private static final String UPDATED_VARIATION = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    private static final Boolean DEFAULT_FRUIT = false;
    private static final Boolean UPDATED_FRUIT = true;

    private static final Boolean DEFAULT_VEGTABLE = false;
    private static final Boolean UPDATED_VEGTABLE = true;

    @Autowired
    private StockTypeRepository stockTypeRepository;

    

    @Autowired
    private StockTypeService stockTypeService;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restStockTypeMockMvc;

    private StockType stockType;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final StockTypeResource stockTypeResource = new StockTypeResource(stockTypeService);
        this.restStockTypeMockMvc = MockMvcBuilders.standaloneSetup(stockTypeResource)
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
    public static StockType createEntity(EntityManager em) {
        StockType stockType = new StockType()
            .variation(DEFAULT_VARIATION)
            .description(DEFAULT_DESCRIPTION)
            .fruit(DEFAULT_FRUIT)
            .vegtable(DEFAULT_VEGTABLE);
        return stockType;
    }

    @Before
    public void initTest() {
        stockType = createEntity(em);
    }

    @Test
    @Transactional
    public void createStockType() throws Exception {
        int databaseSizeBeforeCreate = stockTypeRepository.findAll().size();

        // Create the StockType
        restStockTypeMockMvc.perform(post("/api/stock-types")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(stockType)))
            .andExpect(status().isCreated());

        // Validate the StockType in the database
        List<StockType> stockTypeList = stockTypeRepository.findAll();
        assertThat(stockTypeList).hasSize(databaseSizeBeforeCreate + 1);
        StockType testStockType = stockTypeList.get(stockTypeList.size() - 1);
        assertThat(testStockType.getVariation()).isEqualTo(DEFAULT_VARIATION);
        assertThat(testStockType.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
        assertThat(testStockType.isFruit()).isEqualTo(DEFAULT_FRUIT);
        assertThat(testStockType.isVegtable()).isEqualTo(DEFAULT_VEGTABLE);
    }

    @Test
    @Transactional
    public void createStockTypeWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = stockTypeRepository.findAll().size();

        // Create the StockType with an existing ID
        stockType.setId(1L);

        // An entity with an existing ID cannot be created, so this API call must fail
        restStockTypeMockMvc.perform(post("/api/stock-types")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(stockType)))
            .andExpect(status().isBadRequest());

        // Validate the StockType in the database
        List<StockType> stockTypeList = stockTypeRepository.findAll();
        assertThat(stockTypeList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    public void getAllStockTypes() throws Exception {
        // Initialize the database
        stockTypeRepository.saveAndFlush(stockType);

        // Get all the stockTypeList
        restStockTypeMockMvc.perform(get("/api/stock-types?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(stockType.getId().intValue())))
            .andExpect(jsonPath("$.[*].variation").value(hasItem(DEFAULT_VARIATION.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())))
            .andExpect(jsonPath("$.[*].fruit").value(hasItem(DEFAULT_FRUIT.booleanValue())))
            .andExpect(jsonPath("$.[*].vegtable").value(hasItem(DEFAULT_VEGTABLE.booleanValue())));
    }
    

    @Test
    @Transactional
    public void getStockType() throws Exception {
        // Initialize the database
        stockTypeRepository.saveAndFlush(stockType);

        // Get the stockType
        restStockTypeMockMvc.perform(get("/api/stock-types/{id}", stockType.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(stockType.getId().intValue()))
            .andExpect(jsonPath("$.variation").value(DEFAULT_VARIATION.toString()))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION.toString()))
            .andExpect(jsonPath("$.fruit").value(DEFAULT_FRUIT.booleanValue()))
            .andExpect(jsonPath("$.vegtable").value(DEFAULT_VEGTABLE.booleanValue()));
    }
    @Test
    @Transactional
    public void getNonExistingStockType() throws Exception {
        // Get the stockType
        restStockTypeMockMvc.perform(get("/api/stock-types/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateStockType() throws Exception {
        // Initialize the database
        stockTypeService.save(stockType);

        int databaseSizeBeforeUpdate = stockTypeRepository.findAll().size();

        // Update the stockType
        StockType updatedStockType = stockTypeRepository.findById(stockType.getId()).get();
        // Disconnect from session so that the updates on updatedStockType are not directly saved in db
        em.detach(updatedStockType);
        updatedStockType
            .variation(UPDATED_VARIATION)
            .description(UPDATED_DESCRIPTION)
            .fruit(UPDATED_FRUIT)
            .vegtable(UPDATED_VEGTABLE);

        restStockTypeMockMvc.perform(put("/api/stock-types")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(updatedStockType)))
            .andExpect(status().isOk());

        // Validate the StockType in the database
        List<StockType> stockTypeList = stockTypeRepository.findAll();
        assertThat(stockTypeList).hasSize(databaseSizeBeforeUpdate);
        StockType testStockType = stockTypeList.get(stockTypeList.size() - 1);
        assertThat(testStockType.getVariation()).isEqualTo(UPDATED_VARIATION);
        assertThat(testStockType.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
        assertThat(testStockType.isFruit()).isEqualTo(UPDATED_FRUIT);
        assertThat(testStockType.isVegtable()).isEqualTo(UPDATED_VEGTABLE);
    }

    @Test
    @Transactional
    public void updateNonExistingStockType() throws Exception {
        int databaseSizeBeforeUpdate = stockTypeRepository.findAll().size();

        // Create the StockType

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restStockTypeMockMvc.perform(put("/api/stock-types")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(stockType)))
            .andExpect(status().isBadRequest());

        // Validate the StockType in the database
        List<StockType> stockTypeList = stockTypeRepository.findAll();
        assertThat(stockTypeList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    public void deleteStockType() throws Exception {
        // Initialize the database
        stockTypeService.save(stockType);

        int databaseSizeBeforeDelete = stockTypeRepository.findAll().size();

        // Get the stockType
        restStockTypeMockMvc.perform(delete("/api/stock-types/{id}", stockType.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<StockType> stockTypeList = stockTypeRepository.findAll();
        assertThat(stockTypeList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(StockType.class);
        StockType stockType1 = new StockType();
        stockType1.setId(1L);
        StockType stockType2 = new StockType();
        stockType2.setId(stockType1.getId());
        assertThat(stockType1).isEqualTo(stockType2);
        stockType2.setId(2L);
        assertThat(stockType1).isNotEqualTo(stockType2);
        stockType1.setId(null);
        assertThat(stockType1).isNotEqualTo(stockType2);
    }
}
