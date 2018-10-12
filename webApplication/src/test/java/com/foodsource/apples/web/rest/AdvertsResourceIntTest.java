package com.foodsource.apples.web.rest;

import com.foodsource.apples.FoodsourceApp;

import com.foodsource.apples.domain.Adverts;
import com.foodsource.apples.repository.AdvertsRepository;
import com.foodsource.apples.service.AdvertsService;
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
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.List;


import static com.foodsource.apples.web.rest.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the AdvertsResource REST controller.
 *
 * @see AdvertsResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = FoodsourceApp.class)
public class AdvertsResourceIntTest {

    private static final String DEFAULT_TEXT = "AAAAAAAAAA";
    private static final String UPDATED_TEXT = "BBBBBBBBBB";

    private static final Float DEFAULT_PRICES_PER_STOCK = 1F;
    private static final Float UPDATED_PRICES_PER_STOCK = 2F;

    private static final Integer DEFAULT_UNITS = 1;
    private static final Integer UPDATED_UNITS = 2;

    private static final Instant DEFAULT_STARTDATE = Instant.ofEpochMilli(0L);
    private static final Instant UPDATED_STARTDATE = Instant.now().truncatedTo(ChronoUnit.MILLIS);

    private static final Instant DEFAULT_END_DATE = Instant.ofEpochMilli(0L);
    private static final Instant UPDATED_END_DATE = Instant.now().truncatedTo(ChronoUnit.MILLIS);

    @Autowired
    private AdvertsRepository advertsRepository;

    

    @Autowired
    private AdvertsService advertsService;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restAdvertsMockMvc;

    private Adverts adverts;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final AdvertsResource advertsResource = new AdvertsResource(advertsService);
        this.restAdvertsMockMvc = MockMvcBuilders.standaloneSetup(advertsResource)
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
    public static Adverts createEntity(EntityManager em) {
        Adverts adverts = new Adverts()
            .text(DEFAULT_TEXT)
            .pricesPerStock(DEFAULT_PRICES_PER_STOCK)
            .units(DEFAULT_UNITS)
            .startdate(DEFAULT_STARTDATE)
            .endDate(DEFAULT_END_DATE);
        return adverts;
    }

    @Before
    public void initTest() {
        adverts = createEntity(em);
    }

    @Test
    @Transactional
    public void createAdverts() throws Exception {
        int databaseSizeBeforeCreate = advertsRepository.findAll().size();

        // Create the Adverts
        restAdvertsMockMvc.perform(post("/api/adverts")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(adverts)))
            .andExpect(status().isCreated());

        // Validate the Adverts in the database
        List<Adverts> advertsList = advertsRepository.findAll();
        assertThat(advertsList).hasSize(databaseSizeBeforeCreate + 1);
        Adverts testAdverts = advertsList.get(advertsList.size() - 1);
        assertThat(testAdverts.getText()).isEqualTo(DEFAULT_TEXT);
        assertThat(testAdverts.getPricesPerStock()).isEqualTo(DEFAULT_PRICES_PER_STOCK);
        assertThat(testAdverts.getUnits()).isEqualTo(DEFAULT_UNITS);
        assertThat(testAdverts.getStartdate()).isEqualTo(DEFAULT_STARTDATE);
        assertThat(testAdverts.getEndDate()).isEqualTo(DEFAULT_END_DATE);
    }

    @Test
    @Transactional
    public void createAdvertsWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = advertsRepository.findAll().size();

        // Create the Adverts with an existing ID
        adverts.setId(1L);

        // An entity with an existing ID cannot be created, so this API call must fail
        restAdvertsMockMvc.perform(post("/api/adverts")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(adverts)))
            .andExpect(status().isBadRequest());

        // Validate the Adverts in the database
        List<Adverts> advertsList = advertsRepository.findAll();
        assertThat(advertsList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    public void getAllAdverts() throws Exception {
        // Initialize the database
        advertsRepository.saveAndFlush(adverts);

        // Get all the advertsList
        restAdvertsMockMvc.perform(get("/api/adverts?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(adverts.getId().intValue())))
            .andExpect(jsonPath("$.[*].text").value(hasItem(DEFAULT_TEXT.toString())))
            .andExpect(jsonPath("$.[*].pricesPerStock").value(hasItem(DEFAULT_PRICES_PER_STOCK.doubleValue())))
            .andExpect(jsonPath("$.[*].units").value(hasItem(DEFAULT_UNITS)))
            .andExpect(jsonPath("$.[*].startdate").value(hasItem(DEFAULT_STARTDATE.toString())))
            .andExpect(jsonPath("$.[*].endDate").value(hasItem(DEFAULT_END_DATE.toString())));
    }
    

    @Test
    @Transactional
    public void getAdverts() throws Exception {
        // Initialize the database
        advertsRepository.saveAndFlush(adverts);

        // Get the adverts
        restAdvertsMockMvc.perform(get("/api/adverts/{id}", adverts.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(adverts.getId().intValue()))
            .andExpect(jsonPath("$.text").value(DEFAULT_TEXT.toString()))
            .andExpect(jsonPath("$.pricesPerStock").value(DEFAULT_PRICES_PER_STOCK.doubleValue()))
            .andExpect(jsonPath("$.units").value(DEFAULT_UNITS))
            .andExpect(jsonPath("$.startdate").value(DEFAULT_STARTDATE.toString()))
            .andExpect(jsonPath("$.endDate").value(DEFAULT_END_DATE.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingAdverts() throws Exception {
        // Get the adverts
        restAdvertsMockMvc.perform(get("/api/adverts/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateAdverts() throws Exception {
        // Initialize the database
        advertsService.save(adverts);

        int databaseSizeBeforeUpdate = advertsRepository.findAll().size();

        // Update the adverts
        Adverts updatedAdverts = advertsRepository.findById(adverts.getId()).get();
        // Disconnect from session so that the updates on updatedAdverts are not directly saved in db
        em.detach(updatedAdverts);
        updatedAdverts
            .text(UPDATED_TEXT)
            .pricesPerStock(UPDATED_PRICES_PER_STOCK)
            .units(UPDATED_UNITS)
            .startdate(UPDATED_STARTDATE)
            .endDate(UPDATED_END_DATE);

        restAdvertsMockMvc.perform(put("/api/adverts")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(updatedAdverts)))
            .andExpect(status().isOk());

        // Validate the Adverts in the database
        List<Adverts> advertsList = advertsRepository.findAll();
        assertThat(advertsList).hasSize(databaseSizeBeforeUpdate);
        Adverts testAdverts = advertsList.get(advertsList.size() - 1);
        assertThat(testAdverts.getText()).isEqualTo(UPDATED_TEXT);
        assertThat(testAdverts.getPricesPerStock()).isEqualTo(UPDATED_PRICES_PER_STOCK);
        assertThat(testAdverts.getUnits()).isEqualTo(UPDATED_UNITS);
        assertThat(testAdverts.getStartdate()).isEqualTo(UPDATED_STARTDATE);
        assertThat(testAdverts.getEndDate()).isEqualTo(UPDATED_END_DATE);
    }

    @Test
    @Transactional
    public void updateNonExistingAdverts() throws Exception {
        int databaseSizeBeforeUpdate = advertsRepository.findAll().size();

        // Create the Adverts

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restAdvertsMockMvc.perform(put("/api/adverts")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(adverts)))
            .andExpect(status().isBadRequest());

        // Validate the Adverts in the database
        List<Adverts> advertsList = advertsRepository.findAll();
        assertThat(advertsList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    public void deleteAdverts() throws Exception {
        // Initialize the database
        advertsService.save(adverts);

        int databaseSizeBeforeDelete = advertsRepository.findAll().size();

        // Get the adverts
        restAdvertsMockMvc.perform(delete("/api/adverts/{id}", adverts.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<Adverts> advertsList = advertsRepository.findAll();
        assertThat(advertsList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Adverts.class);
        Adverts adverts1 = new Adverts();
        adverts1.setId(1L);
        Adverts adverts2 = new Adverts();
        adverts2.setId(adverts1.getId());
        assertThat(adverts1).isEqualTo(adverts2);
        adverts2.setId(2L);
        assertThat(adverts1).isNotEqualTo(adverts2);
        adverts1.setId(null);
        assertThat(adverts1).isNotEqualTo(adverts2);
    }
}
