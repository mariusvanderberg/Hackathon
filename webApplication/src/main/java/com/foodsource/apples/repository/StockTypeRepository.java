package com.foodsource.apples.repository;

import com.foodsource.apples.domain.StockType;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the StockType entity.
 */
@SuppressWarnings("unused")
@Repository
public interface StockTypeRepository extends JpaRepository<StockType, Long> {

}
