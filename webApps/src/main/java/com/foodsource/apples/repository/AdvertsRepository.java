package com.foodsource.apples.repository;

import com.foodsource.apples.domain.Adverts;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the Adverts entity.
 */
@SuppressWarnings("unused")
@Repository
public interface AdvertsRepository extends JpaRepository<Adverts, Long> {

}
