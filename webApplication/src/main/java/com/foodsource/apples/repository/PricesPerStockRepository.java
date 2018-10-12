package com.foodsource.apples.repository;

import com.foodsource.apples.domain.PricesPerStock;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the PricesPerStock entity.
 */
@SuppressWarnings("unused")
@Repository
public interface PricesPerStockRepository extends JpaRepository<PricesPerStock, Long> {

}
