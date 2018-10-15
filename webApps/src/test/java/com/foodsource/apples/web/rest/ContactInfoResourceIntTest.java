package com.foodsource.apples.web.rest;

import com.foodsource.apples.FoodsourceApp;

import com.foodsource.apples.domain.ContactInfo;
import com.foodsource.apples.repository.ContactInfoRepository;
import com.foodsource.apples.service.ContactInfoService;
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
 * Test class for the ContactInfoResource REST controller.
 *
 * @see ContactInfoResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = FoodsourceApp.class)
public class ContactInfoResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_STREET_1 = "AAAAAAAAAA";
    private static final String UPDATED_STREET_1 = "BBBBBBBBBB";

    private static final String DEFAULT_STREET_2 = "AAAAAAAAAA";
    private static final String UPDATED_STREET_2 = "BBBBBBBBBB";

    private static final String DEFAULT_SUBURB = "AAAAAAAAAA";
    private static final String UPDATED_SUBURB = "BBBBBBBBBB";

    private static final String DEFAULT_CITY = "AAAAAAAAAA";
    private static final String UPDATED_CITY = "BBBBBBBBBB";

    private static final String DEFAULT_POSTAL_CODE = "AAAAAAAAAA";
    private static final String UPDATED_POSTAL_CODE = "BBBBBBBBBB";

    private static final String DEFAULT_COUNTRY = "AAAAAAAAAA";
    private static final String UPDATED_COUNTRY = "BBBBBBBBBB";

    private static final String DEFAULT_EMAILADDRESS = "AAAAAAAAAA";
    private static final String UPDATED_EMAILADDRESS = "BBBBBBBBBB";

    private static final String DEFAULT_MOBILE = "AAAAAAAAAA";
    private static final String UPDATED_MOBILE = "BBBBBBBBBB";

    @Autowired
    private ContactInfoRepository contactInfoRepository;

    

    @Autowired
    private ContactInfoService contactInfoService;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restContactInfoMockMvc;

    private ContactInfo contactInfo;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final ContactInfoResource contactInfoResource = new ContactInfoResource(contactInfoService);
        this.restContactInfoMockMvc = MockMvcBuilders.standaloneSetup(contactInfoResource)
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
    public static ContactInfo createEntity(EntityManager em) {
        ContactInfo contactInfo = new ContactInfo()
            .name(DEFAULT_NAME)
            .street1(DEFAULT_STREET_1)
            .street2(DEFAULT_STREET_2)
            .suburb(DEFAULT_SUBURB)
            .city(DEFAULT_CITY)
            .postalCode(DEFAULT_POSTAL_CODE)
            .country(DEFAULT_COUNTRY)
            .emailaddress(DEFAULT_EMAILADDRESS)
            .mobile(DEFAULT_MOBILE);
        return contactInfo;
    }

    @Before
    public void initTest() {
        contactInfo = createEntity(em);
    }

    @Test
    @Transactional
    public void createContactInfo() throws Exception {
        int databaseSizeBeforeCreate = contactInfoRepository.findAll().size();

        // Create the ContactInfo
        restContactInfoMockMvc.perform(post("/api/contact-infos")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(contactInfo)))
            .andExpect(status().isCreated());

        // Validate the ContactInfo in the database
        List<ContactInfo> contactInfoList = contactInfoRepository.findAll();
        assertThat(contactInfoList).hasSize(databaseSizeBeforeCreate + 1);
        ContactInfo testContactInfo = contactInfoList.get(contactInfoList.size() - 1);
        assertThat(testContactInfo.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testContactInfo.getStreet1()).isEqualTo(DEFAULT_STREET_1);
        assertThat(testContactInfo.getStreet2()).isEqualTo(DEFAULT_STREET_2);
        assertThat(testContactInfo.getSuburb()).isEqualTo(DEFAULT_SUBURB);
        assertThat(testContactInfo.getCity()).isEqualTo(DEFAULT_CITY);
        assertThat(testContactInfo.getPostalCode()).isEqualTo(DEFAULT_POSTAL_CODE);
        assertThat(testContactInfo.getCountry()).isEqualTo(DEFAULT_COUNTRY);
        assertThat(testContactInfo.getEmailaddress()).isEqualTo(DEFAULT_EMAILADDRESS);
        assertThat(testContactInfo.getMobile()).isEqualTo(DEFAULT_MOBILE);
    }

    @Test
    @Transactional
    public void createContactInfoWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = contactInfoRepository.findAll().size();

        // Create the ContactInfo with an existing ID
        contactInfo.setId(1L);

        // An entity with an existing ID cannot be created, so this API call must fail
        restContactInfoMockMvc.perform(post("/api/contact-infos")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(contactInfo)))
            .andExpect(status().isBadRequest());

        // Validate the ContactInfo in the database
        List<ContactInfo> contactInfoList = contactInfoRepository.findAll();
        assertThat(contactInfoList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    public void getAllContactInfos() throws Exception {
        // Initialize the database
        contactInfoRepository.saveAndFlush(contactInfo);

        // Get all the contactInfoList
        restContactInfoMockMvc.perform(get("/api/contact-infos?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(contactInfo.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].street1").value(hasItem(DEFAULT_STREET_1.toString())))
            .andExpect(jsonPath("$.[*].street2").value(hasItem(DEFAULT_STREET_2.toString())))
            .andExpect(jsonPath("$.[*].suburb").value(hasItem(DEFAULT_SUBURB.toString())))
            .andExpect(jsonPath("$.[*].city").value(hasItem(DEFAULT_CITY.toString())))
            .andExpect(jsonPath("$.[*].postalCode").value(hasItem(DEFAULT_POSTAL_CODE.toString())))
            .andExpect(jsonPath("$.[*].country").value(hasItem(DEFAULT_COUNTRY.toString())))
            .andExpect(jsonPath("$.[*].emailaddress").value(hasItem(DEFAULT_EMAILADDRESS.toString())))
            .andExpect(jsonPath("$.[*].mobile").value(hasItem(DEFAULT_MOBILE.toString())));
    }
    

    @Test
    @Transactional
    public void getContactInfo() throws Exception {
        // Initialize the database
        contactInfoRepository.saveAndFlush(contactInfo);

        // Get the contactInfo
        restContactInfoMockMvc.perform(get("/api/contact-infos/{id}", contactInfo.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(contactInfo.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()))
            .andExpect(jsonPath("$.street1").value(DEFAULT_STREET_1.toString()))
            .andExpect(jsonPath("$.street2").value(DEFAULT_STREET_2.toString()))
            .andExpect(jsonPath("$.suburb").value(DEFAULT_SUBURB.toString()))
            .andExpect(jsonPath("$.city").value(DEFAULT_CITY.toString()))
            .andExpect(jsonPath("$.postalCode").value(DEFAULT_POSTAL_CODE.toString()))
            .andExpect(jsonPath("$.country").value(DEFAULT_COUNTRY.toString()))
            .andExpect(jsonPath("$.emailaddress").value(DEFAULT_EMAILADDRESS.toString()))
            .andExpect(jsonPath("$.mobile").value(DEFAULT_MOBILE.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingContactInfo() throws Exception {
        // Get the contactInfo
        restContactInfoMockMvc.perform(get("/api/contact-infos/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateContactInfo() throws Exception {
        // Initialize the database
        contactInfoService.save(contactInfo);

        int databaseSizeBeforeUpdate = contactInfoRepository.findAll().size();

        // Update the contactInfo
        ContactInfo updatedContactInfo = contactInfoRepository.findById(contactInfo.getId()).get();
        // Disconnect from session so that the updates on updatedContactInfo are not directly saved in db
        em.detach(updatedContactInfo);
        updatedContactInfo
            .name(UPDATED_NAME)
            .street1(UPDATED_STREET_1)
            .street2(UPDATED_STREET_2)
            .suburb(UPDATED_SUBURB)
            .city(UPDATED_CITY)
            .postalCode(UPDATED_POSTAL_CODE)
            .country(UPDATED_COUNTRY)
            .emailaddress(UPDATED_EMAILADDRESS)
            .mobile(UPDATED_MOBILE);

        restContactInfoMockMvc.perform(put("/api/contact-infos")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(updatedContactInfo)))
            .andExpect(status().isOk());

        // Validate the ContactInfo in the database
        List<ContactInfo> contactInfoList = contactInfoRepository.findAll();
        assertThat(contactInfoList).hasSize(databaseSizeBeforeUpdate);
        ContactInfo testContactInfo = contactInfoList.get(contactInfoList.size() - 1);
        assertThat(testContactInfo.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testContactInfo.getStreet1()).isEqualTo(UPDATED_STREET_1);
        assertThat(testContactInfo.getStreet2()).isEqualTo(UPDATED_STREET_2);
        assertThat(testContactInfo.getSuburb()).isEqualTo(UPDATED_SUBURB);
        assertThat(testContactInfo.getCity()).isEqualTo(UPDATED_CITY);
        assertThat(testContactInfo.getPostalCode()).isEqualTo(UPDATED_POSTAL_CODE);
        assertThat(testContactInfo.getCountry()).isEqualTo(UPDATED_COUNTRY);
        assertThat(testContactInfo.getEmailaddress()).isEqualTo(UPDATED_EMAILADDRESS);
        assertThat(testContactInfo.getMobile()).isEqualTo(UPDATED_MOBILE);
    }

    @Test
    @Transactional
    public void updateNonExistingContactInfo() throws Exception {
        int databaseSizeBeforeUpdate = contactInfoRepository.findAll().size();

        // Create the ContactInfo

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restContactInfoMockMvc.perform(put("/api/contact-infos")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(contactInfo)))
            .andExpect(status().isBadRequest());

        // Validate the ContactInfo in the database
        List<ContactInfo> contactInfoList = contactInfoRepository.findAll();
        assertThat(contactInfoList).hasSize(databaseSizeBeforeUpdate);
    }

    @Test
    @Transactional
    public void deleteContactInfo() throws Exception {
        // Initialize the database
        contactInfoService.save(contactInfo);

        int databaseSizeBeforeDelete = contactInfoRepository.findAll().size();

        // Get the contactInfo
        restContactInfoMockMvc.perform(delete("/api/contact-infos/{id}", contactInfo.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<ContactInfo> contactInfoList = contactInfoRepository.findAll();
        assertThat(contactInfoList).hasSize(databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(ContactInfo.class);
        ContactInfo contactInfo1 = new ContactInfo();
        contactInfo1.setId(1L);
        ContactInfo contactInfo2 = new ContactInfo();
        contactInfo2.setId(contactInfo1.getId());
        assertThat(contactInfo1).isEqualTo(contactInfo2);
        contactInfo2.setId(2L);
        assertThat(contactInfo1).isNotEqualTo(contactInfo2);
        contactInfo1.setId(null);
        assertThat(contactInfo1).isNotEqualTo(contactInfo2);
    }
}
